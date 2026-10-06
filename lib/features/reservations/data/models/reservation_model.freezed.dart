// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReservationModel {

@JsonKey(includeToJson: false) String get id; String get customerId; String get customerName; String get customerPhone; int get partySize;@TimestampConverter() DateTime get startAt;/// Denormalised for range queries / readability in the console.
@TimestampConverter() DateTime get endAt; int get durationMinutes; List<String> get tableIds; List<String> get tableLabels;@JsonKey(unknownEnumValue: ReservationStatus.pending) ReservationStatus get status;@JsonKey(unknownEnumValue: ReservationSource.other) ReservationSource get source;@JsonKey(unknownEnumValue: ReservationOccasion.none) ReservationOccasion get occasion; String get notes; String get createdById; String get createdByName; String? get billId;@NullableTimestampConverter() DateTime? get seatedAt;@NullableTimestampConverter() DateTime? get completedAt;@NullableTimestampConverter() DateTime? get cancelledAt;@NullableTimestampConverter() DateTime? get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;
/// Create a copy of ReservationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationModelCopyWith<ReservationModel> get copyWith => _$ReservationModelCopyWithImpl<ReservationModel>(this as ReservationModel, _$identity);

  /// Serializes this ReservationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.partySize, partySize) || other.partySize == partySize)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&const DeepCollectionEquality().equals(other.tableIds, tableIds)&&const DeepCollectionEquality().equals(other.tableLabels, tableLabels)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdById, createdById) || other.createdById == createdById)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName)&&(identical(other.billId, billId) || other.billId == billId)&&(identical(other.seatedAt, seatedAt) || other.seatedAt == seatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,customerId,customerName,customerPhone,partySize,startAt,endAt,durationMinutes,const DeepCollectionEquality().hash(tableIds),const DeepCollectionEquality().hash(tableLabels),status,source,occasion,notes,createdById,createdByName,billId,seatedAt,completedAt,cancelledAt,createdAt,updatedAt]);

