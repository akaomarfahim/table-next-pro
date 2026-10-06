// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FloorAreaModel _$FloorAreaModelFromJson(Map json) => _FloorAreaModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  width: (json['width'] as num?)?.toDouble() ?? 1600.0,
  height: (json['height'] as num?)?.toDouble() ?? 1000.0,
  createdAt: const NullableTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$FloorAreaModelToJson(
  _FloorAreaModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'sortOrder': instance.sortOrder,
  'width': instance.width,
  'height': instance.height,
  'createdAt': const NullableTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};

_FloorElementModel _$FloorElementModelFromJson(Map json) => _FloorElementModel(
  id: json['id'] as String? ?? '',
  floorId: json['floorId'] as String,
  kind: $enumDecode(
    _$ElementKindEnumMap,
    json['kind'],
    unknownValue: ElementKind.structure,
  ),
  label: json['label'] as String? ?? '',
  tableShape:
      $enumDecodeNullable(
        _$TableShapeEnumMap,
        json['tableShape'],
        unknownValue: TableShape.rectangle,
      ) ??
      TableShape.rectangle,
  structureType: $enumDecodeNullable(
    _$StructureTypeEnumMap,
    json['structureType'],
    unknownValue: StructureType.zone,
  ),
  seats: (json['seats'] as num?)?.toInt() ?? 0,
  x: (json['x'] as num?)?.toDouble() ?? 0.0,
  y: (json['y'] as num?)?.toDouble() ?? 0.0,
  width: (json['width'] as num?)?.toDouble() ?? 100.0,
  height: (json['height'] as num?)?.toDouble() ?? 100.0,
  rotation: (json['rotation'] as num?)?.toInt() ?? 0,
  active: json['active'] as bool? ?? true,
  createdAt: const NullableTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$FloorElementModelToJson(
  _FloorElementModel instance,
) => <String, dynamic>{
  'floorId': instance.floorId,
  'kind': _$ElementKindEnumMap[instance.kind]!,
  'label': instance.label,
  'tableShape': _$TableShapeEnumMap[instance.tableShape]!,
  'structureType': _$StructureTypeEnumMap[instance.structureType],
  'seats': instance.seats,
  'x': instance.x,
  'y': instance.y,
  'width': instance.width,
  'height': instance.height,
  'rotation': instance.rotation,
  'active': instance.active,
  'createdAt': const NullableTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};

const _$ElementKindEnumMap = {
  ElementKind.table: 'table',
  ElementKind.structure: 'structure',
};

const _$TableShapeEnumMap = {
  TableShape.round: 'round',
  TableShape.rectangle: 'rectangle',
  TableShape.square: 'square',
};

const _$StructureTypeEnumMap = {
  StructureType.kitchen: 'kitchen',
  StructureType.bar: 'bar',
  StructureType.register: 'register',
  StructureType.hostStand: 'hostStand',
  StructureType.entrance: 'entrance',
  StructureType.restroom: 'restroom',
  StructureType.stage: 'stage',
  StructureType.buffet: 'buffet',
  StructureType.storage: 'storage',
  StructureType.stairs: 'stairs',
  StructureType.wall: 'wall',
  StructureType.window: 'window',
  StructureType.pillar: 'pillar',
  StructureType.plant: 'plant',
  StructureType.zone: 'zone',
};
