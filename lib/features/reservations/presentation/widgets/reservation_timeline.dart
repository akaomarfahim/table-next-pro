import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../floor_plan/domain/entities/floor_element.dart';
import '../../domain/entities/reservation.dart';
import 'reservation_status_style.dart';

/// Gantt-style day view: one row per table, one bar per reservation.
/// Tap an empty slot to book that table at that time.
class ReservationTimeline extends StatefulWidget {
  const ReservationTimeline({
    super.key,
    required this.day,
    required this.tables,
    required this.reservations,
    this.startHour = 10,
    this.endHour = 23,
  });

  final DateTime day;
  final List<FloorElement> tables;
  final List<Reservation> reservations;
  final int startHour;
  final int endHour;

  @override
  State<ReservationTimeline> createState() => _ReservationTimelineState();
}

class _ReservationTimelineState extends State<ReservationTimeline> {
  static const double _hourWidth = 132;
  static const double _rowHeight = 56;
  static const double _labelWidth = 92;
  static const double _headerHeight = 36;

  final _horizontal = ScrollController();

  int get _hours => (widget.endHour - widget.startHour).clamp(1, 24);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToNow());
  }

  @override
  void dispose() {
    _horizontal.dispose();
    super.dispose();
  }

  void _scrollToNow() {
    if (!_horizontal.hasClients) return;
    final now = DateTime.now();
    if (!DateUtilsX.isSameDay(now, widget.day)) return;
    final x = _xFor(now) - 160;
    _horizontal.jumpTo(x.clamp(0.0, _horizontal.position.maxScrollExtent));
  }

  DateTime get _origin =>
      DateTime(widget.day.year, widget.day.month, widget.day.day, widget.startHour);

  double _xFor(DateTime t) => t.difference(_origin).inMinutes / 60 * _hourWidth;

  @override
  Widget build(BuildContext context) {
    final totalWidth = _hours * _hourWidth;
    final byTable = <String, List<Reservation>>{};
    for (final r in widget.reservations) {
      if (r.status == ReservationStatus.cancelled) continue;
      for (final id in r.tableIds) {
        byTable.putIfAbsent(id, () => []).add(r);
      }
    }
    final now = DateTime.now();
    final showNow = DateUtilsX.isSameDay(now, widget.day) &&
        now.hour >= widget.startHour &&
        now.hour < widget.endHour;

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: context.palette.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Table labels column.
            SizedBox(
              width: _labelWidth,
              child: Column(
                children: [
                  const SizedBox(height: _headerHeight),
                  for (final t in widget.tables)
                    Container(
                      height: _rowHeight,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: context.palette.border)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.label, style: context.text.titleSmall),
                          Text(
                            '${t.seats} seats',
                            style: context.text.labelSmall?.copyWith(color: context.palette.textMuted),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            VerticalDivider(width: 1, color: context.palette.border),
            Expanded(
              child: SingleChildScrollView(
                controller: _horizontal,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: totalWidth,
                  height: _headerHeight + widget.tables.length * _rowHeight,
                  child: Stack(
                    children: [
                      // Hour grid + header.
                      for (var h = 0; h <= _hours; h++)
                        Positioned(
                          left: h * _hourWidth,
                          top: 0,
                          bottom: 0,
                          child: Container(width: 1, color: context.palette.border),
                        ),
                      for (var h = 0; h < _hours; h++)
                        Positioned(
                          left: h * _hourWidth + 8,
                          top: 10,
                          child: Text(
                            Formatters.time(_origin.add(Duration(hours: h))),
                            style: context.text.labelSmall?.copyWith(
                              color: context.palette.textMuted,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      // Rows.
                      for (var i = 0; i < widget.tables.length; i++) ...[
                        Positioned(
                          left: 0,
                          right: 0,
                          top: _headerHeight + i * _rowHeight,
                          height: _rowHeight,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTapUp: (d) {
                              final minutes = (d.localPosition.dx / _hourWidth * 60).floor();
                              final rounded = minutes - minutes % 15;
                              final start = _origin.add(Duration(minutes: rounded));
                              context.go(
                                AppRoutes.newReservationWith(
                                  tableId: widget.tables[i].id,
                                  date: start,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(top: BorderSide(color: context.palette.border)),
                              ),
                            ),
                          ),
                        ),
                        for (final r in byTable[widget.tables[i].id] ?? const <Reservation>[])
                          _bar(context, r, i),
                      ],
                      if (showNow)
                        Positioned(
                          left: _xFor(now),
                          top: 0,
                          bottom: 0,
                          child: Container(width: 2, color: context.palette.danger),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar(BuildContext context, Reservation r, int row) {
    final left = _xFor(r.startAt).clamp(0.0, _hours * _hourWidth);
    final right = _xFor(r.endAt).clamp(0.0, _hours * _hourWidth);
    final width = (right - left).clamp(24.0, double.infinity);
    final color = r.status.color(context);
    return Positioned(
      left: left + 2,
      width: width - 4,
      top: _headerHeight + row * _rowHeight + 6,
      height: _rowHeight - 12,
      child: Material(
        color: color.withValues(alpha: context.isDark ? 0.3 : 0.16),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.smAll,
          side: BorderSide(color: color.withValues(alpha: 0.7)),
        ),
        child: InkWell(
          borderRadius: AppRadius.smAll,
          onTap: () => context.go(AppRoutes.reservation(r.id)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(r.status.icon, size: 14, color: color),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${r.customerName} · ${r.partySize}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.labelMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
