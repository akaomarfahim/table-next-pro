import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../../customers/domain/entities/customer.dart';
import '../../domain/entities/reservation.dart';
import '../controllers/reservation_providers.dart';
import 'reservation_status_style.dart';

/// Guest profile + previous reservations shown while booking.
class CustomerInsightCard extends ConsumerWidget {
  const CustomerInsightCard({super.key, required this.customer, this.excludeReservationId});

  final Customer customer;
  final String? excludeReservationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = customer;
    final business = ref.watch(currentBusinessProvider);
    final history = ref.watch(customerReservationsProvider(c.id));

    Widget stat(String value, String label, {Color? color}) => Expanded(
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: color),
                ),
              ),
              Text(label, style: context.text.labelSmall?.copyWith(color: context.palette.textMuted)),
            ],
          ),
        );

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              InitialsAvatar(name: c.name, size: 48),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(c.name, style: context.text.titleMedium, overflow: TextOverflow.ellipsis),
                        ),
                        if (c.isVip) ...[
                          const SizedBox(width: 6),
                          Icon(Icons.star_rounded, size: 18, color: context.palette.warning),
                        ],
                      ],
                    ),
                    Text(
                      PhoneUtils.display(c.phone),
                      style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                    ),
                  ],
                ),
              ),
              StatusBadge(label: 'Returning guest', color: context.palette.success, dense: true),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              stat('${c.visitCount}', 'Visits'),
              stat('${c.reservationCount}', 'Bookings'),
              stat(
                '${c.noShowCount}',
                'No-shows',
                color: c.noShowCount > 0 ? context.palette.danger : null,
              ),
              stat(business?.money(c.totalSpent) ?? c.totalSpent.toStringAsFixed(0), 'Spent'),
            ],
          ),
          if (c.tags.isNotEmpty || c.notes.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                for (final t in c.tags) StatusBadge(label: t, color: context.colors.secondary, dense: true),
              ],
            ),
            if (c.notes.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.sticky_note_2_outlined, size: 16, color: context.palette.warning),
                    const SizedBox(width: 6),
                    Expanded(child: Text(c.notes, style: context.text.bodySmall)),
                  ],
                ),
              ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Text('Previous reservations', style: context.text.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          history.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text(
              'Could not load history',
              style: context.text.bodySmall?.copyWith(color: context.palette.danger),
            ),
            data: (list) {
              final past = list.where((r) => r.id != excludeReservationId).take(6).toList();
              if (past.isEmpty) {
                return Text(
                  'First reservation for this guest.',
                  style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                );
              }
              return Column(
                children: [
                  for (final r in past) _HistoryRow(reservation: r),
                ],
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 250.ms).slideY(begin: 0.03, end: 0);
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.reservation});

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final r = reservation;
    final color = r.status.color(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(r.status.icon, size: 16, color: color),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '${Formatters.dayNumeric(r.startAt)} · ${Formatters.time(r.startAt)} · ${r.partySize} pax · ${r.tablesLabel}',
              style: context.text.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            r.status.label,
            style: context.text.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
