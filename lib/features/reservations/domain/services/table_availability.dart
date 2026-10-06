import '../../../floor_plan/domain/entities/floor_element.dart';
import '../entities/reservation.dart';

/// Pure availability logic used by the reservation form and table picker.
abstract final class TableAvailability {
  /// Default buffer between consecutive bookings of the same table.
  static const Duration turnoverBuffer = Duration(minutes: 10);

  /// Ids of tables held by active reservations overlapping [start, end).
  static Map<String, Reservation> conflicts({
    required Iterable<Reservation> reservations,
    required DateTime start,
    required DateTime end,
    String? excludeReservationId,
    Duration buffer = turnoverBuffer,
  }) {
    final result = <String, Reservation>{};
    for (final r in reservations) {
      if (r.id == excludeReservationId || !r.status.isActive) continue;
      final rStart = r.startAt.subtract(buffer);
      final rEnd = r.endAt.add(buffer);
      if (rStart.isBefore(end) && start.isBefore(rEnd)) {
        for (final id in r.tableIds) {
          result.putIfAbsent(id, () => r);
        }
      }
    }
    return result;
  }

  /// Suggests the best fitting free table(s) for [partySize]:
  /// 1. the smallest single table that seats the party, otherwise
  /// 2. the fewest tables (largest first) on the same floor.
  static List<FloorElement> suggest({
    required List<FloorElement> tables,
    required Set<String> unavailableIds,
    required int partySize,
  }) {
    final free = tables
        .where((t) => t.isTable && t.active && !unavailableIds.contains(t.id))
        .toList();
    if (free.isEmpty) return const [];

    final fitting = free.where((t) => t.seats >= partySize).toList()
      ..sort((a, b) => a.seats.compareTo(b.seats));
    if (fitting.isNotEmpty) return [fitting.first];

    final byFloor = <String, List<FloorElement>>{};
    for (final t in free) {
      byFloor.putIfAbsent(t.floorId, () => []).add(t);
    }
    List<FloorElement>? best;
    for (final group in byFloor.values) {
      group.sort((a, b) => b.seats.compareTo(a.seats));
      final picked = <FloorElement>[];
      var seats = 0;
      for (final t in group) {
        picked.add(t);
        seats += t.seats;
        if (seats >= partySize) break;
      }
      if (seats >= partySize && (best == null || picked.length < best.length)) {
        best = picked;
      }
    }
    return best ?? const [];
  }
}
