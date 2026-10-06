import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../../business/domain/entities/business.dart';
import '../../../reservations/presentation/controllers/reservation_providers.dart';
import '../../../reservations/presentation/widgets/date_strip.dart';
import '../../domain/entities/bill.dart';
import '../controllers/billing_providers.dart';
import '../widgets/new_bill_sheet.dart';

enum _BillingTab { open, history }

class BillingScreen extends ConsumerStatefulWidget {
  const BillingScreen({super.key});

  @override
  ConsumerState<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends ConsumerState<BillingScreen> {
  _BillingTab _tab = _BillingTab.open;

  Future<void> _newBill() async {
    final id = await NewBillSheet.show(context);
    if (id != null && mounted) context.go(AppRoutes.bill(id));
  }

  @override
  Widget build(BuildContext context) {
    final business = ref.watch(currentBusinessProvider);
    final open = ref.watch(openBillsProvider);
    final openTotal = (open.value ?? const <Bill>[]).fold<double>(0, (s, b) => s + b.totals.total);
    final padding = context.pagePadding;

    return Scaffold(
      floatingActionButton: context.isCompact
          ? FloatingActionButton.extended(
              onPressed: _newBill,
              icon: const Icon(Icons.add_rounded),
              label: const Text('New bill'),
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
                title: 'Billing',
                subtitle: '${open.value?.length ?? 0} open · ${business?.money(openTotal) ?? ''} pending',
                actions: [
                  SegmentedButton<_BillingTab>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: _BillingTab.open, icon: Icon(Icons.receipt_rounded), label: Text('Open')),
                      ButtonSegment(value: _BillingTab.history, icon: Icon(Icons.history_rounded), label: Text('History')),
                    ],
                    selected: {_tab},
                    onSelectionChanged: (s) => setState(() => _tab = s.first),
                  ),
                  if (!context.isCompact)
                    FilledButton.icon(
                      onPressed: _newBill,
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('New bill'),
                    ),
                ],
              ),
            ),
            Expanded(
              child: business == null
                  ? const SizedBox.shrink()
                  : _tab == _BillingTab.open
                      ? _OpenBills(business: business, onNew: _newBill)
                      : _History(business: business),
            ),
          ],
        ),
      ),
    );
  }
}

class _OpenBills extends ConsumerWidget {
  const _OpenBills({required this.business, required this.onNew});

  final Business business;
  final VoidCallback onNew;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final open = ref.watch(openBillsProvider);
    final now = ref.watch(minuteTickerProvider).value ?? DateTime.now();
    final padding = context.pagePadding;

    return AsyncValueView<List<Bill>>(
      value: open,
      loading: const SkeletonGrid(),
      onRetry: () => ref.invalidate(openBillsProvider),
      data: (bills) {
        if (bills.isEmpty) {
          return EmptyState(
            icon: Icons.receipt_long_rounded,
            title: 'No open bills',
            message: 'Start a bill from a table on the floor, a seated reservation, or here.',
            action: FilledButton.icon(
              onPressed: onNew,
              icon: const Icon(Icons.add_rounded),
              label: const Text('New bill'),
            ),
          );
        }
        return LayoutBuilder(
          builder: (context, c) {
            final cols = adaptiveColumns(c.maxWidth, minTileWidth: 280, maxColumns: 4);
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(padding.left, 0, padding.right, 96),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                mainAxisExtent: 156,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
              ),
              itemCount: bills.length,
              itemBuilder: (context, i) {
                final b = bills[i];
                final elapsed = b.createdAt == null ? null : now.difference(b.createdAt!);
                final long = elapsed != null && elapsed.inMinutes > 120;
                return AppCard(
                  onTap: () => context.go(AppRoutes.bill(b.id)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.colors.primary.withValues(alpha: 0.12),
                              borderRadius: AppRadius.smAll,
                            ),
                            child: Icon(
                              switch (b.orderType) {
                                OrderType.dineIn => Icons.table_restaurant_rounded,
                                OrderType.takeaway => Icons.takeout_dining_rounded,
                                OrderType.delivery => Icons.delivery_dining_rounded,
                              },
                              size: 18,
                              color: context.colors.primary,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              b.title,
                              style: context.text.titleSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '#${b.billNumber}',
                            style: context.text.labelSmall?.copyWith(color: context.palette.textMuted),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        business.money(b.totals.total),
                        style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            '${b.itemCount} items · ${b.guests} guests',
                            style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                          ),
                          const Spacer(),
                          if (elapsed != null)
                            StatusBadge(
                              label: Formatters.duration(elapsed),
                              color: long ? context.palette.warning : context.palette.info,
                              icon: Icons.timer_outlined,
                              dense: true,
                            ),
                        ],
                      ),
                    ],
                  ),
                ).animate(delay: (30 * i).ms).fadeIn(duration: 200.ms).scaleXY(begin: 0.98, end: 1);
              },
            );
          },
        );
      },
    );
  }
}

