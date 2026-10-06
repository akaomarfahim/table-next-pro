import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../auth/domain/entities/user_role.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../../billing/domain/entities/bill.dart';
import '../../../billing/presentation/controllers/billing_providers.dart';
import '../../../reservations/domain/entities/reservation.dart';
import '../../../reservations/presentation/controllers/reservation_providers.dart';
import '../../../reservations/presentation/widgets/reservation_status_style.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../domain/entities/customer.dart';
import '../controllers/customer_list_controller.dart';
import 'customer_form_sheet.dart';

/// Full customer profile: contact, stats, reservation and bill history.
class CustomerDetailView extends ConsumerWidget {
  const CustomerDetailView({super.key, required this.customerId, this.onDeleted});

  final String customerId;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerAsync = ref.watch(customerByIdProvider(customerId));
    return AsyncValueView<Customer?>(
      value: customerAsync,
      loading: const SkeletonList(itemCount: 6),
      onRetry: () => ref.invalidate(customerByIdProvider(customerId)),
      data: (customer) {
        if (customer == null) {
          return const EmptyState(
            icon: Icons.person_off_rounded,
            title: 'Customer not found',
            message: 'This customer may have been deleted.',
          );
        }
        return _CustomerDetailBody(customer: customer, onDeleted: onDeleted);
      },
    );
  }
}

class _CustomerDetailBody extends ConsumerWidget {
  const _CustomerDetailBody({required this.customer, this.onDeleted});

