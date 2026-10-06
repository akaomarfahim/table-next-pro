import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/state_views.dart';
import '../../domain/entities/customer.dart';
import '../controllers/customer_list_controller.dart';
import '../widgets/customer_detail_view.dart';
import '../widgets/customer_form_sheet.dart';

/// Customer directory with infinite scroll + search.
/// Tablet/desktop: master–detail. Phone: list → detail route.
class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  final _debouncer = Debouncer();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 400) {
      ref.read(customerListProvider.notifier).loadMore().catchError((Object e) {
        if (mounted) context.showError(e);
      });
    }
  }

  void _open(Customer c) {
    if (context.screenSize.width >= Breakpoints.twoPane) {
      ref.read(selectedCustomerIdProvider.notifier).select(c.id);
    } else {
      context.push(AppRoutes.customer(c.id));
    }
  }

  Future<void> _create() async {
    final created = await CustomerFormSheet.show(context);
    if (created != null && mounted) _open(created);
  }

  @override
  Widget build(BuildContext context) {
    final twoPane = context.screenSize.width >= Breakpoints.twoPane;
    final selectedId = ref.watch(selectedCustomerIdProvider);

    final list = _CustomerListPane(
      scroll: _scroll,
      selectedId: twoPane ? selectedId : null,
      onSearch: (q) => _debouncer.run(
        () => ref.read(customerSearchQueryProvider.notifier).set(q),
      ),
      onTap: _open,
      onCreate: _create,
    );

    return Scaffold(
      floatingActionButton: context.isCompact
          ? FloatingActionButton(
              onPressed: _create,
              tooltip: 'Add customer',
              child: const Icon(Icons.person_add_alt_1_rounded),
            )
          : null,
      body: SafeArea(
        bottom: false,
        child: twoPane
            ? Row(
                children: [
                  SizedBox(
                    width: context.screenClass.isExpanded ? 420 : 360,
                    child: list,
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: selectedId == null
                        ? const EmptyState(
                            icon: Icons.person_search_rounded,
                            title: 'Select a customer',
                            message: 'See contact details, visit stats and past reservations.',
                          )
                        : CustomerDetailView(
                            key: ValueKey(selectedId),
                            customerId: selectedId,
                            onDeleted: () =>
                                ref.read(selectedCustomerIdProvider.notifier).select(null),
                          ),
                  ),
                ],
              )
            : list,
      ),
    );
  }
}

class _CustomerListPane extends ConsumerWidget {
  const _CustomerListPane({
    required this.scroll,
    required this.selectedId,
    required this.onSearch,
    required this.onTap,
    required this.onCreate,
  });

  final ScrollController scroll;
  final String? selectedId;
  final ValueChanged<String> onSearch;
  final ValueChanged<Customer> onTap;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customerListProvider);
    final padding = context.pagePadding;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(padding.left, padding.top, padding.right, AppSpacing.md),
          child: PageHeader(
            title: 'Customers',
            subtitle: 'Recently active first',
            actions: [
              if (!context.isCompact)
                FilledButton.icon(
                  onPressed: onCreate,
                  icon: const Icon(Icons.person_add_alt_1_rounded),
                  label: const Text('Add'),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding.left),
          child: AppSearchField(
            hint: 'Search phone or name…',
            onChanged: onSearch,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: state.when(
            skipLoadingOnRefresh: true,
            loading: () => const SkeletonList(),
            error: (e, _) => ErrorState(
              error: e,
              onRetry: () => ref.invalidate(customerListProvider),
            ),
            data: (s) {
              if (s.items.isEmpty) {
                return EmptyState(
                  icon: s.query.isEmpty ? Icons.people_outline_rounded : Icons.search_off_rounded,
                  title: s.query.isEmpty ? 'No customers yet' : 'No match for “${s.query}”',
                  message: s.query.isEmpty
                      ? 'Customers are created automatically with reservations, or add one now.'
                      : 'Search matches the start of a phone number or name.',
                  action: FilledButton.icon(
                    onPressed: onCreate,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add customer'),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () => ref.refresh(customerListProvider.future),
                child: ListView.builder(
                  controller: scroll,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    padding.left - AppSpacing.sm,
                    0,
                    padding.right - AppSpacing.sm,
                    96,
                  ),
                  itemCount: s.items.length + (s.hasMore || s.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, i) {
                    if (i >= s.items.length) {
                      return const Padding(
                        padding: EdgeInsets.all(AppSpacing.lg),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final c = s.items[i];
                    return _CustomerTile(
                      customer: c,
                      selected: c.id == selectedId,
                      onTap: () => onTap(c),
                    ).animate().fadeIn(duration: 200.ms);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CustomerTile extends StatelessWidget {
  const _CustomerTile({required this.customer, required this.selected, required this.onTap});

  final Customer customer;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = customer;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        selected: selected,
        selectedTileColor: context.colors.primary.withValues(alpha: 0.08),
        onTap: onTap,
        leading: InitialsAvatar(name: c.name, size: 44),
        title: Row(
          children: [
            Flexible(child: Text(c.name, maxLines: 1, overflow: TextOverflow.ellipsis)),
            if (c.isVip) ...[
              const SizedBox(width: 4),
              Icon(Icons.star_rounded, size: 16, color: context.palette.warning),
            ],
          ],
        ),
        subtitle: Text(PhoneUtils.display(c.phone)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${c.visitCount} visits',
              style: context.text.labelMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            if (c.updatedAt != null)
              Text(
                Formatters.timeAgo(c.updatedAt!),
                style: context.text.labelSmall?.copyWith(color: context.palette.textMuted),
              ),
          ],
        ),
      ),
    );
  }
}