@override
String toString() {
  return 'ReservationModel(id: $id, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, partySize: $partySize, startAt: $startAt, endAt: $endAt, durationMinutes: $durationMinutes, tableIds: $tableIds, tableLabels: $tableLabels, status: $status, source: $source, occasion: $occasion, notes: $notes, createdById: $createdById, createdByName: $createdByName, billId: $billId, seatedAt: $seatedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ReservationModelCopyWith<$Res>  {
  factory $ReservationModelCopyWith(ReservationModel value, $Res Function(ReservationModel) _then) = _$ReservationModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String id, String customerId, String customerName, String customerPhone, int partySize,@TimestampConverter() DateTime startAt,@TimestampConverter() DateTime endAt, int durationMinutes, List<String> tableIds, List<String> tableLabels,@JsonKey(unknownEnumValue: ReservationStatus.pending) ReservationStatus status,@JsonKey(unknownEnumValue: ReservationSource.other) ReservationSource source,@JsonKey(unknownEnumValue: ReservationOccasion.none) ReservationOccasion occasion, String notes, String createdById, String createdByName, String? billId,@NullableTimestampConverter() DateTime? seatedAt,@NullableTimestampConverter() DateTime? completedAt,@NullableTimestampConverter() DateTime? cancelledAt,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$ReservationModelCopyWithImpl<$Res>
    implements $ReservationModelCopyWith<$Res> {
  _$ReservationModelCopyWithImpl(this._self, this._then);

  final ReservationModel _self;
  final $Res Function(ReservationModel) _then;

/// Create a copy of ReservationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? customerPhone = null,Object? partySize = null,Object? startAt = null,Object? endAt = null,Object? durationMinutes = null,Object? tableIds = null,Object? tableLabels = null,Object? status = null,Object? source = null,Object? occasion = null,Object? notes = null,Object? createdById = null,Object? createdByName = null,Object? billId = freezed,Object? seatedAt = freezed,Object? completedAt = freezed,Object? cancelledAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [ReservationModel].
extension ReservationModelPatterns on ReservationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReservationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReservationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReservationModel value)  $default,){
final _that = this;
switch (_that) {
case _ReservationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReservationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReservationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String customerId,  String customerName,  String customerPhone,  int partySize, @TimestampConverter()  DateTime startAt, @TimestampConverter()  DateTime endAt,  int durationMinutes,  List<String> tableIds,  List<String> tableLabels, @JsonKey(unknownEnumValue: ReservationStatus.pending)  ReservationStatus status, @JsonKey(unknownEnumValue: ReservationSource.other)  ReservationSource source, @JsonKey(unknownEnumValue: ReservationOccasion.none)  ReservationOccasion occasion,  String notes,  String createdById,  String createdByName,  String? billId, @NullableTimestampConverter()  DateTime? seatedAt, @NullableTimestampConverter()  DateTime? completedAt, @NullableTimestampConverter()  DateTime? cancelledAt, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReservationModel() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.customerPhone,_that.partySize,_that.startAt,_that.endAt,_that.durationMinutes,_that.tableIds,_that.tableLabels,_that.status,_that.source,_that.occasion,_that.notes,_that.createdById,_that.createdByName,_that.billId,_that.seatedAt,_that.completedAt,_that.cancelledAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String customerId,  String customerName,  String customerPhone,  int partySize, @TimestampConverter()  DateTime startAt, @TimestampConverter()  DateTime endAt,  int durationMinutes,  List<String> tableIds,  List<String> tableLabels, @JsonKey(unknownEnumValue: ReservationStatus.pending)  ReservationStatus status, @JsonKey(unknownEnumValue: ReservationSource.other)  ReservationSource source, @JsonKey(unknownEnumValue: ReservationOccasion.none)  ReservationOccasion occasion,  String notes,  String createdById,  String createdByName,  String? billId, @NullableTimestampConverter()  DateTime? seatedAt, @NullableTimestampConverter()  DateTime? completedAt, @NullableTimestampConverter()  DateTime? cancelledAt, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ReservationModel():
return $default(_that.id,_that.customerId,_that.customerName,_that.customerPhone,_that.partySize,_that.startAt,_that.endAt,_that.durationMinutes,_that.tableIds,_that.tableLabels,_that.status,_that.source,_that.occasion,_that.notes,_that.createdById,_that.createdByName,_that.billId,_that.seatedAt,_that.completedAt,_that.cancelledAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String id,  String customerId,  String customerName,  String customerPhone,  int partySize, @TimestampConverter()  DateTime startAt, @TimestampConverter()  DateTime endAt,  int durationMinutes,  List<String> tableIds,  List<String> tableLabels, @JsonKey(unknownEnumValue: ReservationStatus.pending)  ReservationStatus status, @JsonKey(unknownEnumValue: ReservationSource.other)  ReservationSource source, @JsonKey(unknownEnumValue: ReservationOccasion.none)  ReservationOccasion occasion,  String notes,  String createdById,  String createdByName,  String? billId, @NullableTimestampConverter()  DateTime? seatedAt, @NullableTimestampConverter()  DateTime? completedAt, @NullableTimestampConverter()  DateTime? cancelledAt, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReservationModel() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.customerPhone,_that.partySize,_that.startAt,_that.endAt,_that.durationMinutes,_that.tableIds,_that.tableLabels,_that.status,_that.source,_that.occasion,_that.notes,_that.createdById,_that.createdByName,_that.billId,_that.seatedAt,_that.completedAt,_that.cancelledAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReservationModel extends ReservationModel {
  const _ReservationModel({@JsonKey(includeToJson: false) this.id = '', required this.customerId, required this.customerName, required this.customerPhone, required this.partySize, @TimestampConverter() required this.startAt, @TimestampConverter() required this.endAt, required this.durationMinutes, this.tableIds = const <String>[], this.tableLabels = const <String>[], @JsonKey(unknownEnumValue: ReservationStatus.pending) this.status = ReservationStatus.confirmed, @JsonKey(unknownEnumValue: ReservationSource.other) this.source = ReservationSource.phone, @JsonKey(unknownEnumValue: ReservationOccasion.none) this.occasion = ReservationOccasion.none, this.notes = '', this.createdById = '', this.createdByName = '', this.billId, @NullableTimestampConverter() this.seatedAt, @NullableTimestampConverter() this.completedAt, @NullableTimestampConverter() this.cancelledAt, @NullableTimestampConverter() this.createdAt, @NullableTimestampConverter() this.updatedAt}): super._();
  factory _ReservationModel.fromJson(Map<String, dynamic> json) => _$ReservationModelFromJson(json);

@override@JsonKey(includeToJson: false) final  String id;
@override final  String customerId;
@override final  String customerName;
@override final  String customerPhone;
@override final  int partySize;
@override@TimestampConverter() final  DateTime startAt;
/// Denormalised for range queries / readability in the console.
@override@TimestampConverter() final  DateTime endAt;
@override final  int durationMinutes;
@override@JsonKey() final  List<String> tableIds;
@override@JsonKey() final  List<String> tableLabels;
@override@JsonKey(unknownEnumValue: ReservationStatus.pending) final  ReservationStatus status;
@override@JsonKey(unknownEnumValue: ReservationSource.other) final  ReservationSource source;
@override@JsonKey(unknownEnumValue: ReservationOccasion.none) final  ReservationOccasion occasion;
@override@JsonKey() final  String notes;
@override@JsonKey() final  String createdById;
@override@JsonKey() final  String createdByName;
@override final  String? billId;
@override@NullableTimestampConverter() final  DateTime? seatedAt;
@override@NullableTimestampConverter() final  DateTime? completedAt;
@override@NullableTimestampConverter() final  DateTime? cancelledAt;
@override@NullableTimestampConverter() final  DateTime? createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of ReservationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationModelCopyWith<_ReservationModel> get copyWith => __$ReservationModelCopyWithImpl<_ReservationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReservationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReservationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.partySize, partySize) || other.partySize == partySize)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&const DeepCollectionEquality().equals(other.tableIds, tableIds)&&const DeepCollectionEquality().equals(other.tableLabels, tableLabels)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdById, createdById) || other.createdById == createdById)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName)&&(identical(other.billId, billId) || other.billId == billId)&&(identical(other.seatedAt, seatedAt) || other.seatedAt == seatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,customerId,customerName,customerPhone,partySize,startAt,endAt,durationMinutes,const DeepCollectionEquality().hash(tableIds),const DeepCollectionEquality().hash(tableLabels),status,source,occasion,notes,createdById,createdByName,billId,seatedAt,completedAt,cancelledAt,createdAt,updatedAt]);

