// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BillItemModel {

 String get lineId; String get menuItemId; String get name; double get unitPrice; int get quantity; String get note; bool get sent;
/// Create a copy of BillItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillItemModelCopyWith<BillItemModel> get copyWith => _$BillItemModelCopyWithImpl<BillItemModel>(this as BillItemModel, _$identity);

  /// Serializes this BillItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillItemModel&&(identical(other.lineId, lineId) || other.lineId == lineId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.name, name) || other.name == name)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.note, note) || other.note == note)&&(identical(other.sent, sent) || other.sent == sent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineId,menuItemId,name,unitPrice,quantity,note,sent);

@override
String toString() {
  return 'BillItemModel(lineId: $lineId, menuItemId: $menuItemId, name: $name, unitPrice: $unitPrice, quantity: $quantity, note: $note, sent: $sent)';
}


}

/// @nodoc
abstract mixin class $BillItemModelCopyWith<$Res>  {
  factory $BillItemModelCopyWith(BillItemModel value, $Res Function(BillItemModel) _then) = _$BillItemModelCopyWithImpl;
@useResult
$Res call({
 String lineId, String menuItemId, String name, double unitPrice, int quantity, String note, bool sent
});




}
/// @nodoc
class _$BillItemModelCopyWithImpl<$Res>
    implements $BillItemModelCopyWith<$Res> {
  _$BillItemModelCopyWithImpl(this._self, this._then);

  final BillItemModel _self;
  final $Res Function(BillItemModel) _then;

/// Create a copy of BillItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lineId = null,Object? menuItemId = null,Object? name = null,Object? unitPrice = null,Object? quantity = null,Object? note = null,Object? sent = null,}) {
  return _then(_self.copyWith(
lineId: null == lineId ? _self.lineId : lineId // ignore: cast_nullable_to_non_nullable
as String,menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,sent: null == sent ? _self.sent : sent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BillItemModel].
extension BillItemModelPatterns on BillItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillItemModel value)  $default,){
final _that = this;
switch (_that) {
case _BillItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _BillItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lineId,  String menuItemId,  String name,  double unitPrice,  int quantity,  String note,  bool sent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillItemModel() when $default != null:
return $default(_that.lineId,_that.menuItemId,_that.name,_that.unitPrice,_that.quantity,_that.note,_that.sent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lineId,  String menuItemId,  String name,  double unitPrice,  int quantity,  String note,  bool sent)  $default,) {final _that = this;
switch (_that) {
case _BillItemModel():
return $default(_that.lineId,_that.menuItemId,_that.name,_that.unitPrice,_that.quantity,_that.note,_that.sent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lineId,  String menuItemId,  String name,  double unitPrice,  int quantity,  String note,  bool sent)?  $default,) {final _that = this;
switch (_that) {
case _BillItemModel() when $default != null:
return $default(_that.lineId,_that.menuItemId,_that.name,_that.unitPrice,_that.quantity,_that.note,_that.sent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BillItemModel extends BillItemModel {
  const _BillItemModel({required this.lineId, required this.menuItemId, required this.name, required this.unitPrice, this.quantity = 1, this.note = '', this.sent = false}): super._();
  factory _BillItemModel.fromJson(Map<String, dynamic> json) => _$BillItemModelFromJson(json);

@override final  String lineId;
@override final  String menuItemId;
@override final  String name;
@override final  double unitPrice;
@override@JsonKey() final  int quantity;
@override@JsonKey() final  String note;
@override@JsonKey() final  bool sent;

/// Create a copy of BillItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillItemModelCopyWith<_BillItemModel> get copyWith => __$BillItemModelCopyWithImpl<_BillItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillItemModel&&(identical(other.lineId, lineId) || other.lineId == lineId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.name, name) || other.name == name)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.note, note) || other.note == note)&&(identical(other.sent, sent) || other.sent == sent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineId,menuItemId,name,unitPrice,quantity,note,sent);

@override
String toString() {
  return 'BillItemModel(lineId: $lineId, menuItemId: $menuItemId, name: $name, unitPrice: $unitPrice, quantity: $quantity, note: $note, sent: $sent)';
}


}

/// @nodoc
abstract mixin class _$BillItemModelCopyWith<$Res> implements $BillItemModelCopyWith<$Res> {
  factory _$BillItemModelCopyWith(_BillItemModel value, $Res Function(_BillItemModel) _then) = __$BillItemModelCopyWithImpl;
@override @useResult
$Res call({
 String lineId, String menuItemId, String name, double unitPrice, int quantity, String note, bool sent
});




}
/// @nodoc
class __$BillItemModelCopyWithImpl<$Res>
    implements _$BillItemModelCopyWith<$Res> {
  __$BillItemModelCopyWithImpl(this._self, this._then);

  final _BillItemModel _self;
  final $Res Function(_BillItemModel) _then;

/// Create a copy of BillItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lineId = null,Object? menuItemId = null,Object? name = null,Object? unitPrice = null,Object? quantity = null,Object? note = null,Object? sent = null,}) {
  return _then(_BillItemModel(
lineId: null == lineId ? _self.lineId : lineId // ignore: cast_nullable_to_non_nullable
as String,menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,sent: null == sent ? _self.sent : sent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PaymentModel {

@JsonKey(unknownEnumValue: PaymentMethod.other) PaymentMethod get method; double get amount; String get reference;@TimestampConverter() DateTime get receivedAt;
/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentModelCopyWith<PaymentModel> get copyWith => _$PaymentModelCopyWithImpl<PaymentModel>(this as PaymentModel, _$identity);

  /// Serializes this PaymentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentModel&&(identical(other.method, method) || other.method == method)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,amount,reference,receivedAt);

@override
String toString() {
  return 'PaymentModel(method: $method, amount: $amount, reference: $reference, receivedAt: $receivedAt)';
}


}

/// @nodoc
abstract mixin class $PaymentModelCopyWith<$Res>  {
  factory $PaymentModelCopyWith(PaymentModel value, $Res Function(PaymentModel) _then) = _$PaymentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: PaymentMethod.other) PaymentMethod method, double amount, String reference,@TimestampConverter() DateTime receivedAt
});




}
/// @nodoc
class _$PaymentModelCopyWithImpl<$Res>
    implements $PaymentModelCopyWith<$Res> {
  _$PaymentModelCopyWithImpl(this._self, this._then);

  final PaymentModel _self;
  final $Res Function(PaymentModel) _then;

/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? method = null,Object? amount = null,Object? reference = null,Object? receivedAt = null,}) {
  return _then(_self.copyWith(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethod,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentModel].
extension PaymentModelPatterns on PaymentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: PaymentMethod.other)  PaymentMethod method,  double amount,  String reference, @TimestampConverter()  DateTime receivedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
return $default(_that.method,_that.amount,_that.reference,_that.receivedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: PaymentMethod.other)  PaymentMethod method,  double amount,  String reference, @TimestampConverter()  DateTime receivedAt)  $default,) {final _that = this;
switch (_that) {
case _PaymentModel():
return $default(_that.method,_that.amount,_that.reference,_that.receivedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: PaymentMethod.other)  PaymentMethod method,  double amount,  String reference, @TimestampConverter()  DateTime receivedAt)?  $default,) {final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
return $default(_that.method,_that.amount,_that.reference,_that.receivedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentModel extends PaymentModel {
  const _PaymentModel({@JsonKey(unknownEnumValue: PaymentMethod.other) required this.method, required this.amount, this.reference = '', @TimestampConverter() required this.receivedAt}): super._();
  factory _PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);

@override@JsonKey(unknownEnumValue: PaymentMethod.other) final  PaymentMethod method;
@override final  double amount;
@override@JsonKey() final  String reference;
@override@TimestampConverter() final  DateTime receivedAt;

/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentModelCopyWith<_PaymentModel> get copyWith => __$PaymentModelCopyWithImpl<_PaymentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentModel&&(identical(other.method, method) || other.method == method)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,amount,reference,receivedAt);

@override
String toString() {
  return 'PaymentModel(method: $method, amount: $amount, reference: $reference, receivedAt: $receivedAt)';
}


}

/// @nodoc
abstract mixin class _$PaymentModelCopyWith<$Res> implements $PaymentModelCopyWith<$Res> {
  factory _$PaymentModelCopyWith(_PaymentModel value, $Res Function(_PaymentModel) _then) = __$PaymentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: PaymentMethod.other) PaymentMethod method, double amount, String reference,@TimestampConverter() DateTime receivedAt
});




}
/// @nodoc
class __$PaymentModelCopyWithImpl<$Res>
    implements _$PaymentModelCopyWith<$Res> {
  __$PaymentModelCopyWithImpl(this._self, this._then);

  final _PaymentModel _self;
  final $Res Function(_PaymentModel) _then;

/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? method = null,Object? amount = null,Object? reference = null,Object? receivedAt = null,}) {
  return _then(_PaymentModel(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethod,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$BillModel {

@JsonKey(includeToJson: false) String get id; String get billNumber;@JsonKey(unknownEnumValue: BillStatus.open) BillStatus get status;@JsonKey(unknownEnumValue: OrderType.dineIn) OrderType get orderType; List<String> get tableIds; List<String> get tableLabels; String? get reservationId; String? get customerId; String get customerName; String get customerPhone; int get guests; List<BillItemModel> get items;@JsonKey(unknownEnumValue: DiscountType.none) DiscountType get discountType; double get discountValue; double get taxRate; double get serviceChargeRate; double get subtotal; double get discountAmount; double get serviceCharge; double get tax; double get total; List<PaymentModel> get payments; String get notes; String get openedById; String get openedByName; String? get closedById; String? get closedByName; String get voidReason;@NullableTimestampConverter() DateTime? get closedAt;@NullableTimestampConverter() DateTime? get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;
/// Create a copy of BillModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillModelCopyWith<BillModel> get copyWith => _$BillModelCopyWithImpl<BillModel>(this as BillModel, _$identity);

  /// Serializes this BillModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillModel&&(identical(other.id, id) || other.id == id)&&(identical(other.billNumber, billNumber) || other.billNumber == billNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.orderType, orderType) || other.orderType == orderType)&&const DeepCollectionEquality().equals(other.tableIds, tableIds)&&const DeepCollectionEquality().equals(other.tableLabels, tableLabels)&&(identical(other.reservationId, reservationId) || other.reservationId == reservationId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.guests, guests) || other.guests == guests)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.serviceChargeRate, serviceChargeRate) || other.serviceChargeRate == serviceChargeRate)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.serviceCharge, serviceCharge) || other.serviceCharge == serviceCharge)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.payments, payments)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.openedById, openedById) || other.openedById == openedById)&&(identical(other.openedByName, openedByName) || other.openedByName == openedByName)&&(identical(other.closedById, closedById) || other.closedById == closedById)&&(identical(other.closedByName, closedByName) || other.closedByName == closedByName)&&(identical(other.voidReason, voidReason) || other.voidReason == voidReason)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,billNumber,status,orderType,const DeepCollectionEquality().hash(tableIds),const DeepCollectionEquality().hash(tableLabels),reservationId,customerId,customerName,customerPhone,guests,const DeepCollectionEquality().hash(items),discountType,discountValue,taxRate,serviceChargeRate,subtotal,discountAmount,serviceCharge,tax,total,const DeepCollectionEquality().hash(payments),notes,openedById,openedByName,closedById,closedByName,voidReason,closedAt,createdAt,updatedAt]);

@override
String toString() {
  return 'BillModel(id: $id, billNumber: $billNumber, status: $status, orderType: $orderType, tableIds: $tableIds, tableLabels: $tableLabels, reservationId: $reservationId, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, guests: $guests, items: $items, discountType: $discountType, discountValue: $discountValue, taxRate: $taxRate, serviceChargeRate: $serviceChargeRate, subtotal: $subtotal, discountAmount: $discountAmount, serviceCharge: $serviceCharge, tax: $tax, total: $total, payments: $payments, notes: $notes, openedById: $openedById, openedByName: $openedByName, closedById: $closedById, closedByName: $closedByName, voidReason: $voidReason, closedAt: $closedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BillModelCopyWith<$Res>  {
  factory $BillModelCopyWith(BillModel value, $Res Function(BillModel) _then) = _$BillModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String id, String billNumber,@JsonKey(unknownEnumValue: BillStatus.open) BillStatus status,@JsonKey(unknownEnumValue: OrderType.dineIn) OrderType orderType, List<String> tableIds, List<String> tableLabels, String? reservationId, String? customerId, String customerName, String customerPhone, int guests, List<BillItemModel> items,@JsonKey(unknownEnumValue: DiscountType.none) DiscountType discountType, double discountValue, double taxRate, double serviceChargeRate, double subtotal, double discountAmount, double serviceCharge, double tax, double total, List<PaymentModel> payments, String notes, String openedById, String openedByName, String? closedById, String? closedByName, String voidReason,@NullableTimestampConverter() DateTime? closedAt,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$BillModelCopyWithImpl<$Res>
    implements $BillModelCopyWith<$Res> {
  _$BillModelCopyWithImpl(this._self, this._then);

  final BillModel _self;
  final $Res Function(BillModel) _then;

/// Create a copy of BillModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? billNumber = null,Object? status = null,Object? orderType = null,Object? tableIds = null,Object? tableLabels = null,Object? reservationId = freezed,Object? customerId = freezed,Object? customerName = null,Object? customerPhone = null,Object? guests = null,Object? items = null,Object? discountType = null,Object? discountValue = null,Object? taxRate = null,Object? serviceChargeRate = null,Object? subtotal = null,Object? discountAmount = null,Object? serviceCharge = null,Object? tax = null,Object? total = null,Object? payments = null,Object? notes = null,Object? openedById = null,Object? openedByName = null,Object? closedById = freezed,Object? closedByName = freezed,Object? voidReason = null,Object? closedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,billNumber: null == billNumber ? _self.billNumber : billNumber // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BillStatus,orderType: null == orderType ? _self.orderType : orderType // ignore: cast_nullable_to_non_nullable
as OrderType,tableIds: null == tableIds ? _self.tableIds : tableIds // ignore: cast_nullable_to_non_nullable
as List<String>,tableLabels: null == tableLabels ? _self.tableLabels : tableLabels // ignore: cast_nullable_to_non_nullable
as List<String>,reservationId: freezed == reservationId ? _self.reservationId : reservationId // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<BillItemModel>,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,serviceChargeRate: null == serviceChargeRate ? _self.serviceChargeRate : serviceChargeRate // ignore: cast_nullable_to_non_nullable
as double,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,serviceCharge: null == serviceCharge ? _self.serviceCharge : serviceCharge // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<PaymentModel>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,openedById: null == openedById ? _self.openedById : openedById // ignore: cast_nullable_to_non_nullable
as String,openedByName: null == openedByName ? _self.openedByName : openedByName // ignore: cast_nullable_to_non_nullable
as String,closedById: freezed == closedById ? _self.closedById : closedById // ignore: cast_nullable_to_non_nullable
as String?,closedByName: freezed == closedByName ? _self.closedByName : closedByName // ignore: cast_nullable_to_non_nullable
as String?,voidReason: null == voidReason ? _self.voidReason : voidReason // ignore: cast_nullable_to_non_nullable
as String,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BillModel].
extension BillModelPatterns on BillModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillModel value)  $default,){
final _that = this;
switch (_that) {
case _BillModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillModel value)?  $default,){
final _that = this;
switch (_that) {
case _BillModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String billNumber, @JsonKey(unknownEnumValue: BillStatus.open)  BillStatus status, @JsonKey(unknownEnumValue: OrderType.dineIn)  OrderType orderType,  List<String> tableIds,  List<String> tableLabels,  String? reservationId,  String? customerId,  String customerName,  String customerPhone,  int guests,  List<BillItemModel> items, @JsonKey(unknownEnumValue: DiscountType.none)  DiscountType discountType,  double discountValue,  double taxRate,  double serviceChargeRate,  double subtotal,  double discountAmount,  double serviceCharge,  double tax,  double total,  List<PaymentModel> payments,  String notes,  String openedById,  String openedByName,  String? closedById,  String? closedByName,  String voidReason, @NullableTimestampConverter()  DateTime? closedAt, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillModel() when $default != null:
return $default(_that.id,_that.billNumber,_that.status,_that.orderType,_that.tableIds,_that.tableLabels,_that.reservationId,_that.customerId,_that.customerName,_that.customerPhone,_that.guests,_that.items,_that.discountType,_that.discountValue,_that.taxRate,_that.serviceChargeRate,_that.subtotal,_that.discountAmount,_that.serviceCharge,_that.tax,_that.total,_that.payments,_that.notes,_that.openedById,_that.openedByName,_that.closedById,_that.closedByName,_that.voidReason,_that.closedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String billNumber, @JsonKey(unknownEnumValue: BillStatus.open)  BillStatus status, @JsonKey(unknownEnumValue: OrderType.dineIn)  OrderType orderType,  List<String> tableIds,  List<String> tableLabels,  String? reservationId,  String? customerId,  String customerName,  String customerPhone,  int guests,  List<BillItemModel> items, @JsonKey(unknownEnumValue: DiscountType.none)  DiscountType discountType,  double discountValue,  double taxRate,  double serviceChargeRate,  double subtotal,  double discountAmount,  double serviceCharge,  double tax,  double total,  List<PaymentModel> payments,  String notes,  String openedById,  String openedByName,  String? closedById,  String? closedByName,  String voidReason, @NullableTimestampConverter()  DateTime? closedAt, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BillModel():
return $default(_that.id,_that.billNumber,_that.status,_that.orderType,_that.tableIds,_that.tableLabels,_that.reservationId,_that.customerId,_that.customerName,_that.customerPhone,_that.guests,_that.items,_that.discountType,_that.discountValue,_that.taxRate,_that.serviceChargeRate,_that.subtotal,_that.discountAmount,_that.serviceCharge,_that.tax,_that.total,_that.payments,_that.notes,_that.openedById,_that.openedByName,_that.closedById,_that.closedByName,_that.voidReason,_that.closedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String id,  String billNumber, @JsonKey(unknownEnumValue: BillStatus.open)  BillStatus status, @JsonKey(unknownEnumValue: OrderType.dineIn)  OrderType orderType,  List<String> tableIds,  List<String> tableLabels,  String? reservationId,  String? customerId,  String customerName,  String customerPhone,  int guests,  List<BillItemModel> items, @JsonKey(unknownEnumValue: DiscountType.none)  DiscountType discountType,  double discountValue,  double taxRate,  double serviceChargeRate,  double subtotal,  double discountAmount,  double serviceCharge,  double tax,  double total,  List<PaymentModel> payments,  String notes,  String openedById,  String openedByName,  String? closedById,  String? closedByName,  String voidReason, @NullableTimestampConverter()  DateTime? closedAt, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BillModel() when $default != null:
return $default(_that.id,_that.billNumber,_that.status,_that.orderType,_that.tableIds,_that.tableLabels,_that.reservationId,_that.customerId,_that.customerName,_that.customerPhone,_that.guests,_that.items,_that.discountType,_that.discountValue,_that.taxRate,_that.serviceChargeRate,_that.subtotal,_that.discountAmount,_that.serviceCharge,_that.tax,_that.total,_that.payments,_that.notes,_that.openedById,_that.openedByName,_that.closedById,_that.closedByName,_that.voidReason,_that.closedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BillModel extends BillModel {
  const _BillModel({@JsonKey(includeToJson: false) this.id = '', this.billNumber = '', @JsonKey(unknownEnumValue: BillStatus.open) this.status = BillStatus.open, @JsonKey(unknownEnumValue: OrderType.dineIn) this.orderType = OrderType.dineIn, final  List<String> tableIds = const <String>[], final  List<String> tableLabels = const <String>[], this.reservationId, this.customerId, this.customerName = '', this.customerPhone = '', this.guests = 1, final  List<BillItemModel> items = const <BillItemModel>[], @JsonKey(unknownEnumValue: DiscountType.none) this.discountType = DiscountType.none, this.discountValue = 0.0, this.taxRate = 0.0, this.serviceChargeRate = 0.0, this.subtotal = 0.0, this.discountAmount = 0.0, this.serviceCharge = 0.0, this.tax = 0.0, this.total = 0.0, final  List<PaymentModel> payments = const <PaymentModel>[], this.notes = '', this.openedById = '', this.openedByName = '', this.closedById, this.closedByName, this.voidReason = '', @NullableTimestampConverter() this.closedAt, @NullableTimestampConverter() this.createdAt, @NullableTimestampConverter() this.updatedAt}): _tableIds = tableIds,_tableLabels = tableLabels,_items = items,_payments = payments,super._();
  factory _BillModel.fromJson(Map<String, dynamic> json) => _$BillModelFromJson(json);

@override@JsonKey(includeToJson: false) final  String id;
@override@JsonKey() final  String billNumber;
@override@JsonKey(unknownEnumValue: BillStatus.open) final  BillStatus status;
@override@JsonKey(unknownEnumValue: OrderType.dineIn) final  OrderType orderType;
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

@override final  String? reservationId;
@override final  String? customerId;
@override@JsonKey() final  String customerName;
@override@JsonKey() final  String customerPhone;
@override@JsonKey() final  int guests;
 final  List<BillItemModel> _items;
@override@JsonKey() List<BillItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(unknownEnumValue: DiscountType.none) final  DiscountType discountType;
@override@JsonKey() final  double discountValue;
@override@JsonKey() final  double taxRate;
@override@JsonKey() final  double serviceChargeRate;
@override@JsonKey() final  double subtotal;
@override@JsonKey() final  double discountAmount;
@override@JsonKey() final  double serviceCharge;
@override@JsonKey() final  double tax;
@override@JsonKey() final  double total;
 final  List<PaymentModel> _payments;
@override@JsonKey() List<PaymentModel> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}

@override@JsonKey() final  String notes;
@override@JsonKey() final  String openedById;
@override@JsonKey() final  String openedByName;
@override final  String? closedById;
@override final  String? closedByName;
@override@JsonKey() final  String voidReason;
@override@NullableTimestampConverter() final  DateTime? closedAt;
@override@NullableTimestampConverter() final  DateTime? createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of BillModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillModelCopyWith<_BillModel> get copyWith => __$BillModelCopyWithImpl<_BillModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillModel&&(identical(other.id, id) || other.id == id)&&(identical(other.billNumber, billNumber) || other.billNumber == billNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.orderType, orderType) || other.orderType == orderType)&&const DeepCollectionEquality().equals(other._tableIds, _tableIds)&&const DeepCollectionEquality().equals(other._tableLabels, _tableLabels)&&(identical(other.reservationId, reservationId) || other.reservationId == reservationId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.guests, guests) || other.guests == guests)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.serviceChargeRate, serviceChargeRate) || other.serviceChargeRate == serviceChargeRate)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.serviceCharge, serviceCharge) || other.serviceCharge == serviceCharge)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._payments, _payments)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.openedById, openedById) || other.openedById == openedById)&&(identical(other.openedByName, openedByName) || other.openedByName == openedByName)&&(identical(other.closedById, closedById) || other.closedById == closedById)&&(identical(other.closedByName, closedByName) || other.closedByName == closedByName)&&(identical(other.voidReason, voidReason) || other.voidReason == voidReason)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,billNumber,status,orderType,const DeepCollectionEquality().hash(_tableIds),const DeepCollectionEquality().hash(_tableLabels),reservationId,customerId,customerName,customerPhone,guests,const DeepCollectionEquality().hash(_items),discountType,discountValue,taxRate,serviceChargeRate,subtotal,discountAmount,serviceCharge,tax,total,const DeepCollectionEquality().hash(_payments),notes,openedById,openedByName,closedById,closedByName,voidReason,closedAt,createdAt,updatedAt]);

