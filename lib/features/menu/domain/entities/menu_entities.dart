import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_entities.freezed.dart';

@freezed
abstract class MenuCategory with _$MenuCategory {
  const factory MenuCategory({
    required String id,
    required String name,
    @Default(0) int sortOrder,
    @Default(true) bool active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MenuCategory;
}

@freezed
abstract class MenuProduct with _$MenuProduct {
  const factory MenuProduct({
    required String id,
    required String categoryId,
    required String name,
    required double price,
    @Default('') String description,
    @Default('') String code,
    @Default(true) bool available,
    @Default(false) bool isVeg,
    @Default(false) bool isSpicy,
    @Default(0) int sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MenuProduct;
}
