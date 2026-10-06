// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FloorAreaModel {

@JsonKey(includeToJson: false) String get id; String get name; int get sortOrder; double get width; double get height;@NullableTimestampConverter() DateTime? get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;
/// Create a copy of FloorAreaModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FloorAreaModelCopyWith<FloorAreaModel> get copyWith => _$FloorAreaModelCopyWithImpl<FloorAreaModel>(this as FloorAreaModel, _$identity);

  /// Serializes this FloorAreaModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FloorAreaModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,width,height,createdAt,updatedAt);

@override
String toString() {
  return 'FloorAreaModel(id: $id, name: $name, sortOrder: $sortOrder, width: $width, height: $height, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FloorAreaModelCopyWith<$Res>  {
  factory $FloorAreaModelCopyWith(FloorAreaModel value, $Res Function(FloorAreaModel) _then) = _$FloorAreaModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String id, String name, int sortOrder, double width, double height,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$FloorAreaModelCopyWithImpl<$Res>
    implements $FloorAreaModelCopyWith<$Res> {
  _$FloorAreaModelCopyWithImpl(this._self, this._then);

  final FloorAreaModel _self;
  final $Res Function(FloorAreaModel) _then;

/// Create a copy of FloorAreaModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? width = null,Object? height = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FloorAreaModel].
extension FloorAreaModelPatterns on FloorAreaModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FloorAreaModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FloorAreaModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FloorAreaModel value)  $default,){
final _that = this;
switch (_that) {
case _FloorAreaModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FloorAreaModel value)?  $default,){
final _that = this;
switch (_that) {
case _FloorAreaModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String name,  int sortOrder,  double width,  double height, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FloorAreaModel() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.width,_that.height,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String name,  int sortOrder,  double width,  double height, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FloorAreaModel():
return $default(_that.id,_that.name,_that.sortOrder,_that.width,_that.height,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String id,  String name,  int sortOrder,  double width,  double height, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FloorAreaModel() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.width,_that.height,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FloorAreaModel extends FloorAreaModel {
  const _FloorAreaModel({@JsonKey(includeToJson: false) this.id = '', required this.name, this.sortOrder = 0, this.width = 1600.0, this.height = 1000.0, @NullableTimestampConverter() this.createdAt, @NullableTimestampConverter() this.updatedAt}): super._();
  factory _FloorAreaModel.fromJson(Map<String, dynamic> json) => _$FloorAreaModelFromJson(json);

@override@JsonKey(includeToJson: false) final  String id;
@override final  String name;
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  double width;
@override@JsonKey() final  double height;
@override@NullableTimestampConverter() final  DateTime? createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of FloorAreaModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FloorAreaModelCopyWith<_FloorAreaModel> get copyWith => __$FloorAreaModelCopyWithImpl<_FloorAreaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FloorAreaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FloorAreaModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,width,height,createdAt,updatedAt);

@override
String toString() {
  return 'FloorAreaModel(id: $id, name: $name, sortOrder: $sortOrder, width: $width, height: $height, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FloorAreaModelCopyWith<$Res> implements $FloorAreaModelCopyWith<$Res> {
  factory _$FloorAreaModelCopyWith(_FloorAreaModel value, $Res Function(_FloorAreaModel) _then) = __$FloorAreaModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String id, String name, int sortOrder, double width, double height,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$FloorAreaModelCopyWithImpl<$Res>
    implements _$FloorAreaModelCopyWith<$Res> {
  __$FloorAreaModelCopyWithImpl(this._self, this._then);

  final _FloorAreaModel _self;
  final $Res Function(_FloorAreaModel) _then;

/// Create a copy of FloorAreaModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? width = null,Object? height = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_FloorAreaModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$FloorElementModel {

@JsonKey(includeToJson: false) String get id; String get floorId;@JsonKey(unknownEnumValue: ElementKind.structure) ElementKind get kind; String get label;@JsonKey(unknownEnumValue: TableShape.rectangle) TableShape get tableShape;@JsonKey(unknownEnumValue: StructureType.zone) StructureType? get structureType; int get seats; double get x; double get y; double get width; double get height; int get rotation; bool get active;@NullableTimestampConverter() DateTime? get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;
/// Create a copy of FloorElementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FloorElementModelCopyWith<FloorElementModel> get copyWith => _$FloorElementModelCopyWithImpl<FloorElementModel>(this as FloorElementModel, _$identity);

  /// Serializes this FloorElementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FloorElementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.floorId, floorId) || other.floorId == floorId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.label, label) || other.label == label)&&(identical(other.tableShape, tableShape) || other.tableShape == tableShape)&&(identical(other.structureType, structureType) || other.structureType == structureType)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,floorId,kind,label,tableShape,structureType,seats,x,y,width,height,rotation,active,createdAt,updatedAt);

@override
String toString() {
  return 'FloorElementModel(id: $id, floorId: $floorId, kind: $kind, label: $label, tableShape: $tableShape, structureType: $structureType, seats: $seats, x: $x, y: $y, width: $width, height: $height, rotation: $rotation, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FloorElementModelCopyWith<$Res>  {
  factory $FloorElementModelCopyWith(FloorElementModel value, $Res Function(FloorElementModel) _then) = _$FloorElementModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String id, String floorId,@JsonKey(unknownEnumValue: ElementKind.structure) ElementKind kind, String label,@JsonKey(unknownEnumValue: TableShape.rectangle) TableShape tableShape,@JsonKey(unknownEnumValue: StructureType.zone) StructureType? structureType, int seats, double x, double y, double width, double height, int rotation, bool active,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$FloorElementModelCopyWithImpl<$Res>
    implements $FloorElementModelCopyWith<$Res> {
  _$FloorElementModelCopyWithImpl(this._self, this._then);

  final FloorElementModel _self;
  final $Res Function(FloorElementModel) _then;

/// Create a copy of FloorElementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? floorId = null,Object? kind = null,Object? label = null,Object? tableShape = null,Object? structureType = freezed,Object? seats = null,Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? rotation = null,Object? active = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,floorId: null == floorId ? _self.floorId : floorId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ElementKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tableShape: null == tableShape ? _self.tableShape : tableShape // ignore: cast_nullable_to_non_nullable
as TableShape,structureType: freezed == structureType ? _self.structureType : structureType // ignore: cast_nullable_to_non_nullable
as StructureType?,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FloorElementModel].
extension FloorElementModelPatterns on FloorElementModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FloorElementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FloorElementModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FloorElementModel value)  $default,){
final _that = this;
switch (_that) {
case _FloorElementModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FloorElementModel value)?  $default,){
final _that = this;
switch (_that) {
case _FloorElementModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String floorId, @JsonKey(unknownEnumValue: ElementKind.structure)  ElementKind kind,  String label, @JsonKey(unknownEnumValue: TableShape.rectangle)  TableShape tableShape, @JsonKey(unknownEnumValue: StructureType.zone)  StructureType? structureType,  int seats,  double x,  double y,  double width,  double height,  int rotation,  bool active, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FloorElementModel() when $default != null:
return $default(_that.id,_that.floorId,_that.kind,_that.label,_that.tableShape,_that.structureType,_that.seats,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.active,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String floorId, @JsonKey(unknownEnumValue: ElementKind.structure)  ElementKind kind,  String label, @JsonKey(unknownEnumValue: TableShape.rectangle)  TableShape tableShape, @JsonKey(unknownEnumValue: StructureType.zone)  StructureType? structureType,  int seats,  double x,  double y,  double width,  double height,  int rotation,  bool active, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FloorElementModel():
return $default(_that.id,_that.floorId,_that.kind,_that.label,_that.tableShape,_that.structureType,_that.seats,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.active,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String id,  String floorId, @JsonKey(unknownEnumValue: ElementKind.structure)  ElementKind kind,  String label, @JsonKey(unknownEnumValue: TableShape.rectangle)  TableShape tableShape, @JsonKey(unknownEnumValue: StructureType.zone)  StructureType? structureType,  int seats,  double x,  double y,  double width,  double height,  int rotation,  bool active, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FloorElementModel() when $default != null:
return $default(_that.id,_that.floorId,_that.kind,_that.label,_that.tableShape,_that.structureType,_that.seats,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.active,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FloorElementModel extends FloorElementModel {
  const _FloorElementModel({@JsonKey(includeToJson: false) this.id = '', required this.floorId, @JsonKey(unknownEnumValue: ElementKind.structure) required this.kind, this.label = '', @JsonKey(unknownEnumValue: TableShape.rectangle) this.tableShape = TableShape.rectangle, @JsonKey(unknownEnumValue: StructureType.zone) this.structureType, this.seats = 0, this.x = 0.0, this.y = 0.0, this.width = 100.0, this.height = 100.0, this.rotation = 0, this.active = true, @NullableTimestampConverter() this.createdAt, @NullableTimestampConverter() this.updatedAt}): super._();
  factory _FloorElementModel.fromJson(Map<String, dynamic> json) => _$FloorElementModelFromJson(json);

@override@JsonKey(includeToJson: false) final  String id;
@override final  String floorId;
@override@JsonKey(unknownEnumValue: ElementKind.structure) final  ElementKind kind;
@override@JsonKey() final  String label;
@override@JsonKey(unknownEnumValue: TableShape.rectangle) final  TableShape tableShape;
@override@JsonKey(unknownEnumValue: StructureType.zone) final  StructureType? structureType;
@override@JsonKey() final  int seats;
@override@JsonKey() final  double x;
@override@JsonKey() final  double y;
@override@JsonKey() final  double width;
@override@JsonKey() final  double height;
@override@JsonKey() final  int rotation;
@override@JsonKey() final  bool active;
@override@NullableTimestampConverter() final  DateTime? createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of FloorElementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FloorElementModelCopyWith<_FloorElementModel> get copyWith => __$FloorElementModelCopyWithImpl<_FloorElementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FloorElementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FloorElementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.floorId, floorId) || other.floorId == floorId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.label, label) || other.label == label)&&(identical(other.tableShape, tableShape) || other.tableShape == tableShape)&&(identical(other.structureType, structureType) || other.structureType == structureType)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,floorId,kind,label,tableShape,structureType,seats,x,y,width,height,rotation,active,createdAt,updatedAt);

@override
String toString() {
  return 'FloorElementModel(id: $id, floorId: $floorId, kind: $kind, label: $label, tableShape: $tableShape, structureType: $structureType, seats: $seats, x: $x, y: $y, width: $width, height: $height, rotation: $rotation, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FloorElementModelCopyWith<$Res> implements $FloorElementModelCopyWith<$Res> {
  factory _$FloorElementModelCopyWith(_FloorElementModel value, $Res Function(_FloorElementModel) _then) = __$FloorElementModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String id, String floorId,@JsonKey(unknownEnumValue: ElementKind.structure) ElementKind kind, String label,@JsonKey(unknownEnumValue: TableShape.rectangle) TableShape tableShape,@JsonKey(unknownEnumValue: StructureType.zone) StructureType? structureType, int seats, double x, double y, double width, double height, int rotation, bool active,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$FloorElementModelCopyWithImpl<$Res>
    implements _$FloorElementModelCopyWith<$Res> {
  __$FloorElementModelCopyWithImpl(this._self, this._then);

  final _FloorElementModel _self;
  final $Res Function(_FloorElementModel) _then;

/// Create a copy of FloorElementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? floorId = null,Object? kind = null,Object? label = null,Object? tableShape = null,Object? structureType = freezed,Object? seats = null,Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? rotation = null,Object? active = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_FloorElementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,floorId: null == floorId ? _self.floorId : floorId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ElementKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tableShape: null == tableShape ? _self.tableShape : tableShape // ignore: cast_nullable_to_non_nullable
as TableShape,structureType: freezed == structureType ? _self.structureType : structureType // ignore: cast_nullable_to_non_nullable
as StructureType?,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
