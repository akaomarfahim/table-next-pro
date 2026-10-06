// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MenuCategoryModel _$MenuCategoryModelFromJson(Map json) => _MenuCategoryModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  active: json['active'] as bool? ?? true,
  createdAt: const NullableTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$MenuCategoryModelToJson(
  _MenuCategoryModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'sortOrder': instance.sortOrder,
  'active': instance.active,
  'createdAt': const NullableTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};

_MenuProductModel _$MenuProductModelFromJson(Map json) => _MenuProductModel(
  id: json['id'] as String? ?? '',
  categoryId: json['categoryId'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  description: json['description'] as String? ?? '',
  code: json['code'] as String? ?? '',
  available: json['available'] as bool? ?? true,
  isVeg: json['isVeg'] as bool? ?? false,
  isSpicy: json['isSpicy'] as bool? ?? false,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  createdAt: const NullableTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$MenuProductModelToJson(
  _MenuProductModel instance,
) => <String, dynamic>{
  'categoryId': instance.categoryId,
  'name': instance.name,
  'price': instance.price,
  'description': instance.description,
  'code': instance.code,
  'available': instance.available,
  'isVeg': instance.isVeg,
  'isSpicy': instance.isSpicy,
  'sortOrder': instance.sortOrder,
  'createdAt': const NullableTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};
