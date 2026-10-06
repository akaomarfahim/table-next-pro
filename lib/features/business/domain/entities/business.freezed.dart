// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Business {

 String get id; String get name; String get phone; String get email; String get address; String get currencyCode; String get currencySymbol;/// VAT / tax percentage applied to bills (e.g. 5 = 5%).
 double get taxRate;/// Service charge percentage applied to bills.
 double get serviceChargeRate;/// Default reservation length in minutes.
 int get defaultReservationMinutes;/// Opening / closing hour (0-24) used to build time slots.
 int get openingHour; int get closingHour; String get billFooter; bool get active; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Business
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessCopyWith<Business> get copyWith => _$BusinessCopyWithImpl<Business>(this as Business, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Business&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.serviceChargeRate, serviceChargeRate) || other.serviceChargeRate == serviceChargeRate)&&(identical(other.defaultReservationMinutes, defaultReservationMinutes) || other.defaultReservationMinutes == defaultReservationMinutes)&&(identical(other.openingHour, openingHour) || other.openingHour == openingHour)&&(identical(other.closingHour, closingHour) || other.closingHour == closingHour)&&(identical(other.billFooter, billFooter) || other.billFooter == billFooter)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,email,address,currencyCode,currencySymbol,taxRate,serviceChargeRate,defaultReservationMinutes,openingHour,closingHour,billFooter,active,createdAt,updatedAt);

