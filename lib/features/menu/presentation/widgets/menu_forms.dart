import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../data/repositories/menu_repository_impl.dart';
import '../../domain/entities/menu_entities.dart';

/// Create / edit a menu item.
class MenuItemFormSheet extends ConsumerStatefulWidget {
  const MenuItemFormSheet({
    super.key,
    required this.categories,
    this.item,
    this.initialCategoryId,
    this.nextSortOrder = 0,
  });

  final List<MenuCategory> categories;
  final MenuProduct? item;
  final String? initialCategoryId;
  final int nextSortOrder;

  static Future<void> show(
    BuildContext context, {
    required List<MenuCategory> categories,
    MenuProduct? item,
    String? initialCategoryId,
    int nextSortOrder = 0,
  }) =>
      showAdaptiveSheet<void>(
        context: context,
        builder: (_) => MenuItemFormSheet(
          categories: categories,
          item: item,
          initialCategoryId: initialCategoryId,
          nextSortOrder: nextSortOrder,
        ),
      );

  @override
  ConsumerState<MenuItemFormSheet> createState() => _MenuItemFormSheetState();
}

class _MenuItemFormSheetState extends ConsumerState<MenuItemFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.item?.name);
  late final _price = TextEditingController(
    text: widget.item == null ? '' : widget.item!.price.toStringAsFixed(2),
  );
  late final _code = TextEditingController(text: widget.item?.code);
  late final _description = TextEditingController(text: widget.item?.description);
  late String? _categoryId = widget.item?.categoryId ??
      widget.initialCategoryId ??
      (widget.categories.isEmpty ? null : widget.categories.first.id);
  late bool _available = widget.item?.available ?? true;
  late bool _veg = widget.item?.isVeg ?? false;
  late bool _spicy = widget.item?.isSpicy ?? false;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _code.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    try {
      final base = widget.item ??
          MenuProduct(
            id: '',
            categoryId: _categoryId!,
            name: '',
            price: 0,
            sortOrder: widget.nextSortOrder,
          );
      await ref.read(menuRepositoryProvider).saveItem(
            base.copyWith(
              categoryId: _categoryId!,
              name: _name.text.trim(),
              price: double.parse(_price.text),
              code: _code.text.trim(),
              description: _description.text.trim(),
              available: _available,
              isVeg: _veg,
              isSpicy: _spicy,
            ),
          );
      if (!mounted) return;
      Navigator.of(context).pop();
      context.showSnack(widget.item == null ? 'Item added' : 'Item updated');
    } catch (e) {
      if (mounted) context.showError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    final ok = await showConfirmDialog(
      context,
      title: 'Delete ${widget.item!.name}?',
      message: 'Existing bills keep the item name and price.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!ok) return;
    try {
      await ref.read(menuRepositoryProvider).deleteItem(widget.item!.id);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) context.showError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppSpacing.md);
    return SheetScaffold(
      title: widget.item == null ? 'New menu item' : 'Edit menu item',
      actions: [
        if (widget.item != null)
          TextButton(
            style: TextButton.styleFrom(foregroundColor: context.palette.danger),
            onPressed: _saving ? null : _delete,
            child: const Text('Delete'),
          ),
        OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        LoadingButton(label: 'Save', loading: _saving, onPressed: _save),
      ],
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _categoryId,
              decoration: const InputDecoration(labelText: 'Category'),
              items: [
                for (final c in widget.categories)
                  DropdownMenuItem(value: c.id, child: Text(c.name)),
              ],
              validator: (v) => v == null ? 'Choose a category' : null,
              onChanged: (v) => setState(() => _categoryId = v),
            ),
            gap,
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _price,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                    decoration: const InputDecoration(labelText: 'Price'),
                    validator: (v) => double.tryParse(v ?? '') == null ? 'Enter a price' : null,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextFormField(
                    controller: _code,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(labelText: 'Short code (optional)'),
                  ),
                ),
              ],
            ),
            gap,
            TextFormField(
              controller: _description,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            gap,
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                FilterChip(
                  label: const Text('Available'),
                  selected: _available,
                  onSelected: (v) => setState(() => _available = v),
                ),
                FilterChip(
                  avatar: Icon(Icons.eco_rounded, size: 16, color: context.palette.success),
                  label: const Text('Vegetarian'),
                  selected: _veg,
                  onSelected: (v) => setState(() => _veg = v),
                ),
                FilterChip(
                  avatar: Icon(Icons.local_fire_department_rounded, size: 16, color: context.palette.danger),
                  label: const Text('Spicy'),
                  selected: _spicy,
                  onSelected: (v) => setState(() => _spicy = v),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
