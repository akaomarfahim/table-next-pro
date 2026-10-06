// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomerModel _$CustomerModelFromJson(Map json) => _CustomerModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String,
  phone: json['phone'] as String,
  phoneNormalized: json['phoneNormalized'] as String? ?? '',
  nameLower: json['nameLower'] as String? ?? '',
  email: json['email'] as String? ?? '',
  notes: json['notes'] as String? ?? '',
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  isVip: json['isVip'] as bool? ?? false,
  birthday: const NullableTimestampConverter().fromJson(json['birthday']),
  visitCount: (json['visitCount'] as num?)?.toInt() ?? 0,
  reservationCount: (json['reservationCount'] as num?)?.toInt() ?? 0,
  noShowCount: (json['noShowCount'] as num?)?.toInt() ?? 0,
  totalSpent: (json['totalSpent'] as num?)?.toDouble() ?? 0.0,
  lastVisitAt: const NullableTimestampConverter().fromJson(json['lastVisitAt']),
  createdAt: const NullableTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$CustomerModelToJson(
  _CustomerModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'phoneNormalized': instance.phoneNormalized,
  'nameLower': instance.nameLower,
  'email': instance.email,
  'notes': instance.notes,
  'tags': instance.tags,
  'isVip': instance.isVip,
  'birthday': const NullableTimestampConverter().toJson(instance.birthday),
  'visitCount': instance.visitCount,
  'reservationCount': instance.reservationCount,
  'noShowCount': instance.noShowCount,
  'totalSpent': instance.totalSpent,
  'lastVisitAt': const NullableTimestampConverter().toJson(
    instance.lastVisitAt,
  ),
  'createdAt': const NullableTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};
