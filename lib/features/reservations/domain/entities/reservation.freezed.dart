// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Reservation {

 String get id; String get customerId; String get customerName; String get customerPhone; int get partySize; DateTime get startAt; int get durationMinutes; List<String> get tableIds; List<String> get tableLabels; ReservationStatus get status; ReservationSource get source; ReservationOccasion get occasion; String get notes; String get createdById; String get createdByName; String? get billId; DateTime? get seatedAt; DateTime? get completedAt; DateTime? get cancelledAt; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationCopyWith<Reservation> get copyWith => _$ReservationCopyWithImpl<Reservation>(this as Reservation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reservation&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.partySize, partySize) || other.partySize == partySize)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&const DeepCollectionEquality().equals(other.tableIds, tableIds)&&const DeepCollectionEquality().equals(other.tableLabels, tableLabels)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdById, createdById) || other.createdById == createdById)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName)&&(identical(other.billId, billId) || other.billId == billId)&&(identical(other.seatedAt, seatedAt) || other.seatedAt == seatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,customerId,customerName,customerPhone,partySize,startAt,durationMinutes,const DeepCollectionEquality().hash(tableIds),const DeepCollectionEquality().hash(tableLabels),status,source,occasion,notes,createdById,createdByName,billId,seatedAt,completedAt,cancelledAt,createdAt,updatedAt]);

@override
String toString() {
  return 'Reservation(id: $id, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, partySize: $partySize, startAt: $startAt, durationMinutes: $durationMinutes, tableIds: $tableIds, tableLabels: $tableLabels, status: $status, source: $source, occasion: $occasion, notes: $notes, createdById: $createdById, createdByName: $createdByName, billId: $billId, seatedAt: $seatedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ReservationCopyWith<$Res>  {
  factory $ReservationCopyWith(Reservation value, $Res Function(Reservation) _then) = _$ReservationCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String customerName, String customerPhone, int partySize, DateTime startAt, int durationMinutes, List<String> tableIds, List<String> tableLabels, ReservationStatus status, ReservationSource source, ReservationOccasion occasion, String notes, String createdById, String createdByName, String? billId, DateTime? seatedAt, DateTime? completedAt, DateTime? cancelledAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ReservationCopyWithImpl<$Res>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._self, this._then);

  final Reservation _self;
  final $Res Function(Reservation) _then;

