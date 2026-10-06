import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/reservation.dart';
import '../controllers/reservation_actions.dart';
import 'reservation_status_style.dart';

/// Rich reservation row with quick status actions.
class ReservationCard extends ConsumerWidget {
  const ReservationCard({super.key, required this.reservation});

  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = reservation;
    final color = r.status.color(context);
    final next = nextStatuses(r.status);
    final primary = next.isEmpty ? null : next.first;

    return Material(
      color: context.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.lgAll,
        side: BorderSide(color: r.isLate ? context.palette.danger.withValues(alpha: 0.6) : context.palette.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(AppRoutes.reservation(r.id)),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 5, color: color),
              Container(
                width: 86,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                color: color.withValues(alpha: 0.06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Formatters.time(r.startAt),
                      textAlign: TextAlign.center,
                      style: context.text.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      Formatters.duration(Duration(minutes: r.durationMinutes)),
                      style: context.text.labelSmall?.copyWith(color: context.palette.textMuted),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              r.customerName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.text.titleMedium,
                            ),
                          ),
                          if (r.occasion != ReservationOccasion.none) ...[
                            const SizedBox(width: 6),
                            Tooltip(
                              message: r.occasion.label,
                              child: Icon(Icons.celebration_rounded, size: 16, color: context.palette.violet),
                            ),
                          ],
                          if (r.isLate) ...[
                            const SizedBox(width: 6),
                            StatusBadge(label: 'Late', color: context.palette.danger, dense: true),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: AppSpacing.md,
                        runSpacing: 4,
                        children: [
                          _Meta(icon: Icons.people_alt_rounded, text: '${r.partySize}'),
                          _Meta(icon: Icons.table_restaurant_rounded, text: r.tablesLabel),
                          _Meta(icon: Icons.call_rounded, text: PhoneUtils.display(r.customerPhone)),
                        ],
                      ),
                      if (r.notes.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          r.notes,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.text.bodySmall?.copyWith(
                            color: context.palette.textMuted,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusBadge(label: r.status.label, color: color, dense: true),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (primary != null && primary != ReservationStatus.cancelled)
                          TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: const Size(0, 36),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              foregroundColor: primary.color(context),
                            ),
                            onPressed: () => applyReservationStatus(context, ref, r, primary),
                            child: Text(_actionLabel(primary)),
                          ),
                        PopupMenuButton<String>(
                          tooltip: 'More',
                          icon: const Icon(Icons.more_vert_rounded, size: 20),
                          onSelected: (v) {
                            if (v == 'call') {
                              launchUrl(Uri(scheme: 'tel', path: r.customerPhone));
                            } else if (v == 'edit') {
                              context.go(AppRoutes.reservation(r.id));
                            } else {
                              final status = ReservationStatus.values.byName(v);
                              applyReservationStatus(context, ref, r, status);
                            }
                          },
                          itemBuilder: (_) => [
                            for (final s in next)
                              PopupMenuItem(
                                value: s.name,
                                child: ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(s.icon, color: s.color(context)),
                                  title: Text(_actionLabel(s)),
                                ),
                              ),
                            if (next.isNotEmpty) const PopupMenuDivider(),
                            const PopupMenuItem(
                              value: 'call',
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.call_rounded),
                                title: Text('Call guest'),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'edit',
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.edit_rounded),
                                title: Text('Edit'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _actionLabel(ReservationStatus s) => switch (s) {
        ReservationStatus.confirmed => 'Confirm',
        ReservationStatus.seated => 'Seat',
        ReservationStatus.completed => 'Complete',
        ReservationStatus.cancelled => 'Cancel',
        ReservationStatus.noShow => 'No-show',
        ReservationStatus.pending => 'Pending',
      };
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: context.palette.textMuted),
        const SizedBox(width: 4),
        Text(
          text,
          style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
        ),
      ],
    );
  }
}
