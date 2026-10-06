import 'package:flutter_test/flutter_test.dart';
import 'package:table_next_pro/features/floor_plan/domain/entities/floor_element.dart';
import 'package:table_next_pro/features/floor_plan/domain/entities/floor_enums.dart';
import 'package:table_next_pro/features/reservations/domain/entities/reservation.dart';
import 'package:table_next_pro/features/reservations/domain/services/table_availability.dart';

FloorElement _table(String id, int seats, {String floor = 'f1'}) => FloorElement(
      id: id,
      floorId: floor,
      kind: ElementKind.table,
      label: id.toUpperCase(),
      seats: seats,
    );

Reservation _res(String id, DateTime start, List<String> tables,
        {ReservationStatus status = ReservationStatus.confirmed}) =>
    Reservation(
      id: id,
      customerId: 'c',
      customerName: 'Guest',
      customerPhone: '01700000000',
      partySize: 2,
      startAt: start,
      durationMinutes: 90,
      tableIds: tables,
      status: status,
    );

void main() {
  final at7 = DateTime(2026, 1, 1, 19);

  test('overlapping active reservations block their tables', () {
    final conflicts = TableAvailability.conflicts(
      reservations: [_res('r1', at7, ['t1'])],
      start: at7.add(const Duration(minutes: 60)),
      end: at7.add(const Duration(minutes: 150)),
    );
    expect(conflicts.keys, ['t1']);
  });

  test('cancelled reservations and the edited reservation are ignored', () {
    final conflicts = TableAvailability.conflicts(
      reservations: [
        _res('r1', at7, ['t1'], status: ReservationStatus.cancelled),
        _res('r2', at7, ['t2']),
      ],
      start: at7,
      end: at7.add(const Duration(minutes: 90)),
      excludeReservationId: 'r2',
    );
    expect(conflicts, isEmpty);
  });

  test('suggests the smallest table that fits', () {
    final picks = TableAvailability.suggest(
      tables: [_table('t1', 8), _table('t2', 4), _table('t3', 2)],
      unavailableIds: {},
      partySize: 3,
    );
    expect(picks.map((t) => t.id), ['t2']);
  });

  test('combines tables when no single table fits', () {
    final picks = TableAvailability.suggest(
      tables: [_table('t1', 4), _table('t2', 4), _table('t3', 2)],
      unavailableIds: {},
      partySize: 7,
    );
    expect(picks.fold<int>(0, (s, t) => s + t.seats), greaterThanOrEqualTo(7));
  });
}