class _History extends ConsumerWidget {
  const _History({required this.business});

  final Business business;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(billHistoryDateProvider);
    final bills = ref.watch(closedBillsForDayProvider(day));
    final padding = context.pagePadding;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding.left),
          child: DateStrip(
            selected: day,
            showStrip: false,
            onChanged: (d) => ref.read(billHistoryDateProvider.notifier).set(d),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: AsyncValueView<List<Bill>>(
            value: bills,
            loading: const SkeletonList(),
            onRetry: () => ref.invalidate(closedBillsForDayProvider(day)),
            data: (list) {
              final paid = list.where((b) => b.status == BillStatus.paid).toList();
              final revenue = paid.fold<double>(0, (s, b) => s + b.totals.total);
              final guests = paid.fold<int>(0, (s, b) => s + b.guests);
              if (list.isEmpty) {
                return const EmptyState(
                  icon: Icons.history_rounded,
                  title: 'No closed bills',
                  message: 'Settled and voided bills for this day appear here.',
                );
              }
              return ListView(
                padding: EdgeInsets.fromLTRB(padding.left, 0, padding.right, 96),
                children: [
                  LayoutBuilder(
                    builder: (context, c) {
                      final cols = context.isCompact ? 2 : 4;
                      final w = (c.maxWidth - AppSpacing.md * (cols - 1)) / cols;
                      return Wrap(
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.md,
                        children: [
                          SizedBox(
                            width: w,
                            child: StatCard(icon: Icons.payments_rounded, label: 'Revenue', value: business.money(revenue)),
                          ),
                          SizedBox(
                            width: w,
                            child: StatCard(
                              icon: Icons.receipt_long_rounded,
                              label: 'Bills paid',
                              value: '${paid.length}',
                              color: context.colors.secondary,
                            ),
                          ),
                          SizedBox(
                            width: w,
                            child: StatCard(
                              icon: Icons.people_alt_rounded,
                              label: 'Guests',
                              value: '$guests',
                              color: context.palette.info,
                            ),
                          ),
                          SizedBox(
                            width: w,
                            child: StatCard(
                              icon: Icons.analytics_rounded,
                              label: 'Avg. bill',
                              value: business.money(paid.isEmpty ? 0 : revenue / paid.length),
                              color: context.palette.violet,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  for (final b in list)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppCard(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                        onTap: () => context.go(AppRoutes.bill(b.id)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('#${b.billNumber} · ${b.title}', style: context.text.titleSmall),
                                  Text(
                                    [
                                      if (b.closedAt != null) Formatters.time(b.closedAt!),
                                      if (b.payments.isNotEmpty) b.payments.map((p) => p.method.label).toSet().join(' + '),
                                      if (b.closedByName != null) b.closedByName!,
                                    ].join(' · '),
                                    style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                                  ),
                                ],
                              ),
                            ),
                            if (b.status == BillStatus.voided)
                              StatusBadge(label: 'Void', color: context.palette.danger, dense: true)
                            else
                              Text(
                                business.money(b.totals.total),
                                style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
