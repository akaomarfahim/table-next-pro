import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../../floor_plan/presentation/controllers/floor_providers.dart';
import '../../domain/entities/reservation.dart';
import '../controllers/reservation_providers.dart';
import '../widgets/date_strip.dart';
import '../widgets/reservation_card.dart';
import '../widgets/reservation_timeline.dart';

enum _ViewMode { list, timeline }

class ReservationsScreen extends ConsumerStatefulWidget {
  const ReservationsScreen({super.key});

  @override
  ConsumerState<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends ConsumerState<ReservationsScreen> {
  _ViewMode _mode = _ViewMode.list;

  bool _matches(Reservation r, ReservationFilter f) => switch (f) {
        ReservationFilter.all => true,
        ReservationFilter.upcoming =>
          r.status == ReservationStatus.pending || r.status == ReservationStatus.confirmed,
        ReservationFilter.seated => r.status == ReservationStatus.seated,
        ReservationFilter.finished => r.status.isFinal,
      };

  @override
  Widget build(BuildContext context) {
    final day = ref.watch(selectedReservationDateProvider);
    final filter = ref.watch(reservationListFilterProvider);
    final async = ref.watch(reservationsForDayProvider(day));
    ref.watch(minuteTickerProvider); // refresh "late" badges
    final business = ref.watch(currentBusinessProvider);
    final tables = ref.watch(allTablesProvider).value ?? const [];
    final all = async.value ?? const <Reservation>[];
    final active = all.where((r) => r.status != ReservationStatus.cancelled);
    final covers = active.fold<int>(0, (s, r) => s + r.partySize);
    final padding = context.pagePadding;
    final canTimeline = context.isTabletUp && tables.isNotEmpty;
    final mode = canTimeline ? _mode : _ViewMode.list;

    return Scaffold(
      floatingActionButton: context.isCompact
          ? FloatingActionButton.extended(
              onPressed: () => context.go(AppRoutes.newReservationWith(date: day)),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Book'),
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
                title: 'Reservations',
                subtitle: '${active.length} bookings · $covers covers',
                actions: [
                  if (canTimeline)
                    SegmentedButton<_ViewMode>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(value: _ViewMode.list, icon: Icon(Icons.view_agenda_rounded), label: Text('List')),
                        ButtonSegment(value: _ViewMode.timeline, icon: Icon(Icons.view_timeline_rounded), label: Text('Timeline')),
                      ],
                      selected: {mode},
                      onSelectionChanged: (s) => setState(() => _mode = s.first),
                    ),
                  if (!context.isCompact)
                    FilledButton.icon(
                      onPressed: () => context.go(AppRoutes.newReservationWith(date: day)),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('New reservation'),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding.left),
              child: DateStrip(
                selected: day,
                showStrip: context.isTabletUp,
                onChanged: (d) => ref.read(selectedReservationDateProvider.notifier).set(d),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            if (mode == _ViewMode.list)
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: padding.left),
                  children: [
                    for (final f in ReservationFilter.values)
                      Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.sm),
                        child: ChoiceChip(
                          label: Text(
                            '${switch (f) {
                              ReservationFilter.all => 'All',
                              ReservationFilter.upcoming => 'Upcoming',
                              ReservationFilter.seated => 'Seated',
                              ReservationFilter.finished => 'Finished',
                            }} (${all.where((r) => _matches(r, f)).length})',
                          ),
                          selected: filter == f,
                          onSelected: (_) => ref.read(reservationListFilterProvider.notifier).set(f),
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: async.when(
                skipLoadingOnReload: true,
                loading: () => const SkeletonList(itemHeight: 80),
                error: (e, _) => ErrorState(
                  error: e,
                  onRetry: () => ref.invalidate(reservationsForDayProvider(day)),
                ),
                data: (list) {
                  if (mode == _ViewMode.timeline) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(padding.left, 0, padding.right, padding.bottom),
                      child: ReservationTimeline(
                        day: day,
                        tables: tables,
                        reservations: list,
                        startHour: business?.openingHour ?? 10,
                        endHour: business?.closingHour ?? 23,
                      ),
                    );
                  }
                  final filtered = list.where((r) => _matches(r, filter)).toList();
                  if (filtered.isEmpty) {
                    return EmptyState(
                      icon: Icons.event_busy_rounded,
                      title: 'No reservations',
                      message: 'Nothing booked for ${Formatters.relativeDay(day).toLowerCase()} in this view.',
                      action: FilledButton.icon(
                        onPressed: () => context.go(AppRoutes.newReservationWith(date: day)),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('New reservation'),
                      ),
                    );
                  }
                  return _GroupedList(reservations: filtered, padding: padding);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Reservations grouped by hour, laid out in 1–2 columns.
class _GroupedList extends StatelessWidget {
  const _GroupedList({required this.reservations, required this.padding});

  final List<Reservation> reservations;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final groups = <int, List<Reservation>>{};
    for (final r in reservations) {
      groups.putIfAbsent(r.startAt.hour, () => []).add(r);
    }
    final hours = groups.keys.toList()..sort();

    return LayoutBuilder(
      builder: (context, c) {
        final twoCols = c.maxWidth >= 1000;
        return ListView(
          padding: EdgeInsets.fromLTRB(padding.left, 0, padding.right, 96),
          children: [
            for (final h in hours) ...[
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    Text(
                      Formatters.time(DateTime(2000, 1, 1, h)),
                      style: context.text.labelLarge?.copyWith(color: context.palette.textMuted),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    const Expanded(child: Divider()),
                  ],
                ),
              ),
              if (twoCols)
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: [
                    for (final r in groups[h]!)
                      SizedBox(
                        width: (c.maxWidth - padding.horizontal - AppSpacing.md) / 2,
                        child: ReservationCard(reservation: r),
                      ),
                  ],
                )
              else
                for (final r in groups[h]!)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: ReservationCard(reservation: r)
                        .animate()
                        .fadeIn(duration: 200.ms)
                        .slideY(begin: 0.04, end: 0),
                  ),
            ],
          ],
        );
      },
    );
  }
}
