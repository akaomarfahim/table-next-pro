import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../domain/entities/customer.dart';
import '../controllers/customer_list_controller.dart';

/// Create / edit a customer. Pops with the saved [Customer].
class CustomerFormSheet extends ConsumerStatefulWidget {
  const CustomerFormSheet({super.key, this.customer, this.initialPhone, this.initialName});

  final Customer? customer;
  final String? initialPhone;
  final String? initialName;

  static Future<Customer?> show(
    BuildContext context, {
    Customer? customer,
    String? initialPhone,
    String? initialName,
  }) =>
      showAdaptiveSheet<Customer>(
        context: context,
        builder: (_) => CustomerFormSheet(
          customer: customer,
          initialPhone: initialPhone,
          initialName: initialName,
        ),
      );

  @override
  ConsumerState<CustomerFormSheet> createState() => _CustomerFormSheetState();
}

class _CustomerFormSheetState extends ConsumerState<CustomerFormSheet> {
  static const _presetTags = [
    'Regular',
    'Family',
    'Corporate',
    'Vegetarian',
    'Allergy',
    'Window seat',
    'Quiet area',
  ];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name =
      TextEditingController(text: widget.customer?.name ?? widget.initialName);
  late final TextEditingController _phone =
      TextEditingController(text: widget.customer?.phone ?? widget.initialPhone);
  late final TextEditingController _email =
      TextEditingController(text: widget.customer?.email);
  late final TextEditingController _notes =
      TextEditingController(text: widget.customer?.notes);
  late Set<String> _tags = {...?widget.customer?.tags};
  late bool _vip = widget.customer?.isVip ?? false;
  late DateTime? _birthday = widget.customer?.birthday;
  bool _saving = false;

  bool get _isEdit => widget.customer != null;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final repo = ref.read(customerRepositoryProvider);
    try {
      final base = widget.customer ??
          Customer(id: '', name: '', phone: '');
      final draft = base.copyWith(
        name: _name.text.trim(),
        phone: _phone.text.trim(),
        email: _email.text.trim(),
        notes: _notes.text.trim(),
        tags: _tags.toList(),
        isVip: _vip,
        birthday: _birthday,
      );
      final Customer saved;
      if (_isEdit) {
        await repo.update(draft);
        saved = draft.copyWith(updatedAt: DateTime.now());
      } else {
        saved = await repo.create(draft);
      }
      if (ref.exists(customerListProvider)) {
        ref.read(customerListProvider.notifier).upsertLocal(saved);
      }
      if (!mounted) return;
      Navigator.of(context).pop(saved);
      context.showSnack(_isEdit ? 'Customer updated' : 'Customer added');
    } catch (e) {
      if (mounted) context.showError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppSpacing.md);
    return SheetScaffold(
      title: _isEdit ? 'Edit customer' : 'New customer',
      subtitle: 'Phone number is required and must be unique',
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        LoadingButton(label: 'Save customer', loading: _saving, onPressed: _save),
      ],
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              autofocus: !_isEdit && (widget.initialPhone?.isEmpty ?? true),
              decoration: const InputDecoration(
                labelText: 'Phone *',
                prefixIcon: Icon(Icons.call_outlined),
              ),
              validator: (v) => PhoneUtils.isValid(v ?? '') ? null : 'Enter a valid phone number',
            ),
            gap,
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Full name *',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            gap,
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return null;
                return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)
                    ? null
                    : 'Invalid email';
              },
            ),
            gap,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _birthday ?? DateTime(now.year - 30),
                        firstDate: DateTime(1920),
                        lastDate: now,
                        helpText: 'Birthday',
                      );
                      if (picked != null) setState(() => _birthday = picked);
                    },
                    icon: const Icon(Icons.cake_outlined),
                    label: Text(
                      _birthday == null ? 'Add birthday' : Formatters.dayShort(_birthday!),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: FilterChip(
                    avatar: Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: _vip ? context.palette.warning : context.palette.textMuted,
                    ),
                    label: const Text('VIP guest'),
                    selected: _vip,
                    showCheckmark: false,
                    onSelected: (v) => setState(() => _vip = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Tags', style: context.text.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final tag in {..._presetTags, ..._tags})
                  FilterChip(
                    label: Text(tag),
                    selected: _tags.contains(tag),
                    onSelected: (v) => setState(() {
                      _tags = v ? {..._tags, tag} : (_tags..remove(tag)).toSet();
                    }),
                  ),
                ActionChip(
                  avatar: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Custom'),
                  onPressed: () async {
                    final tag = await showTextPrompt(
                      context,
                      title: 'Add tag',
                      confirmLabel: 'Add',
                      validator: (v) => v.trim().isEmpty ? 'Required' : null,
                    );
                    if (tag != null) setState(() => _tags = {..._tags, tag});
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            TextFormField(
              controller: _notes,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Notes (allergies, preferences…)',
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
