import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/json_converters.dart';
import '../../domain/entities/floor_area.dart';
import '../../domain/entities/floor_element.dart';
import '../../domain/entities/floor_enums.dart';

part 'floor_models.freezed.dart';
part 'floor_models.g.dart';

@freezed
abstract class FloorAreaModel with _$FloorAreaModel {
  const FloorAreaModel._();

  const factory FloorAreaModel({
    @JsonKey(includeToJson: false) @Default('') String id,
    required String name,
    @Default(0) int sortOrder,
    @Default(1600.0) double width,
    @Default(1000.0) double height,
    @NullableTimestampConverter() DateTime? createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _FloorAreaModel;

  factory FloorAreaModel.fromJson(Map<String, dynamic> json) =>
      _$FloorAreaModelFromJson(json);

  factory FloorAreaModel.fromEntity(FloorArea e) => FloorAreaModel(
        id: e.id,
        name: e.name,
        sortOrder: e.sortOrder,
        width: e.width,
        height: e.height,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  FloorArea toEntity() => FloorArea(
        id: id,
        name: name,
        sortOrder: sortOrder,
        width: width,
        height: height,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

@freezed
abstract class FloorElementModel with _$FloorElementModel {
  const FloorElementModel._();

  const factory FloorElementModel({
    @JsonKey(includeToJson: false) @Default('') String id,
    required String floorId,
    @JsonKey(unknownEnumValue: ElementKind.structure) required ElementKind kind,
    @Default('') String label,
    @JsonKey(unknownEnumValue: TableShape.rectangle)
    @Default(TableShape.rectangle)
    TableShape tableShape,
    @JsonKey(unknownEnumValue: StructureType.zone) StructureType? structureType,
    @Default(0) int seats,
    @Default(0.0) double x,
    @Default(0.0) double y,
    @Default(100.0) double width,
    @Default(100.0) double height,
    @Default(0) int rotation,
    @Default(true) bool active,
    @NullableTimestampConverter() DateTime? createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _FloorElementModel;

  factory FloorElementModel.fromJson(Map<String, dynamic> json) =>
      _$FloorElementModelFromJson(json);

  factory FloorElementModel.fromEntity(FloorElement e) => FloorElementModel(
        id: e.id,
        floorId: e.floorId,
        kind: e.kind,
        label: e.label,
        tableShape: e.tableShape,
        structureType: e.structureType,
        seats: e.seats,
        x: e.x,
        y: e.y,
        width: e.width,
        height: e.height,
        rotation: e.rotation,
        active: e.active,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  FloorElement toEntity() => FloorElement(
        id: id,
        floorId: floorId,
        kind: kind,
        label: label,
        tableShape: tableShape,
        structureType: structureType,
        seats: seats,
        x: x,
        y: y,
        width: width,
        height: height,
        rotation: rotation,
        active: active,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
