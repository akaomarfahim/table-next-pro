import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../domain/entities/customer.dart';

/// Text field with live customer suggestions (by phone or by name).
///
/// Uses debounced Firestore prefix queries limited to 8 results, so each
/// suggestion round costs at most 8 document reads.
class CustomerAutocompleteField extends ConsumerStatefulWidget {
  const CustomerAutocompleteField({
    super.key,
    required this.controller,
    required this.onSelected,
    this.focusNode,
    this.label = 'Phone',
    this.hint,
    this.icon = Icons.call_outlined,
    this.phoneMode = true,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<Customer> onSelected;
  final ValueChanged<String>? onChanged;
  final String label;
  final String? hint;
  final IconData icon;
  final bool phoneMode;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool autofocus;

  @override
  ConsumerState<CustomerAutocompleteField> createState() =>
      _CustomerAutocompleteFieldState();
}

class _CustomerAutocompleteFieldState extends ConsumerState<CustomerAutocompleteField> {
  late final FocusNode _focusNode = widget.focusNode ?? FocusNode();
  String _latestQuery = '';
  bool _searching = false;

  @override
  void dispose() {
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  Future<Iterable<Customer>> _search(TextEditingValue value) async {
    final query = value.text.trim();
    _latestQuery = query;
    // Programmatic fills (e.g. selecting a guest in another field) must not
    // trigger paid Firestore searches.
    if (!_focusNode.hasFocus) return const <Customer>[];
    final minLength = widget.phoneMode ? 3 : 2;
    if (query.length < minLength) return const <Customer>[];
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (_latestQuery != query || !mounted) return const <Customer>[];
    setState(() => _searching = true);
    try {
      return await ref.read(customerRepositoryProvider).search(query, limit: 8);
    } catch (_) {
      return const <Customer>[];
    } finally {
      if (mounted) setState(() => _searching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RawAutocomplete<Customer>(
        textEditingController: widget.controller,
        focusNode: _focusNode,
        displayStringForOption: (c) => widget.phoneMode ? c.phone : c.name,
        optionsBuilder: _search,
        onSelected: widget.onSelected,
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) => TextFormField(
          controller: controller,
          focusNode: focusNode,
          autofocus: widget.autofocus,
          keyboardType: widget.phoneMode ? TextInputType.phone : TextInputType.name,
          textCapitalization:
              widget.phoneMode ? TextCapitalization.none : TextCapitalization.words,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: (_) => onFieldSubmitted(),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            prefixIcon: Icon(widget.icon),
            suffixIcon: _searching
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : const Icon(Icons.manage_search_rounded),
          ),
        ),
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Material(
              elevation: 8,
              shadowColor: Colors.black26,
              color: context.colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.mdAll,
                side: BorderSide(color: context.palette.border),
              ),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 320,
                  maxWidth: constraints.maxWidth,
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  shrinkWrap: true,
                  itemCount: options.length,
                  separatorBuilder: (_, _) => const Divider(height: 1, indent: 64),
                  itemBuilder: (context, i) {
                    final c = options.elementAt(i);
                    return ListTile(
                      dense: true,
                      leading: InitialsAvatar(name: c.name, size: 36),
                      title: Row(
                        children: [
                          Flexible(child: Text(c.name, overflow: TextOverflow.ellipsis)),
                          if (c.isVip) ...[
                            const SizedBox(width: 6),
                            Icon(Icons.star_rounded, size: 16, color: context.palette.warning),
                          ],
                        ],
                      ),
                      subtitle: Text(
                        '${PhoneUtils.display(c.phone)} · ${c.visitCount} visits',
                      ),
                      onTap: () => onSelected(c),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
