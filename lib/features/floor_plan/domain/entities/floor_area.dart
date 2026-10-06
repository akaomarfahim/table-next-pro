import 'package:freezed_annotation/freezed_annotation.dart';

part 'floor_area.freezed.dart';

/// A floor / dining area (e.g. "Main hall", "Rooftop") with its own canvas.
@freezed
abstract class FloorArea with _$FloorArea {
  const factory FloorArea({
    required String id,
    required String name,
    @Default(0) int sortOrder,
    @Default(1600.0) double width,
    @Default(1000.0) double height,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FloorArea;
}
