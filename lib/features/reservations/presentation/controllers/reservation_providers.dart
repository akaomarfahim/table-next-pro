import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/formatters.dart';
import '../../data/repositories/reservation_repository_impl.dart';
import '../../domain/entities/reservation.dart';

part 'reservation_providers.g.dart';

/// Day shown on the reservations screen.
@Riverpod(keepAlive: true)
class SelectedReservationDate extends _$SelectedReservationDate {
  @override
  DateTime build() => DateUtilsX.startOfDay(DateTime.now());

  void set(DateTime day) => state = DateUtilsX.startOfDay(day);
  void next() => state = state.add(const Duration(days: 1));
  void previous() => state = state.subtract(const Duration(days: 1));
  void today() => state = DateUtilsX.startOfDay(DateTime.now());
}

/// Filter of the reservations list.
enum ReservationFilter { all, upcoming, seated, finished }

@riverpod
class ReservationListFilter extends _$ReservationListFilter {
  @override
  ReservationFilter build() => ReservationFilter.all;

  void set(ReservationFilter f) => state = f;
}

/// Realtime reservations for a single day.
@riverpod
Stream<List<Reservation>> reservationsForDay(Ref ref, DateTime day) {
  final start = DateUtilsX.startOfDay(day);
  return ref
      .watch(reservationRepositoryProvider)
      .watchRange(start, DateUtilsX.endOfDay(start));
}

/// Realtime reservations around a day (±6h) for conflict detection of
/// bookings that cross midnight.
@riverpod
Stream<List<Reservation>> reservationsWindow(Ref ref, DateTime day) {
  final start = DateUtilsX.startOfDay(day);
  return ref.watch(reservationRepositoryProvider).watchRange(
        start.subtract(const Duration(hours: 6)),
        DateUtilsX.endOfDay(start).add(const Duration(hours: 6)),
      );
}

/// Today's reservations, kept alive for the dashboard and live floor.
@Riverpod(keepAlive: true)
Stream<List<Reservation>> todayReservations(Ref ref) {
  final today = DateUtilsX.startOfDay(DateTime.now());
  // Roll over automatically at midnight.
  final untilMidnight = DateUtilsX.endOfDay(today).difference(DateTime.now());
  final timer = Timer(untilMidnight + const Duration(seconds: 1), ref.invalidateSelf);
  ref.onDispose(timer.cancel);
  return ref
      .watch(reservationRepositoryProvider)
      .watchRange(today, DateUtilsX.endOfDay(today));
}

@riverpod
Stream<Reservation?> reservationById(Ref ref, String id) =>
    ref.watch(reservationRepositoryProvider).watchById(id);

@riverpod
Future<List<Reservation>> customerReservations(Ref ref, String customerId) =>
    ref.watch(reservationRepositoryProvider).fetchByCustomer(customerId);

/// A ticking clock (1 minute) used for "late" badges and live floor status.
@Riverpod(keepAlive: true)
Stream<DateTime> minuteTicker(Ref ref) async* {
  yield DateTime.now();
  yield* Stream.periodic(const Duration(minutes: 1), (_) => DateTime.now());
}
