// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessModel _$BusinessModelFromJson(Map json) => _BusinessModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String,
  phone: json['phone'] as String? ?? '',
  email: json['email'] as String? ?? '',
  address: json['address'] as String? ?? '',
  currencyCode: json['currencyCode'] as String? ?? 'BDT',
  currencySymbol: json['currencySymbol'] as String? ?? '৳',
  taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0.0,
  serviceChargeRate: (json['serviceChargeRate'] as num?)?.toDouble() ?? 0.0,
  defaultReservationMinutes:
      (json['defaultReservationMinutes'] as num?)?.toInt() ?? 90,
  openingHour: (json['openingHour'] as num?)?.toInt() ?? 10,
  closingHour: (json['closingHour'] as num?)?.toInt() ?? 23,
  billFooter: json['billFooter'] as String? ?? 'Thank you for dining with us!',
  active: json['active'] as bool? ?? true,
  createdAt: const NullableTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$BusinessModelToJson(
  _BusinessModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'email': instance.email,
  'address': instance.address,
  'currencyCode': instance.currencyCode,
  'currencySymbol': instance.currencySymbol,
  'taxRate': instance.taxRate,
  'serviceChargeRate': instance.serviceChargeRate,
  'defaultReservationMinutes': instance.defaultReservationMinutes,
  'openingHour': instance.openingHour,
  'closingHour': instance.closingHour,
  'billFooter': instance.billFooter,
  'active': instance.active,
  'createdAt': const NullableTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};
