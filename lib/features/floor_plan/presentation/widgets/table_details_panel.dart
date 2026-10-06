import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../../billing/presentation/controllers/bill_actions.dart';
import '../../../reservations/domain/entities/reservation.dart';
import '../../domain/entities/floor_element.dart';
import '../controllers/table_status_provider.dart';

Color tableStatusColor(BuildContext context, TableStatus status) => switch (status) {
      TableStatus.available => context.palette.tableAvailable,
      TableStatus.reserved => context.palette.tableReserved,
      TableStatus.occupied => context.palette.tableOccupied,
    };

/// Details & quick actions for a table on the live floor.
class TableDetailsPanel extends ConsumerStatefulWidget {
  const TableDetailsPanel({super.key, required this.table, this.onClose});

  final FloorElement table;
  final VoidCallback? onClose;

  @override
  ConsumerState<TableDetailsPanel> createState() => _TableDetailsPanelState();
}

class _TableDetailsPanelState extends ConsumerState<TableDetailsPanel> {
  bool _busy = false;
  int _guests = 2;

  Future<void> _run(Future<String?> Function() action) async {
    setState(() => _busy = true);
    try {
      final billId = await action();
      if (!mounted) return;
      if (billId != null) context.go(AppRoutes.bill(billId));
    } catch (e) {
      if (mounted) context.showError(e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.table;
    final live = ref.watch(tableStatusesProvider)[t.id] ??
        const TableLiveStatus(status: TableStatus.available);
    final color = tableStatusColor(context, live.status);
    final business = ref.watch(currentBusinessProvider);
    final actions = ref.read(billActionsProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: AppRadius.mdAll,
              ),
              child: Text(
                t.label,
                style: context.text.titleMedium?.copyWith(color: color, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Table ${t.label}', style: context.text.titleLarge),
                  Text(
                    '${t.seats} seats · ${t.tableShape.label}',
                    style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                  ),
                ],
              ),
            ),
            if (widget.onClose != null)
              IconButton(onPressed: widget.onClose, icon: const Icon(Icons.close_rounded)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Align(
          alignment: Alignment.centerLeft,
          child: StatusBadge(label: live.status.label, color: color),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Occupied: current bill / seated party
        if (live.bill != null) ...[
          _InfoCard(
            icon: Icons.receipt_long_rounded,
            title: 'Bill #${live.bill!.billNumber}',
            lines: [
              '${live.bill!.itemCount} items · ${live.bill!.guests} guests',
              if (live.bill!.createdAt != null)
                'Opened ${Formatters.timeAgo(live.bill!.createdAt!)} by ${live.bill!.openedByName}',
              if (live.bill!.customerName.isNotEmpty) live.bill!.customerName,
            ],
            trailing: business?.money(live.bill!.totals.total),
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton.icon(
            onPressed: () => context.go(AppRoutes.bill(live.bill!.id)),
            icon: const Icon(Icons.point_of_sale_rounded),
            label: const Text('Open bill'),
          ),
        ] else if (live.currentReservation?.status == ReservationStatus.seated) ...[
          _ReservationTile(reservation: live.currentReservation!),
          const SizedBox(height: AppSpacing.md),
          LoadingButton(
            label: 'Start bill',
            icon: Icons.point_of_sale_rounded,
            loading: _busy,
            onPressed: () => _run(() async {
              final bill = await actions.openBill(reservation: live.currentReservation);
              return bill.id;
            }),
          ),
        ] else ...[
          // Available / reserved
          if (live.status == TableStatus.reserved && live.currentReservation != null) ...[
            Text('Arriving soon', style: context.text.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            _ReservationTile(reservation: live.currentReservation!),
            const SizedBox(height: AppSpacing.md),
            LoadingButton(
              label: 'Seat ${live.currentReservation!.customerName.split(' ').first}',
              icon: Icons.event_seat_rounded,
              loading: _busy,
              onPressed: () => _run(() async {
                final bill = await actions.openBill(reservation: live.currentReservation);
                return bill.id;
              }),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
          Text('Walk-in', style: context.text.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Guests',
                  style: context.text.bodyMedium?.copyWith(color: context.palette.textMuted),
                ),
              ),
              QuantityStepper(
                value: _guests,
                max: 50,
                compact: true,
                onChanged: (v) => setState(() => _guests = v),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          LoadingButton(
            label: 'Seat walk-in & start bill',
            icon: Icons.directions_walk_rounded,
            loading: _busy,
            tonal: live.status == TableStatus.reserved,
            onPressed: () => _run(() async {
              final bill = await actions.openBill(tables: [t], guests: _guests);
              return bill.id;
            }),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: () => context.go(AppRoutes.newReservationWith(tableId: t.id)),
          icon: const Icon(Icons.event_available_rounded),
          label: const Text('New reservation'),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text("Today's bookings", style: context.text.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        if (live.upcoming.isEmpty)
          Text(
            'No more reservations today.',
            style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
          )
        else
          for (final r in live.upcoming) ...[
            _ReservationTile(reservation: r),
            const SizedBox(height: AppSpacing.sm),
          ],
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.lines,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final List<String> lines;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: AppRadius.mdAll,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: context.colors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.text.titleSmall),
                for (final l in lines)
                  Text(
                    l,
                    style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                  ),
              ],
            ),
          ),
          if (trailing != null)
            Text(trailing!, style: context.text.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _ReservationTile extends StatelessWidget {
  const _ReservationTile({required this.reservation});

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final r = reservation;
    return Material(
      color: context.colors.surfaceContainer,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        borderRadius: AppRadius.mdAll,
        onTap: () => context.go(AppRoutes.reservation(r.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    Formatters.time(r.startAt),
                    style: context.text.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    Formatters.duration(Duration(minutes: r.durationMinutes)),
                    style: context.text.labelSmall?.copyWith(color: context.palette.textMuted),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.customerName, style: context.text.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(
                      '${r.partySize} guests · ${r.status.label}',
                      style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
