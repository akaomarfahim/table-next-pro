// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUserModel _$AppUserModelFromJson(Map json) => _AppUserModel(
  id: json['id'] as String? ?? '',
  businessId: json['businessId'] as String,
  name: json['name'] as String,
  username: json['username'] as String,
  role:
      $enumDecodeNullable(
        _$UserRoleEnumMap,
        json['role'],
        unknownValue: UserRole.waiter,
      ) ??
      UserRole.waiter,
  pinHash: json['pinHash'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  active: json['active'] as bool? ?? true,
  lastLoginAt: const NullableTimestampConverter().fromJson(json['lastLoginAt']),
  createdAt: const NullableTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$AppUserModelToJson(
  _AppUserModel instance,
) => <String, dynamic>{
  'businessId': instance.businessId,
  'name': instance.name,
  'username': instance.username,
  'role': _$UserRoleEnumMap[instance.role]!,
  'pinHash': instance.pinHash,
  'phone': instance.phone,
  'active': instance.active,
  'lastLoginAt': const NullableTimestampConverter().toJson(
    instance.lastLoginAt,
  ),
  'createdAt': const NullableTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};

const _$UserRoleEnumMap = {
  UserRole.owner: 'owner',
  UserRole.manager: 'manager',
  UserRole.host: 'host',
  UserRole.cashier: 'cashier',
  UserRole.waiter: 'waiter',
};
