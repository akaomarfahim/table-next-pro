import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/json_converters.dart';
import '../../domain/entities/menu_entities.dart';

part 'menu_models.freezed.dart';
part 'menu_models.g.dart';

@freezed
abstract class MenuCategoryModel with _$MenuCategoryModel {
  const MenuCategoryModel._();

  const factory MenuCategoryModel({
    @JsonKey(includeToJson: false) @Default('') String id,
    required String name,
    @Default(0) int sortOrder,
    @Default(true) bool active,
    @NullableTimestampConverter() DateTime? createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _MenuCategoryModel;

  factory MenuCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MenuCategoryModelFromJson(json);

  factory MenuCategoryModel.fromEntity(MenuCategory e) => MenuCategoryModel(
        id: e.id,
        name: e.name,
        sortOrder: e.sortOrder,
        active: e.active,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  MenuCategory toEntity() => MenuCategory(
        id: id,
        name: name,
        sortOrder: sortOrder,
        active: active,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

@freezed
abstract class MenuProductModel with _$MenuProductModel {
  const MenuProductModel._();

  const factory MenuProductModel({
    @JsonKey(includeToJson: false) @Default('') String id,
    required String categoryId,
    required String name,
    required double price,
    @Default('') String description,
    @Default('') String code,
    @Default(true) bool available,
    @Default(false) bool isVeg,
    @Default(false) bool isSpicy,
    @Default(0) int sortOrder,
    @NullableTimestampConverter() DateTime? createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _MenuProductModel;

  factory MenuProductModel.fromJson(Map<String, dynamic> json) =>
      _$MenuProductModelFromJson(json);

  factory MenuProductModel.fromEntity(MenuProduct e) => MenuProductModel(
        id: e.id,
        categoryId: e.categoryId,
        name: e.name,
        price: e.price,
        description: e.description,
        code: e.code,
        available: e.available,
        isVeg: e.isVeg,
        isSpicy: e.isSpicy,
        sortOrder: e.sortOrder,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  MenuProduct toEntity() => MenuProduct(
        id: id,
        categoryId: categoryId,
        name: name,
        price: price,
        description: description,
        code: code,
        available: available,
        isVeg: isVeg,
        isSpicy: isSpicy,
        sortOrder: sortOrder,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
