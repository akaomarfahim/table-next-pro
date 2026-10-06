// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MenuCategoryModel {

@JsonKey(includeToJson: false) String get id; String get name; int get sortOrder; bool get active;@NullableTimestampConverter() DateTime? get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;
/// Create a copy of MenuCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuCategoryModelCopyWith<MenuCategoryModel> get copyWith => _$MenuCategoryModelCopyWithImpl<MenuCategoryModel>(this as MenuCategoryModel, _$identity);

  /// Serializes this MenuCategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,active,createdAt,updatedAt);

@override
String toString() {
  return 'MenuCategoryModel(id: $id, name: $name, sortOrder: $sortOrder, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MenuCategoryModelCopyWith<$Res>  {
  factory $MenuCategoryModelCopyWith(MenuCategoryModel value, $Res Function(MenuCategoryModel) _then) = _$MenuCategoryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String id, String name, int sortOrder, bool active,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$MenuCategoryModelCopyWithImpl<$Res>
    implements $MenuCategoryModelCopyWith<$Res> {
  _$MenuCategoryModelCopyWithImpl(this._self, this._then);

  final MenuCategoryModel _self;
  final $Res Function(MenuCategoryModel) _then;

/// Create a copy of MenuCategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? active = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuCategoryModel].
extension MenuCategoryModelPatterns on MenuCategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuCategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuCategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuCategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _MenuCategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuCategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _MenuCategoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String name,  int sortOrder,  bool active, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.active,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String name,  int sortOrder,  bool active, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MenuCategoryModel():
return $default(_that.id,_that.name,_that.sortOrder,_that.active,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String id,  String name,  int sortOrder,  bool active, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MenuCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.active,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MenuCategoryModel extends MenuCategoryModel {
  const _MenuCategoryModel({@JsonKey(includeToJson: false) this.id = '', required this.name, this.sortOrder = 0, this.active = true, @NullableTimestampConverter() this.createdAt, @NullableTimestampConverter() this.updatedAt}): super._();
  factory _MenuCategoryModel.fromJson(Map<String, dynamic> json) => _$MenuCategoryModelFromJson(json);

@override@JsonKey(includeToJson: false) final  String id;
@override final  String name;
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  bool active;
@override@NullableTimestampConverter() final  DateTime? createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of MenuCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuCategoryModelCopyWith<_MenuCategoryModel> get copyWith => __$MenuCategoryModelCopyWithImpl<_MenuCategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuCategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,active,createdAt,updatedAt);

@override
String toString() {
  return 'MenuCategoryModel(id: $id, name: $name, sortOrder: $sortOrder, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MenuCategoryModelCopyWith<$Res> implements $MenuCategoryModelCopyWith<$Res> {
  factory _$MenuCategoryModelCopyWith(_MenuCategoryModel value, $Res Function(_MenuCategoryModel) _then) = __$MenuCategoryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String id, String name, int sortOrder, bool active,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$MenuCategoryModelCopyWithImpl<$Res>
    implements _$MenuCategoryModelCopyWith<$Res> {
  __$MenuCategoryModelCopyWithImpl(this._self, this._then);

  final _MenuCategoryModel _self;
  final $Res Function(_MenuCategoryModel) _then;

/// Create a copy of MenuCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? active = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_MenuCategoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$MenuProductModel {

@JsonKey(includeToJson: false) String get id; String get categoryId; String get name; double get price; String get description; String get code; bool get available; bool get isVeg; bool get isSpicy; int get sortOrder;@NullableTimestampConverter() DateTime? get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;
/// Create a copy of MenuProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuProductModelCopyWith<MenuProductModel> get copyWith => _$MenuProductModelCopyWithImpl<MenuProductModel>(this as MenuProductModel, _$identity);

  /// Serializes this MenuProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.code, code) || other.code == code)&&(identical(other.available, available) || other.available == available)&&(identical(other.isVeg, isVeg) || other.isVeg == isVeg)&&(identical(other.isSpicy, isSpicy) || other.isSpicy == isSpicy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,name,price,description,code,available,isVeg,isSpicy,sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'MenuProductModel(id: $id, categoryId: $categoryId, name: $name, price: $price, description: $description, code: $code, available: $available, isVeg: $isVeg, isSpicy: $isSpicy, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MenuProductModelCopyWith<$Res>  {
  factory $MenuProductModelCopyWith(MenuProductModel value, $Res Function(MenuProductModel) _then) = _$MenuProductModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String id, String categoryId, String name, double price, String description, String code, bool available, bool isVeg, bool isSpicy, int sortOrder,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$MenuProductModelCopyWithImpl<$Res>
    implements $MenuProductModelCopyWith<$Res> {
  _$MenuProductModelCopyWithImpl(this._self, this._then);

  final MenuProductModel _self;
  final $Res Function(MenuProductModel) _then;

/// Create a copy of MenuProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? price = null,Object? description = null,Object? code = null,Object? available = null,Object? isVeg = null,Object? isSpicy = null,Object? sortOrder = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,isVeg: null == isVeg ? _self.isVeg : isVeg // ignore: cast_nullable_to_non_nullable
as bool,isSpicy: null == isSpicy ? _self.isSpicy : isSpicy // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuProductModel].
extension MenuProductModelPatterns on MenuProductModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuProductModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuProductModel value)  $default,){
final _that = this;
switch (_that) {
case _MenuProductModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _MenuProductModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String categoryId,  String name,  double price,  String description,  String code,  bool available,  bool isVeg,  bool isSpicy,  int sortOrder, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuProductModel() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.price,_that.description,_that.code,_that.available,_that.isVeg,_that.isSpicy,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String categoryId,  String name,  double price,  String description,  String code,  bool available,  bool isVeg,  bool isSpicy,  int sortOrder, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MenuProductModel():
return $default(_that.id,_that.categoryId,_that.name,_that.price,_that.description,_that.code,_that.available,_that.isVeg,_that.isSpicy,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String id,  String categoryId,  String name,  double price,  String description,  String code,  bool available,  bool isVeg,  bool isSpicy,  int sortOrder, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MenuProductModel() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.price,_that.description,_that.code,_that.available,_that.isVeg,_that.isSpicy,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MenuProductModel extends MenuProductModel {
  const _MenuProductModel({@JsonKey(includeToJson: false) this.id = '', required this.categoryId, required this.name, required this.price, this.description = '', this.code = '', this.available = true, this.isVeg = false, this.isSpicy = false, this.sortOrder = 0, @NullableTimestampConverter() this.createdAt, @NullableTimestampConverter() this.updatedAt}): super._();
  factory _MenuProductModel.fromJson(Map<String, dynamic> json) => _$MenuProductModelFromJson(json);

@override@JsonKey(includeToJson: false) final  String id;
@override final  String categoryId;
@override final  String name;
@override final  double price;
@override@JsonKey() final  String description;
@override@JsonKey() final  String code;
@override@JsonKey() final  bool available;
@override@JsonKey() final  bool isVeg;
@override@JsonKey() final  bool isSpicy;
@override@JsonKey() final  int sortOrder;
@override@NullableTimestampConverter() final  DateTime? createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of MenuProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuProductModelCopyWith<_MenuProductModel> get copyWith => __$MenuProductModelCopyWithImpl<_MenuProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.code, code) || other.code == code)&&(identical(other.available, available) || other.available == available)&&(identical(other.isVeg, isVeg) || other.isVeg == isVeg)&&(identical(other.isSpicy, isSpicy) || other.isSpicy == isSpicy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,name,price,description,code,available,isVeg,isSpicy,sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'MenuProductModel(id: $id, categoryId: $categoryId, name: $name, price: $price, description: $description, code: $code, available: $available, isVeg: $isVeg, isSpicy: $isSpicy, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MenuProductModelCopyWith<$Res> implements $MenuProductModelCopyWith<$Res> {
  factory _$MenuProductModelCopyWith(_MenuProductModel value, $Res Function(_MenuProductModel) _then) = __$MenuProductModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String id, String categoryId, String name, double price, String description, String code, bool available, bool isVeg, bool isSpicy, int sortOrder,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$MenuProductModelCopyWithImpl<$Res>
    implements _$MenuProductModelCopyWith<$Res> {
  __$MenuProductModelCopyWithImpl(this._self, this._then);

  final _MenuProductModel _self;
  final $Res Function(_MenuProductModel) _then;

/// Create a copy of MenuProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? price = null,Object? description = null,Object? code = null,Object? available = null,Object? isVeg = null,Object? isSpicy = null,Object? sortOrder = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_MenuProductModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,isVeg: null == isVeg ? _self.isVeg : isVeg // ignore: cast_nullable_to_non_nullable
as bool,isSpicy: null == isSpicy ? _self.isSpicy : isSpicy // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
