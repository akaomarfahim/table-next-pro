import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation.freezed.dart';

enum ReservationStatus {
  pending('Pending'),
  confirmed('Confirmed'),
  seated('Seated'),
  completed('Completed'),
  cancelled('Cancelled'),
  noShow('No-show');

  const ReservationStatus(this.label);
  final String label;

  /// Statuses that hold the table.
  bool get isActive =>
      this == ReservationStatus.pending || this == ReservationStatus.confirmed || this == ReservationStatus.seated;

  bool get isFinal => !isActive;
}

enum ReservationSource {
  phone('Phone'),
  walkIn('Walk-in'),
  online('Online'),
  social('Social media'),
  other('Other');

  const ReservationSource(this.label);
  final String label;
}

enum ReservationOccasion {
  none('None'),
  birthday('Birthday'),
  anniversary('Anniversary'),
  business('Business'),
  date('Date night'),
  family('Family'),
  celebration('Celebration');

  const ReservationOccasion(this.label);
  final String label;
}

@freezed
abstract class Reservation with _$Reservation {
  const Reservation._();

  const factory Reservation({
    required String id,
    required String customerId,
    required String customerName,
    required String customerPhone,
    required int partySize,
    required DateTime startAt,
    required int durationMinutes,
    @Default(<String>[]) List<String> tableIds,
    @Default(<String>[]) List<String> tableLabels,
    @Default(ReservationStatus.confirmed) ReservationStatus status,
    @Default(ReservationSource.phone) ReservationSource source,
    @Default(ReservationOccasion.none) ReservationOccasion occasion,
    @Default('') String notes,
    @Default('') String createdById,
    @Default('') String createdByName,
    String? billId,
    DateTime? seatedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Reservation;

  DateTime get endAt => startAt.add(Duration(minutes: durationMinutes));

  String get tablesLabel => tableLabels.isEmpty ? 'No table' : tableLabels.join(', ');

  bool overlaps(DateTime start, DateTime end) => startAt.isBefore(end) && start.isBefore(endAt);

  bool get isLate =>
      (status == ReservationStatus.pending || status == ReservationStatus.confirmed) &&
      DateTime.now().isAfter(startAt.add(const Duration(minutes: 15)));
}