@override
String toString() {
  return 'BillModel(id: $id, billNumber: $billNumber, status: $status, orderType: $orderType, tableIds: $tableIds, tableLabels: $tableLabels, reservationId: $reservationId, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, guests: $guests, items: $items, discountType: $discountType, discountValue: $discountValue, taxRate: $taxRate, serviceChargeRate: $serviceChargeRate, subtotal: $subtotal, discountAmount: $discountAmount, serviceCharge: $serviceCharge, tax: $tax, total: $total, payments: $payments, notes: $notes, openedById: $openedById, openedByName: $openedByName, closedById: $closedById, closedByName: $closedByName, voidReason: $voidReason, closedAt: $closedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BillModelCopyWith<$Res> implements $BillModelCopyWith<$Res> {
  factory _$BillModelCopyWith(_BillModel value, $Res Function(_BillModel) _then) = __$BillModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String id, String billNumber,@JsonKey(unknownEnumValue: BillStatus.open) BillStatus status,@JsonKey(unknownEnumValue: OrderType.dineIn) OrderType orderType, List<String> tableIds, List<String> tableLabels, String? reservationId, String? customerId, String customerName, String customerPhone, int guests, List<BillItemModel> items,@JsonKey(unknownEnumValue: DiscountType.none) DiscountType discountType, double discountValue, double taxRate, double serviceChargeRate, double subtotal, double discountAmount, double serviceCharge, double tax, double total, List<PaymentModel> payments, String notes, String openedById, String openedByName, String? closedById, String? closedByName, String voidReason,@NullableTimestampConverter() DateTime? closedAt,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$BillModelCopyWithImpl<$Res>
    implements _$BillModelCopyWith<$Res> {
  __$BillModelCopyWithImpl(this._self, this._then);

  final _BillModel _self;
  final $Res Function(_BillModel) _then;

/// Create a copy of BillModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? billNumber = null,Object? status = null,Object? orderType = null,Object? tableIds = null,Object? tableLabels = null,Object? reservationId = freezed,Object? customerId = freezed,Object? customerName = null,Object? customerPhone = null,Object? guests = null,Object? items = null,Object? discountType = null,Object? discountValue = null,Object? taxRate = null,Object? serviceChargeRate = null,Object? subtotal = null,Object? discountAmount = null,Object? serviceCharge = null,Object? tax = null,Object? total = null,Object? payments = null,Object? notes = null,Object? openedById = null,Object? openedByName = null,Object? closedById = freezed,Object? closedByName = freezed,Object? voidReason = null,Object? closedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_BillModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,billNumber: null == billNumber ? _self.billNumber : billNumber // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BillStatus,orderType: null == orderType ? _self.orderType : orderType // ignore: cast_nullable_to_non_nullable
as OrderType,tableIds: null == tableIds ? _self._tableIds : tableIds // ignore: cast_nullable_to_non_nullable
as List<String>,tableLabels: null == tableLabels ? _self._tableLabels : tableLabels // ignore: cast_nullable_to_non_nullable
as List<String>,reservationId: freezed == reservationId ? _self.reservationId : reservationId // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<BillItemModel>,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,serviceChargeRate: null == serviceChargeRate ? _self.serviceChargeRate : serviceChargeRate // ignore: cast_nullable_to_non_nullable
as double,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,serviceCharge: null == serviceCharge ? _self.serviceCharge : serviceCharge // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<PaymentModel>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,openedById: null == openedById ? _self.openedById : openedById // ignore: cast_nullable_to_non_nullable
as String,openedByName: null == openedByName ? _self.openedByName : openedByName // ignore: cast_nullable_to_non_nullable
as String,closedById: freezed == closedById ? _self.closedById : closedById // ignore: cast_nullable_to_non_nullable
as String?,closedByName: freezed == closedByName ? _self.closedByName : closedByName // ignore: cast_nullable_to_non_nullable
as String?,voidReason: null == voidReason ? _self.voidReason : voidReason // ignore: cast_nullable_to_non_nullable
as String,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