@override
String toString() {
  return 'ReservationModel(id: $id, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, partySize: $partySize, startAt: $startAt, endAt: $endAt, durationMinutes: $durationMinutes, tableIds: $tableIds, tableLabels: $tableLabels, status: $status, source: $source, occasion: $occasion, notes: $notes, createdById: $createdById, createdByName: $createdByName, billId: $billId, seatedAt: $seatedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ReservationModelCopyWith<$Res> implements $ReservationModelCopyWith<$Res> {
  factory _$ReservationModelCopyWith(_ReservationModel value, $Res Function(_ReservationModel) _then) = __$ReservationModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String id, String customerId, String customerName, String customerPhone, int partySize,@TimestampConverter() DateTime startAt,@TimestampConverter() DateTime endAt, int durationMinutes, List<String> tableIds, List<String> tableLabels,@JsonKey(unknownEnumValue: ReservationStatus.pending) ReservationStatus status,@JsonKey(unknownEnumValue: ReservationSource.other) ReservationSource source,@JsonKey(unknownEnumValue: ReservationOccasion.none) ReservationOccasion occasion, String notes, String createdById, String createdByName, String? billId,@NullableTimestampConverter() DateTime? seatedAt,@NullableTimestampConverter() DateTime? completedAt,@NullableTimestampConverter() DateTime? cancelledAt,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$ReservationModelCopyWithImpl<$Res>
    implements _$ReservationModelCopyWith<$Res> {
  __$ReservationModelCopyWithImpl(this._self, this._then);

  final _ReservationModel _self;
  final $Res Function(_ReservationModel) _then;

/// Create a copy of ReservationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? customerPhone = null,Object? partySize = null,Object? startAt = null,Object? endAt = null,Object? durationMinutes = null,Object? tableIds = null,Object? tableLabels = null,Object? status = null,Object? source = null,Object? occasion = null,Object? notes = null,Object? createdById = null,Object? createdByName = null,Object? billId = freezed,Object? seatedAt = freezed,Object? completedAt = freezed,Object? cancelledAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ReservationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
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

// dart format on
