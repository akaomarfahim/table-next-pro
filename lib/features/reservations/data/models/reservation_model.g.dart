// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReservationModel _$ReservationModelFromJson(Map json) => _ReservationModel(
  id: json['id'] as String? ?? '',
  customerId: json['customerId'] as String,
  customerName: json['customerName'] as String,
  customerPhone: json['customerPhone'] as String,
  partySize: (json['partySize'] as num).toInt(),
  startAt: const TimestampConverter().fromJson(json['startAt']),
  endAt: const TimestampConverter().fromJson(json['endAt']),
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  tableIds:
      (json['tableIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  tableLabels:
      (json['tableLabels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  status:
      $enumDecodeNullable(
        _$ReservationStatusEnumMap,
        json['status'],
        unknownValue: ReservationStatus.pending,
      ) ??
      ReservationStatus.confirmed,
  source:
      $enumDecodeNullable(
        _$ReservationSourceEnumMap,
        json['source'],
        unknownValue: ReservationSource.other,
      ) ??
      ReservationSource.phone,
  occasion:
      $enumDecodeNullable(
        _$ReservationOccasionEnumMap,
        json['occasion'],
        unknownValue: ReservationOccasion.none,
      ) ??
      ReservationOccasion.none,
  notes: json['notes'] as String? ?? '',
  createdById: json['createdById'] as String? ?? '',
  createdByName: json['createdByName'] as String? ?? '',
  billId: json['billId'] as String?,
  seatedAt: const NullableTimestampConverter().fromJson(json['seatedAt']),
  completedAt: const NullableTimestampConverter().fromJson(json['completedAt']),
  cancelledAt: const NullableTimestampConverter().fromJson(json['cancelledAt']),
  createdAt: const NullableTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$ReservationModelToJson(
  _ReservationModel instance,
) => <String, dynamic>{
  'customerId': instance.customerId,
  'customerName': instance.customerName,
  'customerPhone': instance.customerPhone,
  'partySize': instance.partySize,
  'startAt': const TimestampConverter().toJson(instance.startAt),
  'endAt': const TimestampConverter().toJson(instance.endAt),
  'durationMinutes': instance.durationMinutes,
  'tableIds': instance.tableIds,
  'tableLabels': instance.tableLabels,
  'status': _$ReservationStatusEnumMap[instance.status]!,
  'source': _$ReservationSourceEnumMap[instance.source]!,
  'occasion': _$ReservationOccasionEnumMap[instance.occasion]!,
  'notes': instance.notes,
  'createdById': instance.createdById,
  'createdByName': instance.createdByName,
  'billId': instance.billId,
  'seatedAt': const NullableTimestampConverter().toJson(instance.seatedAt),
  'completedAt': const NullableTimestampConverter().toJson(
    instance.completedAt,
  ),
  'cancelledAt': const NullableTimestampConverter().toJson(
    instance.cancelledAt,
  ),
  'createdAt': const NullableTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};

const _$ReservationStatusEnumMap = {
  ReservationStatus.pending: 'pending',
  ReservationStatus.confirmed: 'confirmed',
  ReservationStatus.seated: 'seated',
  ReservationStatus.completed: 'completed',
  ReservationStatus.cancelled: 'cancelled',
  ReservationStatus.noShow: 'noShow',
};

const _$ReservationSourceEnumMap = {
  ReservationSource.phone: 'phone',
  ReservationSource.walkIn: 'walkIn',
  ReservationSource.online: 'online',
  ReservationSource.social: 'social',
  ReservationSource.other: 'other',
};

const _$ReservationOccasionEnumMap = {
  ReservationOccasion.none: 'none',
  ReservationOccasion.birthday: 'birthday',
  ReservationOccasion.anniversary: 'anniversary',
  ReservationOccasion.business: 'business',
  ReservationOccasion.date: 'date',
  ReservationOccasion.family: 'family',
  ReservationOccasion.celebration: 'celebration',
};
