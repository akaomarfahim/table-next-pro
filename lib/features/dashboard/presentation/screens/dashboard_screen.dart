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
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../../billing/domain/entities/bill.dart';
import '../../../billing/presentation/controllers/billing_providers.dart';
import '../../../billing/presentation/widgets/new_bill_sheet.dart';
import '../../../customers/presentation/widgets/customer_form_sheet.dart';
import '../../../floor_plan/presentation/controllers/floor_providers.dart';
import '../../../floor_plan/presentation/controllers/table_status_provider.dart';
import '../../../reservations/domain/entities/reservation.dart';
import '../../../reservations/presentation/controllers/reservation_providers.dart';
import '../../../reservations/presentation/widgets/reservation_status_style.dart';
import '../../data/repositories/stats_repository_impl.dart';
import '../../domain/entities/daily_stats.dart';
import '../widgets/revenue_bar_chart.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _greeting(DateTime now) {
    if (now.hour < 12) return 'Good morning';
    if (now.hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final business = ref.watch(currentBusinessProvider);
    final now = ref.watch(minuteTickerProvider).value ?? DateTime.now();
    final reservations = ref.watch(todayReservationsProvider).value ?? const <Reservation>[];
    final openBills = ref.watch(openBillsProvider).value ?? const <Bill>[];
    final weekly = ref.watch(weeklyStatsProvider).value ?? const <DailyStats>[];
    final tables = ref.watch(allTablesProvider).value ?? const [];
    final statuses = ref.watch(tableStatusesProvider);

    String money(num v) => business?.money(v) ?? v.toStringAsFixed(2);
    final today = weekly.isEmpty ? DailyStats(date: now) : weekly.last;
    final active = reservations.where((r) => r.status != ReservationStatus.cancelled).toList();
    final covers = active.fold<int>(0, (s, r) => s + r.partySize);
    final upcoming = reservations
        .where((r) =>
            (r.status == ReservationStatus.pending || r.status == ReservationStatus.confirmed) &&
            r.endAt.isAfter(now))
        .take(6)
        .toList();
    final occupied = statuses.values.where((s) => s.status == TableStatus.occupied).length;
    final openValue = openBills.fold<double>(0, (s, b) => s + b.totals.total);
    final weekRevenue = weekly.fold<double>(0, (s, d) => s + d.revenue);

    final kpis = [
      StatCard(
        icon: Icons.payments_rounded,
        label: "Today's revenue",
        value: money(today.revenue),
        footer: '${today.bills} bills · avg ${money(today.averageBill)}',
        onTap: () => context.go(AppRoutes.billing),
      ),
      StatCard(
        icon: Icons.event_available_rounded,
        label: 'Reservations today',
        value: '${active.length}',
        footer: '$covers covers expected',
        color: context.palette.info,
        onTap: () => context.go(AppRoutes.reservations),
      ),
      StatCard(
        icon: Icons.table_restaurant_rounded,
        label: 'Tables occupied',
        value: '$occupied / ${tables.length}',
        footer: tables.isEmpty ? 'Set up your floor plan' : '${tables.length - occupied} free now',
        color: context.colors.secondary,
        onTap: () => context.go(AppRoutes.floor),
      ),
      StatCard(
        icon: Icons.receipt_long_rounded,
        label: 'Open bills',
        value: '${openBills.length}',
        footer: '${money(openValue)} pending',
        color: context.palette.violet,
        onTap: () => context.go(AppRoutes.billing),
      ),
    ];

    final quickActions = Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        FilledButton.icon(
          onPressed: () => context.go(AppRoutes.newReservation),
          icon: const Icon(Icons.event_available_rounded),
          label: const Text('New reservation'),
        ),
        FilledButton.tonalIcon(
          onPressed: () async {
            final id = await NewBillSheet.show(context);
            if (id != null && context.mounted) context.go(AppRoutes.bill(id));
          },
          icon: const Icon(Icons.point_of_sale_rounded),
          label: const Text('New bill'),
        ),
        OutlinedButton.icon(
          onPressed: () => CustomerFormSheet.show(context),
          icon: const Icon(Icons.person_add_alt_1_rounded),
          label: const Text('Add customer'),
        ),
        OutlinedButton.icon(
          onPressed: () => context.go(AppRoutes.floor),
          icon: const Icon(Icons.grid_view_rounded),
          label: const Text('Live floor'),
        ),
      ],
    );

    final chart = SectionCard(
      title: 'Revenue · last 7 days',
      subtitle: money(weekRevenue),
      icon: Icons.bar_chart_rounded,
      child: SizedBox(
        height: 220,
        child: weekly.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : RevenueBarChart(days: weekly, format: money),
      ),
    );

    final upcomingCard = SectionCard(
      title: 'Up next',
      subtitle: '${upcoming.length} arriving',
      icon: Icons.schedule_rounded,
      trailing: TextButton(
        onPressed: () => context.go(AppRoutes.reservations),
        child: const Text('View all'),
      ),
      child: upcoming.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Text(
                'No more arrivals today.',
                style: context.text.bodyMedium?.copyWith(color: context.palette.textMuted),
              ),
            )
          : Column(
              children: [
                for (final r in upcoming)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () => context.go(AppRoutes.reservation(r.id)),
                    leading: Container(
                      width: 56,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: r.status.color(context).withValues(alpha: 0.12),
                        borderRadius: AppRadius.mdAll,
                      ),
                      child: Text(
                        Formatters.time(r.startAt).replaceAll(' ', '\n'),
                        textAlign: TextAlign.center,
                        style: context.text.labelSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: r.status.color(context),
                        ),
                      ),
                    ),
                    title: Text(r.customerName, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text('${r.partySize} guests · ${r.tablesLabel}'),
                    trailing: r.isLate
                        ? StatusBadge(label: 'Late', color: context.palette.danger, dense: true)
                        : StatusBadge(label: r.status.label, color: r.status.color(context), dense: true),
                  ),
              ],
            ),
    );

    final breakdown = SectionCard(
      title: 'Today at a glance',
      icon: Icons.insights_rounded,
      child: Column(
        children: [
          KeyValueRow(label: 'Guests served', value: '${today.guests}'),
          KeyValueRow(label: 'Discounts given', value: money(today.discounts)),
          KeyValueRow(label: 'VAT collected', value: money(today.tax)),
          const Divider(height: AppSpacing.lg),
          KeyValueRow(label: 'Cash', value: money(today.payCash)),
          KeyValueRow(label: 'Card', value: money(today.payCard)),
          KeyValueRow(label: 'Mobile banking', value: money(today.payMobile)),
          if (today.payOther > 0) KeyValueRow(label: 'Other', value: money(today.payOther)),
          const Divider(height: AppSpacing.lg),
          KeyValueRow(
            label: 'Cancellations / no-shows',
            value: '${today.cancellations} / ${today.noShows}',
            valueColor: today.noShows > 0 ? context.palette.danger : null,
          ),
          KeyValueRow(label: 'Voided bills', value: '${today.voids}'),
        ],
      ),
    );

    final padding = context.pagePadding;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(padding.left, padding.top, padding.right, 48),
          children: [
            MaxWidthBox(
              maxWidth: 1400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PageHeader(
                    title: '${_greeting(now)}, ${user?.firstName ?? ''}',
                    subtitle: '${business?.name ?? ''} · ${Formatters.dayFull(now)}',
                  ).animate().fadeIn(duration: 300.ms),
                  const SizedBox(height: AppSpacing.lg),
                  quickActions,
                  const SizedBox(height: AppSpacing.xl),
                  LayoutBuilder(
                    builder: (context, c) {
                      final cols = c.maxWidth >= 1000 ? 4 : (c.maxWidth >= 520 ? 2 : 1);
                      final w = (c.maxWidth - AppSpacing.md * (cols - 1)) / cols;
                      return Wrap(
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.md,
                        children: [
                          for (var i = 0; i < kpis.length; i++)
                            SizedBox(width: w, height: 168, child: kpis[i])
                                .animate(delay: (60 * i).ms)
                                .fadeIn(duration: 300.ms)
                                .slideY(begin: 0.08, end: 0),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  if (context.screenSize.width >= Breakpoints.twoPane)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(children: [chart, const SizedBox(height: AppSpacing.lg), breakdown]),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(flex: 2, child: upcomingCard),
                      ],
                    )
                  else ...[
                    upcomingCard,
                    const SizedBox(height: AppSpacing.lg),
                    chart,
                    const SizedBox(height: AppSpacing.lg),
                    breakdown,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