@override
String toString() {
  return 'Business(id: $id, name: $name, phone: $phone, email: $email, address: $address, currencyCode: $currencyCode, currencySymbol: $currencySymbol, taxRate: $taxRate, serviceChargeRate: $serviceChargeRate, defaultReservationMinutes: $defaultReservationMinutes, openingHour: $openingHour, closingHour: $closingHour, billFooter: $billFooter, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BusinessCopyWith<$Res>  {
  factory $BusinessCopyWith(Business value, $Res Function(Business) _then) = _$BusinessCopyWithImpl;
@useResult
$Res call({
 String id, String name, String phone, String email, String address, String currencyCode, String currencySymbol, double taxRate, double serviceChargeRate, int defaultReservationMinutes, int openingHour, int closingHour, String billFooter, bool active, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$BusinessCopyWithImpl<$Res>
    implements $BusinessCopyWith<$Res> {
  _$BusinessCopyWithImpl(this._self, this._then);

  final Business _self;
  final $Res Function(Business) _then;

/// Create a copy of Business
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? email = null,Object? address = null,Object? currencyCode = null,Object? currencySymbol = null,Object? taxRate = null,Object? serviceChargeRate = null,Object? defaultReservationMinutes = null,Object? openingHour = null,Object? closingHour = null,Object? billFooter = null,Object? active = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,serviceChargeRate: null == serviceChargeRate ? _self.serviceChargeRate : serviceChargeRate // ignore: cast_nullable_to_non_nullable
as double,defaultReservationMinutes: null == defaultReservationMinutes ? _self.defaultReservationMinutes : defaultReservationMinutes // ignore: cast_nullable_to_non_nullable
as int,openingHour: null == openingHour ? _self.openingHour : openingHour // ignore: cast_nullable_to_non_nullable
as int,closingHour: null == closingHour ? _self.closingHour : closingHour // ignore: cast_nullable_to_non_nullable
as int,billFooter: null == billFooter ? _self.billFooter : billFooter // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Business].
extension BusinessPatterns on Business {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Business value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Business() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Business value)  $default,){
final _that = this;
switch (_that) {
case _Business():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Business value)?  $default,){
final _that = this;
switch (_that) {
case _Business() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  String email,  String address,  String currencyCode,  String currencySymbol,  double taxRate,  double serviceChargeRate,  int defaultReservationMinutes,  int openingHour,  int closingHour,  String billFooter,  bool active,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Business() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.email,_that.address,_that.currencyCode,_that.currencySymbol,_that.taxRate,_that.serviceChargeRate,_that.defaultReservationMinutes,_that.openingHour,_that.closingHour,_that.billFooter,_that.active,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  String email,  String address,  String currencyCode,  String currencySymbol,  double taxRate,  double serviceChargeRate,  int defaultReservationMinutes,  int openingHour,  int closingHour,  String billFooter,  bool active,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Business():
return $default(_that.id,_that.name,_that.phone,_that.email,_that.address,_that.currencyCode,_that.currencySymbol,_that.taxRate,_that.serviceChargeRate,_that.defaultReservationMinutes,_that.openingHour,_that.closingHour,_that.billFooter,_that.active,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String phone,  String email,  String address,  String currencyCode,  String currencySymbol,  double taxRate,  double serviceChargeRate,  int defaultReservationMinutes,  int openingHour,  int closingHour,  String billFooter,  bool active,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Business() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.email,_that.address,_that.currencyCode,_that.currencySymbol,_that.taxRate,_that.serviceChargeRate,_that.defaultReservationMinutes,_that.openingHour,_that.closingHour,_that.billFooter,_that.active,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Business extends Business {
  const _Business({required this.id, required this.name, this.phone = '', this.email = '', this.address = '', this.currencyCode = 'BDT', this.currencySymbol = '৳', this.taxRate = 0.0, this.serviceChargeRate = 0.0, this.defaultReservationMinutes = 90, this.openingHour = 10, this.closingHour = 23, this.billFooter = 'Thank you for dining with us!', this.active = true, this.createdAt, this.updatedAt}): super._();
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String email;
@override@JsonKey() final  String address;
@override@JsonKey() final  String currencyCode;
@override@JsonKey() final  String currencySymbol;
/// VAT / tax percentage applied to bills (e.g. 5 = 5%).
@override@JsonKey() final  double taxRate;
/// Service charge percentage applied to bills.
@override@JsonKey() final  double serviceChargeRate;
/// Default reservation length in minutes.
@override@JsonKey() final  int defaultReservationMinutes;
/// Opening / closing hour (0-24) used to build time slots.
@override@JsonKey() final  int openingHour;
@override@JsonKey() final  int closingHour;
@override@JsonKey() final  String billFooter;
@override@JsonKey() final  bool active;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Business
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessCopyWith<_Business> get copyWith => __$BusinessCopyWithImpl<_Business>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Business&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.serviceChargeRate, serviceChargeRate) || other.serviceChargeRate == serviceChargeRate)&&(identical(other.defaultReservationMinutes, defaultReservationMinutes) || other.defaultReservationMinutes == defaultReservationMinutes)&&(identical(other.openingHour, openingHour) || other.openingHour == openingHour)&&(identical(other.closingHour, closingHour) || other.closingHour == closingHour)&&(identical(other.billFooter, billFooter) || other.billFooter == billFooter)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,email,address,currencyCode,currencySymbol,taxRate,serviceChargeRate,defaultReservationMinutes,openingHour,closingHour,billFooter,active,createdAt,updatedAt);

@override
String toString() {
  return 'Business(id: $id, name: $name, phone: $phone, email: $email, address: $address, currencyCode: $currencyCode, currencySymbol: $currencySymbol, taxRate: $taxRate, serviceChargeRate: $serviceChargeRate, defaultReservationMinutes: $defaultReservationMinutes, openingHour: $openingHour, closingHour: $closingHour, billFooter: $billFooter, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BusinessCopyWith<$Res> implements $BusinessCopyWith<$Res> {
  factory _$BusinessCopyWith(_Business value, $Res Function(_Business) _then) = __$BusinessCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String phone, String email, String address, String currencyCode, String currencySymbol, double taxRate, double serviceChargeRate, int defaultReservationMinutes, int openingHour, int closingHour, String billFooter, bool active, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$BusinessCopyWithImpl<$Res>
    implements _$BusinessCopyWith<$Res> {
  __$BusinessCopyWithImpl(this._self, this._then);

  final _Business _self;
  final $Res Function(_Business) _then;

/// Create a copy of Business
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? email = null,Object? address = null,Object? currencyCode = null,Object? currencySymbol = null,Object? taxRate = null,Object? serviceChargeRate = null,Object? defaultReservationMinutes = null,Object? openingHour = null,Object? closingHour = null,Object? billFooter = null,Object? active = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Business(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,serviceChargeRate: null == serviceChargeRate ? _self.serviceChargeRate : serviceChargeRate // ignore: cast_nullable_to_non_nullable
as double,defaultReservationMinutes: null == defaultReservationMinutes ? _self.defaultReservationMinutes : defaultReservationMinutes // ignore: cast_nullable_to_non_nullable
as int,openingHour: null == openingHour ? _self.openingHour : openingHour // ignore: cast_nullable_to_non_nullable
as int,closingHour: null == closingHour ? _self.closingHour : closingHour // ignore: cast_nullable_to_non_nullable
as int,billFooter: null == billFooter ? _self.billFooter : billFooter // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