  final Customer customer;
  final VoidCallback? onDeleted;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Delete ${customer.name}?',
      message: 'The customer profile is removed. Past reservations and bills are kept.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!ok) return;
    try {
      await ref.read(customerRepositoryProvider).delete(customer.id);
      if (ref.exists(customerListProvider)) {
        ref.read(customerListProvider.notifier).removeLocal(customer.id);
      }
      onDeleted?.call();
      if (context.mounted) context.showSnack('Customer deleted');
    } catch (e) {
      if (context.mounted) context.showError(e);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final business = ref.watch(currentBusinessProvider);
    final canDelete = ref.watch(hasPermissionProvider(Permission.deleteCustomers));
    final c = customer;
    String money(num v) => business?.money(v) ?? v.toStringAsFixed(2);

    final header = AppCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InitialsAvatar(name: c.name, size: 64),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            c.name,
                            style: context.text.headlineSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (c.isVip) ...[
                          const SizedBox(width: AppSpacing.sm),
                          StatusBadge(
                            label: 'VIP',
                            color: context.palette.warning,
                            icon: Icons.star_rounded,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      PhoneUtils.display(c.phone),
                      style: context.text.bodyLarge?.copyWith(color: context.palette.textMuted),
                    ),
                    if (c.email.isNotEmpty)
                      Text(
                        c.email,
                        style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              FilledButton.icon(
                onPressed: () =>
                    context.go(AppRoutes.newReservationWith(customerId: c.id)),
                icon: const Icon(Icons.event_available_rounded, size: 18),
                label: const Text('New reservation'),
              ),
              OutlinedButton.icon(
                onPressed: () => launchUrl(Uri(scheme: 'tel', path: c.phone)),
                icon: const Icon(Icons.call_rounded, size: 18),
                label: const Text('Call'),
              ),
              OutlinedButton.icon(
                onPressed: () => CustomerFormSheet.show(context, customer: c),
                icon: const Icon(Icons.edit_rounded, size: 18),
                label: const Text('Edit'),
              ),
              if (canDelete)
                IconButton(
                  tooltip: 'Delete customer',
                  onPressed: () => _delete(context, ref),
                  icon: Icon(Icons.delete_outline_rounded, color: context.palette.danger),
                ),
            ],
          ),
          if (c.frequentNoShow) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: context.palette.danger.withValues(alpha: 0.1),
                borderRadius: AppRadius.mdAll,
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: context.palette.danger),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Frequent no-show: ${c.noShowCount} of ${c.reservationCount} reservations. Consider confirming by phone.',
                      style: context.text.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );

    final stats = LayoutBuilder(
      builder: (context, constraints) {
        final cols = adaptiveColumns(constraints.maxWidth, minTileWidth: 150, maxColumns: 4);
        final tiles = [
          _MiniStat(label: 'Visits', value: '${c.visitCount}', icon: Icons.restaurant_rounded),
          _MiniStat(label: 'Reservations', value: '${c.reservationCount}', icon: Icons.event_note_rounded),
          _MiniStat(label: 'Total spent', value: money(c.totalSpent), icon: Icons.payments_rounded),
          _MiniStat(label: 'Avg. spend', value: money(c.averageSpend), icon: Icons.trending_up_rounded),
          _MiniStat(
            label: 'No-shows',
            value: '${c.noShowCount}',
            icon: Icons.person_off_rounded,
            color: c.noShowCount > 0 ? context.palette.danger : null,
          ),
          _MiniStat(
            label: 'Last visit',
            value: c.lastVisitAt == null ? '—' : Formatters.relativeDay(c.lastVisitAt!),
            icon: Icons.schedule_rounded,
          ),
        ];
        return GridView.count(
          crossAxisCount: cols,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 2.3,
          children: tiles,
        );
      },
    );

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        header.animate().fadeIn(duration: 250.ms),
        const SizedBox(height: AppSpacing.lg),
        stats,
        if (c.tags.isNotEmpty || c.notes.isNotEmpty || c.birthday != null) ...[
          const SizedBox(height: AppSpacing.lg),
          SectionCard(
            title: 'Preferences',
            icon: Icons.favorite_border_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (c.birthday != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Row(
                      children: [
                        const Icon(Icons.cake_rounded, size: 18),
                        const SizedBox(width: AppSpacing.sm),
                        Text('Birthday · ${Formatters.dayShort(c.birthday!)}'),
                      ],
                    ),
                  ),
                if (c.tags.isNotEmpty)
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: [
                      for (final t in c.tags) StatusBadge(label: t, color: context.colors.secondary, dense: true),
                    ],
                  ),
                if (c.notes.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(c.notes, style: context.text.bodyMedium),
                ],
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        _ReservationHistory(customerId: c.id),
        const SizedBox(height: AppSpacing.lg),
        _BillHistory(customerId: c.id, money: money),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value, required this.icon, this.color});

  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? context.palette.textMuted),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: context.text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.labelSmall?.copyWith(color: context.palette.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReservationHistory extends ConsumerWidget {
  const _ReservationHistory({required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(customerReservationsProvider(customerId));
    return SectionCard(
      title: 'Reservation history',
      icon: Icons.history_rounded,
      trailing: IconButton(
        tooltip: 'Refresh',
        onPressed: () => ref.invalidate(customerReservationsProvider(customerId)),
        icon: const Icon(Icons.refresh_rounded),
      ),
      child: history.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Text(e.toString()),
        data: (list) {
          if (list.isEmpty) {
            return Text(
              'No reservations yet.',
              style: context.text.bodyMedium?.copyWith(color: context.palette.textMuted),
            );
          }
          return Column(
            children: [
              for (final r in list) _ReservationHistoryTile(reservation: r),
            ],
          );
        },
      ),
    );
  }
}

class _ReservationHistoryTile extends StatelessWidget {
  const _ReservationHistoryTile({required this.reservation});

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final r = reservation;
    final color = r.status.color(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () => context.go(AppRoutes.reservation(r.id)),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: AppRadius.mdAll,
        ),
        child: Icon(r.status.icon, color: color, size: 20),
      ),
      title: Text('${Formatters.dayShort(r.startAt)} · ${Formatters.time(r.startAt)}'),
      subtitle: Text(
        '${r.partySize} guests · ${r.tablesLabel}'
        '${r.occasion != ReservationOccasion.none ? ' · ${r.occasion.label}' : ''}',
      ),
      trailing: StatusBadge(label: r.status.label, color: color, dense: true),
    );
  }
}

class _BillHistory extends ConsumerWidget {
  const _BillHistory({required this.customerId, required this.money});

  final String customerId;
  final String Function(num) money;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bills = ref.watch(customerBillsProvider(customerId));
    return SectionCard(
      title: 'Bills',
      icon: Icons.receipt_long_rounded,
      child: bills.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text(e.toString()),
        data: (list) {
          final paid = list.where((b) => b.status == BillStatus.paid).toList();
          if (paid.isEmpty) {
            return Text(
              'No bills yet.',
              style: context.text.bodyMedium?.copyWith(color: context.palette.textMuted),
            );
          }
          return Column(
            children: [
              for (final b in paid.take(10))
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () => context.go(AppRoutes.bill(b.id)),
                  leading: const Icon(Icons.receipt_rounded),
                  title: Text('#${b.billNumber} · ${b.title}'),
                  subtitle: Text(
                    b.closedAt == null ? '' : Formatters.dateTime(b.closedAt!),
                  ),
                  trailing: Text(
                    money(b.totals.total),
                    style: context.text.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
