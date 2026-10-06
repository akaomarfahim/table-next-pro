// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Customer {

 String get id; String get name; String get phone; String get email; String get notes; List<String> get tags; bool get isVip; DateTime? get birthday; int get visitCount; int get reservationCount; int get noShowCount; double get totalSpent; DateTime? get lastVisitAt; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerCopyWith<Customer> get copyWith => _$CustomerCopyWithImpl<Customer>(this as Customer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Customer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.isVip, isVip) || other.isVip == isVip)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.visitCount, visitCount) || other.visitCount == visitCount)&&(identical(other.reservationCount, reservationCount) || other.reservationCount == reservationCount)&&(identical(other.noShowCount, noShowCount) || other.noShowCount == noShowCount)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.lastVisitAt, lastVisitAt) || other.lastVisitAt == lastVisitAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,email,notes,const DeepCollectionEquality().hash(tags),isVip,birthday,visitCount,reservationCount,noShowCount,totalSpent,lastVisitAt,createdAt,updatedAt);

@override
String toString() {
  return 'Customer(id: $id, name: $name, phone: $phone, email: $email, notes: $notes, tags: $tags, isVip: $isVip, birthday: $birthday, visitCount: $visitCount, reservationCount: $reservationCount, noShowCount: $noShowCount, totalSpent: $totalSpent, lastVisitAt: $lastVisitAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CustomerCopyWith<$Res>  {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) _then) = _$CustomerCopyWithImpl;
@useResult
$Res call({
 String id, String name, String phone, String email, String notes, List<String> tags, bool isVip, DateTime? birthday, int visitCount, int reservationCount, int noShowCount, double totalSpent, DateTime? lastVisitAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$CustomerCopyWithImpl<$Res>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._self, this._then);

  final Customer _self;
  final $Res Function(Customer) _then;

/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? email = null,Object? notes = null,Object? tags = null,Object? isVip = null,Object? birthday = freezed,Object? visitCount = null,Object? reservationCount = null,Object? noShowCount = null,Object? totalSpent = null,Object? lastVisitAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isVip: null == isVip ? _self.isVip : isVip // ignore: cast_nullable_to_non_nullable
as bool,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime?,visitCount: null == visitCount ? _self.visitCount : visitCount // ignore: cast_nullable_to_non_nullable
as int,reservationCount: null == reservationCount ? _self.reservationCount : reservationCount // ignore: cast_nullable_to_non_nullable
as int,noShowCount: null == noShowCount ? _self.noShowCount : noShowCount // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,lastVisitAt: freezed == lastVisitAt ? _self.lastVisitAt : lastVisitAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Customer].
extension CustomerPatterns on Customer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Customer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Customer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Customer value)  $default,){
final _that = this;
switch (_that) {
case _Customer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Customer value)?  $default,){
final _that = this;
switch (_that) {
case _Customer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  String email,  String notes,  List<String> tags,  bool isVip,  DateTime? birthday,  int visitCount,  int reservationCount,  int noShowCount,  double totalSpent,  DateTime? lastVisitAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Customer() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.email,_that.notes,_that.tags,_that.isVip,_that.birthday,_that.visitCount,_that.reservationCount,_that.noShowCount,_that.totalSpent,_that.lastVisitAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  String email,  String notes,  List<String> tags,  bool isVip,  DateTime? birthday,  int visitCount,  int reservationCount,  int noShowCount,  double totalSpent,  DateTime? lastVisitAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Customer():
return $default(_that.id,_that.name,_that.phone,_that.email,_that.notes,_that.tags,_that.isVip,_that.birthday,_that.visitCount,_that.reservationCount,_that.noShowCount,_that.totalSpent,_that.lastVisitAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String phone,  String email,  String notes,  List<String> tags,  bool isVip,  DateTime? birthday,  int visitCount,  int reservationCount,  int noShowCount,  double totalSpent,  DateTime? lastVisitAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Customer() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.email,_that.notes,_that.tags,_that.isVip,_that.birthday,_that.visitCount,_that.reservationCount,_that.noShowCount,_that.totalSpent,_that.lastVisitAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Customer extends Customer {
  const _Customer({required this.id, required this.name, required this.phone, this.email = '', this.notes = '', final  List<String> tags = const <String>[], this.isVip = false, this.birthday, this.visitCount = 0, this.reservationCount = 0, this.noShowCount = 0, this.totalSpent = 0.0, this.lastVisitAt, this.createdAt, this.updatedAt}): _tags = tags,super._();
  

@override final  String id;
@override final  String name;
@override final  String phone;
@override@JsonKey() final  String email;
@override@JsonKey() final  String notes;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  bool isVip;
@override final  DateTime? birthday;
@override@JsonKey() final  int visitCount;
@override@JsonKey() final  int reservationCount;
@override@JsonKey() final  int noShowCount;
@override@JsonKey() final  double totalSpent;
@override final  DateTime? lastVisitAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerCopyWith<_Customer> get copyWith => __$CustomerCopyWithImpl<_Customer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Customer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.isVip, isVip) || other.isVip == isVip)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.visitCount, visitCount) || other.visitCount == visitCount)&&(identical(other.reservationCount, reservationCount) || other.reservationCount == reservationCount)&&(identical(other.noShowCount, noShowCount) || other.noShowCount == noShowCount)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.lastVisitAt, lastVisitAt) || other.lastVisitAt == lastVisitAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,email,notes,const DeepCollectionEquality().hash(_tags),isVip,birthday,visitCount,reservationCount,noShowCount,totalSpent,lastVisitAt,createdAt,updatedAt);

@override
String toString() {
  return 'Customer(id: $id, name: $name, phone: $phone, email: $email, notes: $notes, tags: $tags, isVip: $isVip, birthday: $birthday, visitCount: $visitCount, reservationCount: $reservationCount, noShowCount: $noShowCount, totalSpent: $totalSpent, lastVisitAt: $lastVisitAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CustomerCopyWith<$Res> implements $CustomerCopyWith<$Res> {
  factory _$CustomerCopyWith(_Customer value, $Res Function(_Customer) _then) = __$CustomerCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String phone, String email, String notes, List<String> tags, bool isVip, DateTime? birthday, int visitCount, int reservationCount, int noShowCount, double totalSpent, DateTime? lastVisitAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$CustomerCopyWithImpl<$Res>
    implements _$CustomerCopyWith<$Res> {
  __$CustomerCopyWithImpl(this._self, this._then);

  final _Customer _self;
  final $Res Function(_Customer) _then;

/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? email = null,Object? notes = null,Object? tags = null,Object? isVip = null,Object? birthday = freezed,Object? visitCount = null,Object? reservationCount = null,Object? noShowCount = null,Object? totalSpent = null,Object? lastVisitAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Customer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isVip: null == isVip ? _self.isVip : isVip // ignore: cast_nullable_to_non_nullable
as bool,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime?,visitCount: null == visitCount ? _self.visitCount : visitCount // ignore: cast_nullable_to_non_nullable
as int,reservationCount: null == reservationCount ? _self.reservationCount : reservationCount // ignore: cast_nullable_to_non_nullable
as int,noShowCount: null == noShowCount ? _self.noShowCount : noShowCount // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,lastVisitAt: freezed == lastVisitAt ? _self.lastVisitAt : lastVisitAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
