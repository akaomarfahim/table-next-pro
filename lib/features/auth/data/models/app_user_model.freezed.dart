// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUserModel {

@JsonKey(includeToJson: false) String get id; String get businessId; String get name; String get username;@JsonKey(unknownEnumValue: UserRole.waiter) UserRole get role; String get pinHash; String get phone; bool get active;@NullableTimestampConverter() DateTime? get lastLoginAt;@NullableTimestampConverter() DateTime? get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;
/// Create a copy of AppUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUserModelCopyWith<AppUserModel> get copyWith => _$AppUserModelCopyWithImpl<AppUserModel>(this as AppUserModel, _$identity);

  /// Serializes this AppUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.role, role) || other.role == role)&&(identical(other.pinHash, pinHash) || other.pinHash == pinHash)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.active, active) || other.active == active)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,businessId,name,username,role,pinHash,phone,active,lastLoginAt,createdAt,updatedAt);

@override
String toString() {
  return 'AppUserModel(id: $id, businessId: $businessId, name: $name, username: $username, role: $role, pinHash: $pinHash, phone: $phone, active: $active, lastLoginAt: $lastLoginAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AppUserModelCopyWith<$Res>  {
  factory $AppUserModelCopyWith(AppUserModel value, $Res Function(AppUserModel) _then) = _$AppUserModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String id, String businessId, String name, String username,@JsonKey(unknownEnumValue: UserRole.waiter) UserRole role, String pinHash, String phone, bool active,@NullableTimestampConverter() DateTime? lastLoginAt,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$AppUserModelCopyWithImpl<$Res>
    implements $AppUserModelCopyWith<$Res> {
  _$AppUserModelCopyWithImpl(this._self, this._then);

  final AppUserModel _self;
  final $Res Function(AppUserModel) _then;

/// Create a copy of AppUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? businessId = null,Object? name = null,Object? username = null,Object? role = null,Object? pinHash = null,Object? phone = null,Object? active = null,Object? lastLoginAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessId: null == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,pinHash: null == pinHash ? _self.pinHash : pinHash // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUserModel].
extension AppUserModelPatterns on AppUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUserModel value)  $default,){
final _that = this;
switch (_that) {
case _AppUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _AppUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String businessId,  String name,  String username, @JsonKey(unknownEnumValue: UserRole.waiter)  UserRole role,  String pinHash,  String phone,  bool active, @NullableTimestampConverter()  DateTime? lastLoginAt, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUserModel() when $default != null:
return $default(_that.id,_that.businessId,_that.name,_that.username,_that.role,_that.pinHash,_that.phone,_that.active,_that.lastLoginAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String businessId,  String name,  String username, @JsonKey(unknownEnumValue: UserRole.waiter)  UserRole role,  String pinHash,  String phone,  bool active, @NullableTimestampConverter()  DateTime? lastLoginAt, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AppUserModel():
return $default(_that.id,_that.businessId,_that.name,_that.username,_that.role,_that.pinHash,_that.phone,_that.active,_that.lastLoginAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String id,  String businessId,  String name,  String username, @JsonKey(unknownEnumValue: UserRole.waiter)  UserRole role,  String pinHash,  String phone,  bool active, @NullableTimestampConverter()  DateTime? lastLoginAt, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AppUserModel() when $default != null:
return $default(_that.id,_that.businessId,_that.name,_that.username,_that.role,_that.pinHash,_that.phone,_that.active,_that.lastLoginAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppUserModel extends AppUserModel {
  const _AppUserModel({@JsonKey(includeToJson: false) this.id = '', required this.businessId, required this.name, required this.username, @JsonKey(unknownEnumValue: UserRole.waiter) this.role = UserRole.waiter, this.pinHash = '', this.phone = '', this.active = true, @NullableTimestampConverter() this.lastLoginAt, @NullableTimestampConverter() this.createdAt, @NullableTimestampConverter() this.updatedAt}): super._();
  factory _AppUserModel.fromJson(Map<String, dynamic> json) => _$AppUserModelFromJson(json);

@override@JsonKey(includeToJson: false) final  String id;
@override final  String businessId;
@override final  String name;
@override final  String username;
@override@JsonKey(unknownEnumValue: UserRole.waiter) final  UserRole role;
@override@JsonKey() final  String pinHash;
@override@JsonKey() final  String phone;
@override@JsonKey() final  bool active;
@override@NullableTimestampConverter() final  DateTime? lastLoginAt;
@override@NullableTimestampConverter() final  DateTime? createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of AppUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUserModelCopyWith<_AppUserModel> get copyWith => __$AppUserModelCopyWithImpl<_AppUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.role, role) || other.role == role)&&(identical(other.pinHash, pinHash) || other.pinHash == pinHash)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.active, active) || other.active == active)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,businessId,name,username,role,pinHash,phone,active,lastLoginAt,createdAt,updatedAt);

@override
String toString() {
  return 'AppUserModel(id: $id, businessId: $businessId, name: $name, username: $username, role: $role, pinHash: $pinHash, phone: $phone, active: $active, lastLoginAt: $lastLoginAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AppUserModelCopyWith<$Res> implements $AppUserModelCopyWith<$Res> {
  factory _$AppUserModelCopyWith(_AppUserModel value, $Res Function(_AppUserModel) _then) = __$AppUserModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String id, String businessId, String name, String username,@JsonKey(unknownEnumValue: UserRole.waiter) UserRole role, String pinHash, String phone, bool active,@NullableTimestampConverter() DateTime? lastLoginAt,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$AppUserModelCopyWithImpl<$Res>
    implements _$AppUserModelCopyWith<$Res> {
  __$AppUserModelCopyWithImpl(this._self, this._then);

  final _AppUserModel _self;
  final $Res Function(_AppUserModel) _then;

/// Create a copy of AppUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? businessId = null,Object? name = null,Object? username = null,Object? role = null,Object? pinHash = null,Object? phone = null,Object? active = null,Object? lastLoginAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_AppUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessId: null == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,pinHash: null == pinHash ? _self.pinHash : pinHash // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
