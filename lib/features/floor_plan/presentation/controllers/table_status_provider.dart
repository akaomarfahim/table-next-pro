import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../billing/domain/entities/bill.dart';
import '../../../billing/presentation/controllers/billing_providers.dart';
import '../../../reservations/domain/entities/reservation.dart';
import '../../../reservations/presentation/controllers/reservation_providers.dart';

part 'table_status_provider.g.dart';

enum TableStatus {
  available('Available'),
  reserved('Reserved soon'),
  occupied('Occupied');

  const TableStatus(this.label);
  final String label;
}

/// Live state of a single table.
class TableLiveStatus {
  const TableLiveStatus({
    required this.status,
    this.bill,
    this.currentReservation,
    this.upcoming = const [],
  });

  final TableStatus status;
  final Bill? bill;

  /// Seated or imminent reservation.
  final Reservation? currentReservation;

  /// Remaining active reservations today (sorted).
  final List<Reservation> upcoming;

  Reservation? get next => upcoming.isEmpty ? null : upcoming.first;
}

/// How far ahead an upcoming reservation marks a table as "reserved".
const Duration reservedWindow = Duration(minutes: 60);

/// Combines today's reservations, open bills and the clock into a status
/// map keyed by table id.
@riverpod
Map<String, TableLiveStatus> tableStatuses(Ref ref) {
  final now = ref.watch(minuteTickerProvider).value ?? DateTime.now();
  final reservations = ref.watch(todayReservationsProvider).value ?? const <Reservation>[];
  final bills = ref.watch(openBillsProvider).value ?? const <Bill>[];

  final billByTable = <String, Bill>{};
  for (final b in bills) {
    for (final id in b.tableIds) {
      billByTable[id] = b;
    }
  }

  final byTable = <String, List<Reservation>>{};
  for (final r in reservations) {
    if (!r.status.isActive) continue;
    for (final id in r.tableIds) {
      byTable.putIfAbsent(id, () => []).add(r);
    }
  }

  final tableIds = {...billByTable.keys, ...byTable.keys};
  final result = <String, TableLiveStatus>{};
  for (final id in tableIds) {
    final list = (byTable[id] ?? <Reservation>[])
      ..sort((a, b) => a.startAt.compareTo(b.startAt));
    final seated = list.where((r) => r.status == ReservationStatus.seated).firstOrNull;
    final upcoming = list
        .where((r) => r.status != ReservationStatus.seated && r.endAt.isAfter(now))
        .toList();
    final bill = billByTable[id];

    if (bill != null || seated != null) {
      result[id] = TableLiveStatus(
        status: TableStatus.occupied,
        bill: bill,
        currentReservation: seated,
        upcoming: upcoming,
      );
      continue;
    }
    final imminent = upcoming
        .where((r) => r.startAt.difference(now) <= reservedWindow)
        .firstOrNull;
    result[id] = TableLiveStatus(
      status: imminent != null ? TableStatus.reserved : TableStatus.available,
      currentReservation: imminent,
      upcoming: upcoming,
    );
  }
  return result;
}