/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? customerPhone = null,Object? partySize = null,Object? startAt = null,Object? durationMinutes = null,Object? tableIds = null,Object? tableLabels = null,Object? status = null,Object? source = null,Object? occasion = null,Object? notes = null,Object? createdById = null,Object? createdByName = null,Object? billId = freezed,Object? seatedAt = freezed,Object? completedAt = freezed,Object? cancelledAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,tableIds: null == tableIds ? _self.tableIds : tableIds // ignore: cast_nullable_to_non_nullable
as List<String>,tableLabels: null == tableLabels ? _self.tableLabels : tableLabels // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ReservationSource,occasion: null == occasion ? _self.occasion : occasion // ignore: cast_nullable_to_non_nullable
as ReservationOccasion,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,createdById: null == createdById ? _self.createdById : createdById // ignore: cast_nullable_to_non_nullable
as String,createdByName: null == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String,billId: freezed == billId ? _self.billId : billId // ignore: cast_nullable_to_non_nullable
as String?,seatedAt: freezed == seatedAt ? _self.seatedAt : seatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Reservation].
extension ReservationPatterns on Reservation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reservation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reservation value)  $default,){
final _that = this;
switch (_that) {
case _Reservation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reservation value)?  $default,){
final _that = this;
switch (_that) {
case _Reservation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String customerPhone,  int partySize,  DateTime startAt,  int durationMinutes,  List<String> tableIds,  List<String> tableLabels,  ReservationStatus status,  ReservationSource source,  ReservationOccasion occasion,  String notes,  String createdById,  String createdByName,  String? billId,  DateTime? seatedAt,  DateTime? completedAt,  DateTime? cancelledAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reservation() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.customerPhone,_that.partySize,_that.startAt,_that.durationMinutes,_that.tableIds,_that.tableLabels,_that.status,_that.source,_that.occasion,_that.notes,_that.createdById,_that.createdByName,_that.billId,_that.seatedAt,_that.completedAt,_that.cancelledAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String customerPhone,  int partySize,  DateTime startAt,  int durationMinutes,  List<String> tableIds,  List<String> tableLabels,  ReservationStatus status,  ReservationSource source,  ReservationOccasion occasion,  String notes,  String createdById,  String createdByName,  String? billId,  DateTime? seatedAt,  DateTime? completedAt,  DateTime? cancelledAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Reservation():
return $default(_that.id,_that.customerId,_that.customerName,_that.customerPhone,_that.partySize,_that.startAt,_that.durationMinutes,_that.tableIds,_that.tableLabels,_that.status,_that.source,_that.occasion,_that.notes,_that.createdById,_that.createdByName,_that.billId,_that.seatedAt,_that.completedAt,_that.cancelledAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String customerName,  String customerPhone,  int partySize,  DateTime startAt,  int durationMinutes,  List<String> tableIds,  List<String> tableLabels,  ReservationStatus status,  ReservationSource source,  ReservationOccasion occasion,  String notes,  String createdById,  String createdByName,  String? billId,  DateTime? seatedAt,  DateTime? completedAt,  DateTime? cancelledAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Reservation() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.customerPhone,_that.partySize,_that.startAt,_that.durationMinutes,_that.tableIds,_that.tableLabels,_that.status,_that.source,_that.occasion,_that.notes,_that.createdById,_that.createdByName,_that.billId,_that.seatedAt,_that.completedAt,_that.cancelledAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Reservation extends Reservation {
  const _Reservation({required this.id, required this.customerId, required this.customerName, required this.customerPhone, required this.partySize, required this.startAt, required this.durationMinutes, final  List<String> tableIds = const <String>[], final  List<String> tableLabels = const <String>[], this.status = ReservationStatus.confirmed, this.source = ReservationSource.phone, this.occasion = ReservationOccasion.none, this.notes = '', this.createdById = '', this.createdByName = '', this.billId, this.seatedAt, this.completedAt, this.cancelledAt, this.createdAt, this.updatedAt}): _tableIds = tableIds,_tableLabels = tableLabels,super._();
  

@override final  String id;
@override final  String customerId;
@override final  String customerName;
@override final  String customerPhone;
@override final  int partySize;
@override final  DateTime startAt;
@override final  int durationMinutes;
 final  List<String> _tableIds;
@override@JsonKey() List<String> get tableIds {
  if (_tableIds is EqualUnmodifiableListView) return _tableIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tableIds);
}

 final  List<String> _tableLabels;
@override@JsonKey() List<String> get tableLabels {
  if (_tableLabels is EqualUnmodifiableListView) return _tableLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tableLabels);
}

@override@JsonKey() final  ReservationStatus status;
@override@JsonKey() final  ReservationSource source;
@override@JsonKey() final  ReservationOccasion occasion;
@override@JsonKey() final  String notes;
@override@JsonKey() final  String createdById;
@override@JsonKey() final  String createdByName;
@override final  String? billId;
@override final  DateTime? seatedAt;
@override final  DateTime? completedAt;
@override final  DateTime? cancelledAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationCopyWith<_Reservation> get copyWith => __$ReservationCopyWithImpl<_Reservation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reservation&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.partySize, partySize) || other.partySize == partySize)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&const DeepCollectionEquality().equals(other._tableIds, _tableIds)&&const DeepCollectionEquality().equals(other._tableLabels, _tableLabels)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdById, createdById) || other.createdById == createdById)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName)&&(identical(other.billId, billId) || other.billId == billId)&&(identical(other.seatedAt, seatedAt) || other.seatedAt == seatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,customerId,customerName,customerPhone,partySize,startAt,durationMinutes,const DeepCollectionEquality().hash(_tableIds),const DeepCollectionEquality().hash(_tableLabels),status,source,occasion,notes,createdById,createdByName,billId,seatedAt,completedAt,cancelledAt,createdAt,updatedAt]);

@override
String toString() {
  return 'Reservation(id: $id, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, partySize: $partySize, startAt: $startAt, durationMinutes: $durationMinutes, tableIds: $tableIds, tableLabels: $tableLabels, status: $status, source: $source, occasion: $occasion, notes: $notes, createdById: $createdById, createdByName: $createdByName, billId: $billId, seatedAt: $seatedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ReservationCopyWith<$Res> implements $ReservationCopyWith<$Res> {
  factory _$ReservationCopyWith(_Reservation value, $Res Function(_Reservation) _then) = __$ReservationCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String customerName, String customerPhone, int partySize, DateTime startAt, int durationMinutes, List<String> tableIds, List<String> tableLabels, ReservationStatus status, ReservationSource source, ReservationOccasion occasion, String notes, String createdById, String createdByName, String? billId, DateTime? seatedAt, DateTime? completedAt, DateTime? cancelledAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ReservationCopyWithImpl<$Res>
    implements _$ReservationCopyWith<$Res> {
  __$ReservationCopyWithImpl(this._self, this._then);

  final _Reservation _self;
  final $Res Function(_Reservation) _then;

/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? customerPhone = null,Object? partySize = null,Object? startAt = null,Object? durationMinutes = null,Object? tableIds = null,Object? tableLabels = null,Object? status = null,Object? source = null,Object? occasion = null,Object? notes = null,Object? createdById = null,Object? createdByName = null,Object? billId = freezed,Object? seatedAt = freezed,Object? completedAt = freezed,Object? cancelledAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Reservation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,tableIds: null == tableIds ? _self._tableIds : tableIds // ignore: cast_nullable_to_non_nullable
as List<String>,tableLabels: null == tableLabels ? _self._tableLabels : tableLabels // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ReservationSource,occasion: null == occasion ? _self.occasion : occasion // ignore: cast_nullable_to_non_nullable
as ReservationOccasion,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,createdById: null == createdById ? _self.createdById : createdById // ignore: cast_nullable_to_non_nullable
as String,createdByName: null == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String,billId: freezed == billId ? _self.billId : billId // ignore: cast_nullable_to_non_nullable
as String?,seatedAt: freezed == seatedAt ? _self.seatedAt : seatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
