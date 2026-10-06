// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor_element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FloorElement {

 String get id; String get floorId; ElementKind get kind; String get label; TableShape get tableShape; StructureType? get structureType; int get seats; double get x; double get y; double get width; double get height;/// 0 or 90 (degrees). Used for rectangle tables orientation.
 int get rotation; bool get active; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of FloorElement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FloorElementCopyWith<FloorElement> get copyWith => _$FloorElementCopyWithImpl<FloorElement>(this as FloorElement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FloorElement&&(identical(other.id, id) || other.id == id)&&(identical(other.floorId, floorId) || other.floorId == floorId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.label, label) || other.label == label)&&(identical(other.tableShape, tableShape) || other.tableShape == tableShape)&&(identical(other.structureType, structureType) || other.structureType == structureType)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,floorId,kind,label,tableShape,structureType,seats,x,y,width,height,rotation,active,createdAt,updatedAt);

@override
String toString() {
  return 'FloorElement(id: $id, floorId: $floorId, kind: $kind, label: $label, tableShape: $tableShape, structureType: $structureType, seats: $seats, x: $x, y: $y, width: $width, height: $height, rotation: $rotation, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FloorElementCopyWith<$Res>  {
  factory $FloorElementCopyWith(FloorElement value, $Res Function(FloorElement) _then) = _$FloorElementCopyWithImpl;
@useResult
$Res call({
 String id, String floorId, ElementKind kind, String label, TableShape tableShape, StructureType? structureType, int seats, double x, double y, double width, double height, int rotation, bool active, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$FloorElementCopyWithImpl<$Res>
    implements $FloorElementCopyWith<$Res> {
  _$FloorElementCopyWithImpl(this._self, this._then);

  final FloorElement _self;
  final $Res Function(FloorElement) _then;

/// Create a copy of FloorElement
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


/// Adds pattern-matching-related methods to [FloorElement].
extension FloorElementPatterns on FloorElement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FloorElement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FloorElement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FloorElement value)  $default,){
final _that = this;
switch (_that) {
case _FloorElement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FloorElement value)?  $default,){
final _that = this;
switch (_that) {
case _FloorElement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String floorId,  ElementKind kind,  String label,  TableShape tableShape,  StructureType? structureType,  int seats,  double x,  double y,  double width,  double height,  int rotation,  bool active,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FloorElement() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String floorId,  ElementKind kind,  String label,  TableShape tableShape,  StructureType? structureType,  int seats,  double x,  double y,  double width,  double height,  int rotation,  bool active,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FloorElement():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String floorId,  ElementKind kind,  String label,  TableShape tableShape,  StructureType? structureType,  int seats,  double x,  double y,  double width,  double height,  int rotation,  bool active,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FloorElement() when $default != null:
return $default(_that.id,_that.floorId,_that.kind,_that.label,_that.tableShape,_that.structureType,_that.seats,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.active,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FloorElement extends FloorElement {
  const _FloorElement({required this.id, required this.floorId, required this.kind, required this.label, this.tableShape = TableShape.rectangle, this.structureType, this.seats = 0, this.x = 0.0, this.y = 0.0, this.width = 100.0, this.height = 100.0, this.rotation = 0, this.active = true, this.createdAt, this.updatedAt}): super._();
  

@override final  String id;
@override final  String floorId;
@override final  ElementKind kind;
@override final  String label;
@override@JsonKey() final  TableShape tableShape;
@override final  StructureType? structureType;
@override@JsonKey() final  int seats;
@override@JsonKey() final  double x;
@override@JsonKey() final  double y;
@override@JsonKey() final  double width;
@override@JsonKey() final  double height;
/// 0 or 90 (degrees). Used for rectangle tables orientation.
@override@JsonKey() final  int rotation;
@override@JsonKey() final  bool active;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of FloorElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FloorElementCopyWith<_FloorElement> get copyWith => __$FloorElementCopyWithImpl<_FloorElement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FloorElement&&(identical(other.id, id) || other.id == id)&&(identical(other.floorId, floorId) || other.floorId == floorId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.label, label) || other.label == label)&&(identical(other.tableShape, tableShape) || other.tableShape == tableShape)&&(identical(other.structureType, structureType) || other.structureType == structureType)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,floorId,kind,label,tableShape,structureType,seats,x,y,width,height,rotation,active,createdAt,updatedAt);

@override
String toString() {
  return 'FloorElement(id: $id, floorId: $floorId, kind: $kind, label: $label, tableShape: $tableShape, structureType: $structureType, seats: $seats, x: $x, y: $y, width: $width, height: $height, rotation: $rotation, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FloorElementCopyWith<$Res> implements $FloorElementCopyWith<$Res> {
  factory _$FloorElementCopyWith(_FloorElement value, $Res Function(_FloorElement) _then) = __$FloorElementCopyWithImpl;
@override @useResult
$Res call({
 String id, String floorId, ElementKind kind, String label, TableShape tableShape, StructureType? structureType, int seats, double x, double y, double width, double height, int rotation, bool active, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$FloorElementCopyWithImpl<$Res>
    implements _$FloorElementCopyWith<$Res> {
  __$FloorElementCopyWithImpl(this._self, this._then);

  final _FloorElement _self;
  final $Res Function(_FloorElement) _then;

/// Create a copy of FloorElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? floorId = null,Object? kind = null,Object? label = null,Object? tableShape = null,Object? structureType = freezed,Object? seats = null,Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? rotation = null,Object? active = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_FloorElement(
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
