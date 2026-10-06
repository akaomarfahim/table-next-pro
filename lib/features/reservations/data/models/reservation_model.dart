import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/json_converters.dart';
import '../../domain/entities/reservation.dart';

part 'reservation_model.freezed.dart';
part 'reservation_model.g.dart';

@freezed
abstract class ReservationModel with _$ReservationModel {
  const ReservationModel._();

  const factory ReservationModel({
    @JsonKey(includeToJson: false) @Default('') String id,
    required String customerId,
    required String customerName,
    required String customerPhone,
    required int partySize,
    @TimestampConverter() required DateTime startAt,
    /// Denormalised for range queries / readability in the console.
    @TimestampConverter() required DateTime endAt,
    required int durationMinutes,
    @Default(<String>[]) List<String> tableIds,
    @Default(<String>[]) List<String> tableLabels,
    @JsonKey(unknownEnumValue: ReservationStatus.pending)
    @Default(ReservationStatus.confirmed)
    ReservationStatus status,
    @JsonKey(unknownEnumValue: ReservationSource.other)
    @Default(ReservationSource.phone)
    ReservationSource source,
    @JsonKey(unknownEnumValue: ReservationOccasion.none)
    @Default(ReservationOccasion.none)
    ReservationOccasion occasion,
    @Default('') String notes,
    @Default('') String createdById,
    @Default('') String createdByName,
    String? billId,
    @NullableTimestampConverter() DateTime? seatedAt,
    @NullableTimestampConverter() DateTime? completedAt,
    @NullableTimestampConverter() DateTime? cancelledAt,
    @NullableTimestampConverter() DateTime? createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _ReservationModel;

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);

  factory ReservationModel.fromEntity(Reservation e) => ReservationModel(
        id: e.id,
        customerId: e.customerId,
        customerName: e.customerName,
        customerPhone: e.customerPhone,
        partySize: e.partySize,
        startAt: e.startAt,
        endAt: e.endAt,
        durationMinutes: e.durationMinutes,
        tableIds: e.tableIds,
        tableLabels: e.tableLabels,
        status: e.status,
        source: e.source,
        occasion: e.occasion,
        notes: e.notes,
        createdById: e.createdById,
        createdByName: e.createdByName,
        billId: e.billId,
        seatedAt: e.seatedAt,
        completedAt: e.completedAt,
        cancelledAt: e.cancelledAt,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  Reservation toEntity() => Reservation(
        id: id,
        customerId: customerId,
        customerName: customerName,
        customerPhone: customerPhone,
        partySize: partySize,
        startAt: startAt,
        durationMinutes: durationMinutes,
        tableIds: tableIds,
        tableLabels: tableLabels,
        status: status,
        source: source,
        occasion: occasion,
        notes: notes,
        createdById: createdById,
        createdByName: createdByName,
        billId: billId,
        seatedAt: seatedAt,
        completedAt: completedAt,
        cancelledAt: cancelledAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
