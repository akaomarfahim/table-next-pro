import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../auth/domain/entities/user_role.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../data/repositories/menu_repository_impl.dart';
import '../../domain/entities/menu_entities.dart';
import '../controllers/menu_providers.dart';
import '../widgets/menu_forms.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  String? _categoryId;
  String _query = '';

  Future<void> _addCategory(int count) async {
    final name = await showTextPrompt(
      context,
      title: 'New category',
      label: 'Name (e.g. Starters)',
      confirmLabel: 'Create',
      validator: (v) => v.trim().isEmpty ? 'Required' : null,
    );
    if (name == null) return;
    try {
      await ref
          .read(menuRepositoryProvider)
          .saveCategory(MenuCategory(id: '', name: name, sortOrder: count));
    } catch (e) {
      if (mounted) context.showError(e);
    }
  }

  Future<void> _categoryAction(MenuCategory c, String action) async {
    final repo = ref.read(menuRepositoryProvider);
    try {
      if (action == 'rename') {
        final name = await showTextPrompt(
          context,
          title: 'Rename category',
          initialValue: c.name,
          validator: (v) => v.trim().isEmpty ? 'Required' : null,
        );
        if (name != null) await repo.saveCategory(c.copyWith(name: name));
      } else if (action == 'delete') {
        final ok = await showConfirmDialog(
          context,
          title: 'Delete "${c.name}"?',
          message: 'Only empty categories can be deleted.',
          confirmLabel: 'Delete',
          destructive: true,
        );
        if (ok) {
          await repo.deleteCategory(c.id);
          if (_categoryId == c.id) setState(() => _categoryId = null);
        }
      }
    } catch (e) {
      if (mounted) context.showError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canEdit = ref.watch(hasPermissionProvider(Permission.manageMenu));
    final categoriesAsync = ref.watch(menuCategoriesProvider);
    final itemsAsync = ref.watch(menuItemsProvider);
    final business = ref.watch(currentBusinessProvider);
    final categories = categoriesAsync.value ?? const <MenuCategory>[];
    final items = itemsAsync.value ?? const <MenuProduct>[];
    final twoPane = context.screenSize.width >= Breakpoints.twoPane;

    final selectedId = _categoryId ?? (categories.isEmpty ? null : categories.first.id);
    final visible = items.where((i) {
      if (_query.isNotEmpty) {
        return i.name.toLowerCase().contains(_query) || i.code.toLowerCase() == _query;
      }
      return i.categoryId == selectedId;
    }).toList();

    final padding = context.pagePadding;

    Widget categoryList() => ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            for (final c in categories)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: ListTile(
                  selected: c.id == selectedId && _query.isEmpty,
                  selectedTileColor: context.colors.primary.withValues(alpha: 0.1),
                  title: Text(c.name),
                  subtitle: Text('${items.where((i) => i.categoryId == c.id).length} items'),
                  onTap: () => setState(() {
                    _categoryId = c.id;
                    _query = '';
                  }),
                  trailing: canEdit
                      ? PopupMenuButton<String>(
                          onSelected: (a) => _categoryAction(c, a),
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: 'rename', child: Text('Rename')),
                            PopupMenuItem(value: 'delete', child: Text('Delete')),
                          ],
                        )
                      : null,
                ),
              ),
            if (canEdit)
              TextButton.icon(
                onPressed: () => _addCategory(categories.length),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add category'),
              ),
          ],
        );

    Widget itemsGrid() {
      if (categories.isEmpty) {
        return EmptyState(
          icon: Icons.restaurant_menu_rounded,
          title: 'Build your menu',
          message: 'Create categories (Starters, Mains, Drinks…) and add items with prices.',
          action: canEdit
              ? FilledButton.icon(
                  onPressed: () => _addCategory(0),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Add category'),
                )
              : null,
        );
      }
      if (visible.isEmpty) {
        return EmptyState(
          icon: Icons.fastfood_outlined,
          title: _query.isEmpty ? 'No items in this category' : 'No items match',
          compact: true,
        );
      }
      return LayoutBuilder(
        builder: (context, c) {
          final cols = adaptiveColumns(c.maxWidth, minTileWidth: 260, maxColumns: 4);
          return GridView.builder(
            padding: EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 96),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              mainAxisExtent: 116,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
            ),
            itemCount: visible.length,
            itemBuilder: (context, i) {
              final item = visible[i];
              return _MenuItemCard(
                item: item,
                price: business?.money(item.price) ?? item.price.toStringAsFixed(2),
                canEdit: canEdit,
                onTap: canEdit
                    ? () => MenuItemFormSheet.show(context, categories: categories, item: item)
                    : null,
              ).animate(delay: (20 * i).ms).fadeIn(duration: 200.ms);
            },
          );
        },
      );
    }

    final loading = (categoriesAsync.isLoading && !categoriesAsync.hasValue) ||
        (itemsAsync.isLoading && !itemsAsync.hasValue);

    return Scaffold(
      floatingActionButton: canEdit && categories.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => MenuItemFormSheet.show(
                context,
                categories: categories,
                initialCategoryId: selectedId,
                nextSortOrder: items.length,
              ),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add item'),
            )
          : null,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(padding.left, padding.top, padding.right, AppSpacing.md),
              child: PageHeader(
                title: 'Menu',
                subtitle: '${items.length} items · ${categories.length} categories',
                actions: [
                  SizedBox(
                    width: context.isCompact ? double.infinity : 280,
                    child: AppSearchField(
                      hint: 'Search items or code',
                      onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
                    ),
                  ),
                ],
              ),
            ),
            if (!twoPane && categories.isNotEmpty)
              SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: padding.left),
                  children: [
                    for (final c in categories)
                      Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.sm),
                        child: ChoiceChip(
                          label: Text(c.name),
                          selected: c.id == selectedId && _query.isEmpty,
                          onSelected: (_) => setState(() {
                            _categoryId = c.id;
                            _query = '';
                          }),
                        ),
                      ),
                    if (canEdit)
                      ActionChip(
                        avatar: const Icon(Icons.add_rounded, size: 18),
                        label: const Text('Category'),
                        onPressed: () => _addCategory(categories.length),
                      ),
                  ],
                ),
              ),
            Expanded(
              child: loading
                  ? const SkeletonGrid()
                  : twoPane && categories.isNotEmpty
                      ? Row(
                          children: [
                            SizedBox(width: 260, child: categoryList()),
                            const VerticalDivider(width: 1),
                            Expanded(child: itemsGrid()),
                          ],
                        )
                      : itemsGrid(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItemCard extends ConsumerWidget {
  const _MenuItemCard({
    required this.item,
    required this.price,
    required this.canEdit,
    this.onTap,
  });

  final MenuProduct item;
  final String price;
  final bool canEdit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Opacity(
      opacity: item.available ? 1 : 0.55,
      child: AppCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.titleSmall,
                  ),
                ),
                if (item.isVeg) Icon(Icons.eco_rounded, size: 16, color: context.palette.success),
                if (item.isSpicy)
                  Icon(Icons.local_fire_department_rounded, size: 16, color: context.palette.danger),
              ],
            ),
            if (item.description.isNotEmpty)
              Text(
                item.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
              ),
            const Spacer(),
            Row(
              children: [
                Text(price, style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                if (item.code.isNotEmpty) ...[
                  const SizedBox(width: AppSpacing.sm),
                  StatusBadge(label: item.code, color: context.palette.textMuted, dense: true),
                ],
                const Spacer(),
                if (canEdit)
                  Switch.adaptive(
                    value: item.available,
                    onChanged: (v) => ref
                        .read(menuRepositoryProvider)
                        .setAvailability(item.id, available: v)
                        .catchError((Object e) {
                      if (context.mounted) context.showError(e);
                    }),
                  )
                else if (!item.available)
                  StatusBadge(label: 'Sold out', color: context.palette.danger, dense: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
