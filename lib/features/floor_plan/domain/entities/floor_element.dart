import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../services/table_geometry.dart';
import 'floor_enums.dart';

part 'floor_element.freezed.dart';

/// A table or structure positioned on a [FloorArea] canvas.
///
/// Coordinates are canvas units (top-left origin). Table dimensions are
/// derived from shape + seats; structure dimensions are stored.
@freezed
abstract class FloorElement with _$FloorElement {
  const FloorElement._();

  const factory FloorElement({
    required String id,
    required String floorId,
    required ElementKind kind,
    required String label,
    @Default(TableShape.rectangle) TableShape tableShape,
    StructureType? structureType,
    @Default(0) int seats,
    @Default(0.0) double x,
    @Default(0.0) double y,
    @Default(100.0) double width,
    @Default(100.0) double height,
    /// 0 or 90 (degrees). Used for rectangle tables orientation.
    @Default(0) int rotation,
    @Default(true) bool active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FloorElement;

  bool get isTable => kind == ElementKind.table;
  bool get isStructure => kind == ElementKind.structure;
  bool get isVertical => rotation % 180 != 0;

  /// Rendered bounding size on the canvas.
  Size get size {
    if (isTable) {
      final s = TableGeometry.sizeFor(tableShape, seats);
      return isVertical ? Size(s.height, s.width) : s;
    }
    return Size(width, height);
  }

  Rect get rect => Offset(x, y) & size;

  Offset get center => rect.center;

  /// Paint order: zones → structures → tables.
  int get layer {
    if (isTable) return 2;
    if (structureType?.isBackground ?? false) return 0;
    return 1;
  }
}
