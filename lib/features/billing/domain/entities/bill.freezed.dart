// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillItem {

 String get lineId; String get menuItemId; String get name; double get unitPrice; int get quantity; String get note;/// Sent-to-kitchen marker (KOT) for future kitchen display integration.
 bool get sent;
/// Create a copy of BillItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillItemCopyWith<BillItem> get copyWith => _$BillItemCopyWithImpl<BillItem>(this as BillItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillItem&&(identical(other.lineId, lineId) || other.lineId == lineId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.name, name) || other.name == name)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.note, note) || other.note == note)&&(identical(other.sent, sent) || other.sent == sent));
}


@override
int get hashCode => Object.hash(runtimeType,lineId,menuItemId,name,unitPrice,quantity,note,sent);

@override
String toString() {
  return 'BillItem(lineId: $lineId, menuItemId: $menuItemId, name: $name, unitPrice: $unitPrice, quantity: $quantity, note: $note, sent: $sent)';
}


}

/// @nodoc
abstract mixin class $BillItemCopyWith<$Res>  {
  factory $BillItemCopyWith(BillItem value, $Res Function(BillItem) _then) = _$BillItemCopyWithImpl;
@useResult
$Res call({
 String lineId, String menuItemId, String name, double unitPrice, int quantity, String note, bool sent
});




}
/// @nodoc
class _$BillItemCopyWithImpl<$Res>
    implements $BillItemCopyWith<$Res> {
  _$BillItemCopyWithImpl(this._self, this._then);

  final BillItem _self;
  final $Res Function(BillItem) _then;

/// Create a copy of BillItem
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


/// Adds pattern-matching-related methods to [BillItem].
extension BillItemPatterns on BillItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillItem value)  $default,){
final _that = this;
switch (_that) {
case _BillItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillItem value)?  $default,){
final _that = this;
switch (_that) {
case _BillItem() when $default != null:
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
case _BillItem() when $default != null:
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
case _BillItem():
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
case _BillItem() when $default != null:
return $default(_that.lineId,_that.menuItemId,_that.name,_that.unitPrice,_that.quantity,_that.note,_that.sent);case _:
  return null;

}
}

}

/// @nodoc


class _BillItem extends BillItem {
  const _BillItem({required this.lineId, required this.menuItemId, required this.name, required this.unitPrice, this.quantity = 1, this.note = '', this.sent = false}): super._();
  

@override final  String lineId;
@override final  String menuItemId;
@override final  String name;
@override final  double unitPrice;
@override@JsonKey() final  int quantity;
@override@JsonKey() final  String note;
/// Sent-to-kitchen marker (KOT) for future kitchen display integration.
@override@JsonKey() final  bool sent;

/// Create a copy of BillItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillItemCopyWith<_BillItem> get copyWith => __$BillItemCopyWithImpl<_BillItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillItem&&(identical(other.lineId, lineId) || other.lineId == lineId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.name, name) || other.name == name)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.note, note) || other.note == note)&&(identical(other.sent, sent) || other.sent == sent));
}


@override
int get hashCode => Object.hash(runtimeType,lineId,menuItemId,name,unitPrice,quantity,note,sent);

@override
String toString() {
  return 'BillItem(lineId: $lineId, menuItemId: $menuItemId, name: $name, unitPrice: $unitPrice, quantity: $quantity, note: $note, sent: $sent)';
}


}

/// @nodoc
abstract mixin class _$BillItemCopyWith<$Res> implements $BillItemCopyWith<$Res> {
  factory _$BillItemCopyWith(_BillItem value, $Res Function(_BillItem) _then) = __$BillItemCopyWithImpl;
@override @useResult
$Res call({
 String lineId, String menuItemId, String name, double unitPrice, int quantity, String note, bool sent
});




}
/// @nodoc
class __$BillItemCopyWithImpl<$Res>
    implements _$BillItemCopyWith<$Res> {
  __$BillItemCopyWithImpl(this._self, this._then);

  final _BillItem _self;
  final $Res Function(_BillItem) _then;

/// Create a copy of BillItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lineId = null,Object? menuItemId = null,Object? name = null,Object? unitPrice = null,Object? quantity = null,Object? note = null,Object? sent = null,}) {
  return _then(_BillItem(
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
mixin _$Payment {

 PaymentMethod get method; double get amount; String get reference; DateTime get receivedAt;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.method, method) || other.method == method)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt));
}


@override
int get hashCode => Object.hash(runtimeType,method,amount,reference,receivedAt);

@override
String toString() {
  return 'Payment(method: $method, amount: $amount, reference: $reference, receivedAt: $receivedAt)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 PaymentMethod method, double amount, String reference, DateTime receivedAt
});




}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
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


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaymentMethod method,  double amount,  String reference,  DateTime receivedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaymentMethod method,  double amount,  String reference,  DateTime receivedAt)  $default,) {final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaymentMethod method,  double amount,  String reference,  DateTime receivedAt)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.method,_that.amount,_that.reference,_that.receivedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Payment implements Payment {
  const _Payment({required this.method, required this.amount, this.reference = '', required this.receivedAt});
  

@override final  PaymentMethod method;
@override final  double amount;
@override@JsonKey() final  String reference;
@override final  DateTime receivedAt;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.method, method) || other.method == method)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt));
}


@override
int get hashCode => Object.hash(runtimeType,method,amount,reference,receivedAt);

@override
String toString() {
  return 'Payment(method: $method, amount: $amount, reference: $reference, receivedAt: $receivedAt)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 PaymentMethod method, double amount, String reference, DateTime receivedAt
});




}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? method = null,Object? amount = null,Object? reference = null,Object? receivedAt = null,}) {
  return _then(_Payment(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethod,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$BillTotals {

 double get subtotal; double get discount; double get serviceCharge; double get tax; double get total;
/// Create a copy of BillTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillTotalsCopyWith<BillTotals> get copyWith => _$BillTotalsCopyWithImpl<BillTotals>(this as BillTotals, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillTotals&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.serviceCharge, serviceCharge) || other.serviceCharge == serviceCharge)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,subtotal,discount,serviceCharge,tax,total);

@override
String toString() {
  return 'BillTotals(subtotal: $subtotal, discount: $discount, serviceCharge: $serviceCharge, tax: $tax, total: $total)';
}


}

/// @nodoc
abstract mixin class $BillTotalsCopyWith<$Res>  {
  factory $BillTotalsCopyWith(BillTotals value, $Res Function(BillTotals) _then) = _$BillTotalsCopyWithImpl;
@useResult
$Res call({
 double subtotal, double discount, double serviceCharge, double tax, double total
});




}
/// @nodoc
class _$BillTotalsCopyWithImpl<$Res>
    implements $BillTotalsCopyWith<$Res> {
  _$BillTotalsCopyWithImpl(this._self, this._then);

  final BillTotals _self;
  final $Res Function(BillTotals) _then;

/// Create a copy of BillTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subtotal = null,Object? discount = null,Object? serviceCharge = null,Object? tax = null,Object? total = null,}) {
  return _then(_self.copyWith(
subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,serviceCharge: null == serviceCharge ? _self.serviceCharge : serviceCharge // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BillTotals].
extension BillTotalsPatterns on BillTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillTotals value)  $default,){
final _that = this;
switch (_that) {
case _BillTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillTotals value)?  $default,){
final _that = this;
switch (_that) {
case _BillTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double subtotal,  double discount,  double serviceCharge,  double tax,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillTotals() when $default != null:
return $default(_that.subtotal,_that.discount,_that.serviceCharge,_that.tax,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double subtotal,  double discount,  double serviceCharge,  double tax,  double total)  $default,) {final _that = this;
switch (_that) {
case _BillTotals():
return $default(_that.subtotal,_that.discount,_that.serviceCharge,_that.tax,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double subtotal,  double discount,  double serviceCharge,  double tax,  double total)?  $default,) {final _that = this;
switch (_that) {
case _BillTotals() when $default != null:
return $default(_that.subtotal,_that.discount,_that.serviceCharge,_that.tax,_that.total);case _:
  return null;

}
}

}

/// @nodoc


class _BillTotals implements BillTotals {
  const _BillTotals({this.subtotal = 0.0, this.discount = 0.0, this.serviceCharge = 0.0, this.tax = 0.0, this.total = 0.0});
  

@override@JsonKey() final  double subtotal;
@override@JsonKey() final  double discount;
@override@JsonKey() final  double serviceCharge;
@override@JsonKey() final  double tax;
@override@JsonKey() final  double total;

/// Create a copy of BillTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillTotalsCopyWith<_BillTotals> get copyWith => __$BillTotalsCopyWithImpl<_BillTotals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillTotals&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.serviceCharge, serviceCharge) || other.serviceCharge == serviceCharge)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,subtotal,discount,serviceCharge,tax,total);

@override
String toString() {
  return 'BillTotals(subtotal: $subtotal, discount: $discount, serviceCharge: $serviceCharge, tax: $tax, total: $total)';
}


}

/// @nodoc
abstract mixin class _$BillTotalsCopyWith<$Res> implements $BillTotalsCopyWith<$Res> {
  factory _$BillTotalsCopyWith(_BillTotals value, $Res Function(_BillTotals) _then) = __$BillTotalsCopyWithImpl;
@override @useResult
$Res call({
 double subtotal, double discount, double serviceCharge, double tax, double total
});




}
/// @nodoc
class __$BillTotalsCopyWithImpl<$Res>
    implements _$BillTotalsCopyWith<$Res> {
  __$BillTotalsCopyWithImpl(this._self, this._then);

  final _BillTotals _self;
  final $Res Function(_BillTotals) _then;

/// Create a copy of BillTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subtotal = null,Object? discount = null,Object? serviceCharge = null,Object? tax = null,Object? total = null,}) {
  return _then(_BillTotals(
subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,serviceCharge: null == serviceCharge ? _self.serviceCharge : serviceCharge // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$Bill {

 String get id; String get billNumber; BillStatus get status; OrderType get orderType; List<String> get tableIds; List<String> get tableLabels; String? get reservationId; String? get customerId; String get customerName; String get customerPhone; int get guests; List<BillItem> get items; DiscountType get discountType; double get discountValue; double get taxRate; double get serviceChargeRate; BillTotals get totals; List<Payment> get payments; String get notes; String get openedById; String get openedByName; String? get closedById; String? get closedByName; String get voidReason; DateTime? get closedAt; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillCopyWith<Bill> get copyWith => _$BillCopyWithImpl<Bill>(this as Bill, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bill&&(identical(other.id, id) || other.id == id)&&(identical(other.billNumber, billNumber) || other.billNumber == billNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.orderType, orderType) || other.orderType == orderType)&&const DeepCollectionEquality().equals(other.tableIds, tableIds)&&const DeepCollectionEquality().equals(other.tableLabels, tableLabels)&&(identical(other.reservationId, reservationId) || other.reservationId == reservationId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.guests, guests) || other.guests == guests)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.serviceChargeRate, serviceChargeRate) || other.serviceChargeRate == serviceChargeRate)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other.payments, payments)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.openedById, openedById) || other.openedById == openedById)&&(identical(other.openedByName, openedByName) || other.openedByName == openedByName)&&(identical(other.closedById, closedById) || other.closedById == closedById)&&(identical(other.closedByName, closedByName) || other.closedByName == closedByName)&&(identical(other.voidReason, voidReason) || other.voidReason == voidReason)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,billNumber,status,orderType,const DeepCollectionEquality().hash(tableIds),const DeepCollectionEquality().hash(tableLabels),reservationId,customerId,customerName,customerPhone,guests,const DeepCollectionEquality().hash(items),discountType,discountValue,taxRate,serviceChargeRate,totals,const DeepCollectionEquality().hash(payments),notes,openedById,openedByName,closedById,closedByName,voidReason,closedAt,createdAt,updatedAt]);

@override
String toString() {
  return 'Bill(id: $id, billNumber: $billNumber, status: $status, orderType: $orderType, tableIds: $tableIds, tableLabels: $tableLabels, reservationId: $reservationId, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, guests: $guests, items: $items, discountType: $discountType, discountValue: $discountValue, taxRate: $taxRate, serviceChargeRate: $serviceChargeRate, totals: $totals, payments: $payments, notes: $notes, openedById: $openedById, openedByName: $openedByName, closedById: $closedById, closedByName: $closedByName, voidReason: $voidReason, closedAt: $closedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BillCopyWith<$Res>  {
  factory $BillCopyWith(Bill value, $Res Function(Bill) _then) = _$BillCopyWithImpl;
@useResult
$Res call({
 String id, String billNumber, BillStatus status, OrderType orderType, List<String> tableIds, List<String> tableLabels, String? reservationId, String? customerId, String customerName, String customerPhone, int guests, List<BillItem> items, DiscountType discountType, double discountValue, double taxRate, double serviceChargeRate, BillTotals totals, List<Payment> payments, String notes, String openedById, String openedByName, String? closedById, String? closedByName, String voidReason, DateTime? closedAt, DateTime? createdAt, DateTime? updatedAt
});


$BillTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class _$BillCopyWithImpl<$Res>
    implements $BillCopyWith<$Res> {
  _$BillCopyWithImpl(this._self, this._then);

  final Bill _self;
  final $Res Function(Bill) _then;

/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? billNumber = null,Object? status = null,Object? orderType = null,Object? tableIds = null,Object? tableLabels = null,Object? reservationId = freezed,Object? customerId = freezed,Object? customerName = null,Object? customerPhone = null,Object? guests = null,Object? items = null,Object? discountType = null,Object? discountValue = null,Object? taxRate = null,Object? serviceChargeRate = null,Object? totals = null,Object? payments = null,Object? notes = null,Object? openedById = null,Object? openedByName = null,Object? closedById = freezed,Object? closedByName = freezed,Object? voidReason = null,Object? closedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
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
as List<BillItem>,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,serviceChargeRate: null == serviceChargeRate ? _self.serviceChargeRate : serviceChargeRate // ignore: cast_nullable_to_non_nullable
as double,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as BillTotals,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<Payment>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
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
/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BillTotalsCopyWith<$Res> get totals {
  
  return $BillTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [Bill].
extension BillPatterns on Bill {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bill() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bill value)  $default,){
final _that = this;
switch (_that) {
case _Bill():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bill value)?  $default,){
final _that = this;
switch (_that) {
case _Bill() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String billNumber,  BillStatus status,  OrderType orderType,  List<String> tableIds,  List<String> tableLabels,  String? reservationId,  String? customerId,  String customerName,  String customerPhone,  int guests,  List<BillItem> items,  DiscountType discountType,  double discountValue,  double taxRate,  double serviceChargeRate,  BillTotals totals,  List<Payment> payments,  String notes,  String openedById,  String openedByName,  String? closedById,  String? closedByName,  String voidReason,  DateTime? closedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bill() when $default != null:
return $default(_that.id,_that.billNumber,_that.status,_that.orderType,_that.tableIds,_that.tableLabels,_that.reservationId,_that.customerId,_that.customerName,_that.customerPhone,_that.guests,_that.items,_that.discountType,_that.discountValue,_that.taxRate,_that.serviceChargeRate,_that.totals,_that.payments,_that.notes,_that.openedById,_that.openedByName,_that.closedById,_that.closedByName,_that.voidReason,_that.closedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String billNumber,  BillStatus status,  OrderType orderType,  List<String> tableIds,  List<String> tableLabels,  String? reservationId,  String? customerId,  String customerName,  String customerPhone,  int guests,  List<BillItem> items,  DiscountType discountType,  double discountValue,  double taxRate,  double serviceChargeRate,  BillTotals totals,  List<Payment> payments,  String notes,  String openedById,  String openedByName,  String? closedById,  String? closedByName,  String voidReason,  DateTime? closedAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Bill():
return $default(_that.id,_that.billNumber,_that.status,_that.orderType,_that.tableIds,_that.tableLabels,_that.reservationId,_that.customerId,_that.customerName,_that.customerPhone,_that.guests,_that.items,_that.discountType,_that.discountValue,_that.taxRate,_that.serviceChargeRate,_that.totals,_that.payments,_that.notes,_that.openedById,_that.openedByName,_that.closedById,_that.closedByName,_that.voidReason,_that.closedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String billNumber,  BillStatus status,  OrderType orderType,  List<String> tableIds,  List<String> tableLabels,  String? reservationId,  String? customerId,  String customerName,  String customerPhone,  int guests,  List<BillItem> items,  DiscountType discountType,  double discountValue,  double taxRate,  double serviceChargeRate,  BillTotals totals,  List<Payment> payments,  String notes,  String openedById,  String openedByName,  String? closedById,  String? closedByName,  String voidReason,  DateTime? closedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Bill() when $default != null:
return $default(_that.id,_that.billNumber,_that.status,_that.orderType,_that.tableIds,_that.tableLabels,_that.reservationId,_that.customerId,_that.customerName,_that.customerPhone,_that.guests,_that.items,_that.discountType,_that.discountValue,_that.taxRate,_that.serviceChargeRate,_that.totals,_that.payments,_that.notes,_that.openedById,_that.openedByName,_that.closedById,_that.closedByName,_that.voidReason,_that.closedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Bill extends Bill {
  const _Bill({required this.id, this.billNumber = '', this.status = BillStatus.open, this.orderType = OrderType.dineIn, final  List<String> tableIds = const <String>[], final  List<String> tableLabels = const <String>[], this.reservationId, this.customerId, this.customerName = '', this.customerPhone = '', this.guests = 1, final  List<BillItem> items = const <BillItem>[], this.discountType = DiscountType.none, this.discountValue = 0.0, this.taxRate = 0.0, this.serviceChargeRate = 0.0, this.totals = const BillTotals(), final  List<Payment> payments = const <Payment>[], this.notes = '', this.openedById = '', this.openedByName = '', this.closedById, this.closedByName, this.voidReason = '', this.closedAt, this.createdAt, this.updatedAt}): _tableIds = tableIds,_tableLabels = tableLabels,_items = items,_payments = payments,super._();
  

@override final  String id;
@override@JsonKey() final  String billNumber;
@override@JsonKey() final  BillStatus status;
@override@JsonKey() final  OrderType orderType;
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
 final  List<BillItem> _items;
@override@JsonKey() List<BillItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  DiscountType discountType;
@override@JsonKey() final  double discountValue;
@override@JsonKey() final  double taxRate;
@override@JsonKey() final  double serviceChargeRate;
@override@JsonKey() final  BillTotals totals;
 final  List<Payment> _payments;
@override@JsonKey() List<Payment> get payments {
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
@override final  DateTime? closedAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillCopyWith<_Bill> get copyWith => __$BillCopyWithImpl<_Bill>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bill&&(identical(other.id, id) || other.id == id)&&(identical(other.billNumber, billNumber) || other.billNumber == billNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.orderType, orderType) || other.orderType == orderType)&&const DeepCollectionEquality().equals(other._tableIds, _tableIds)&&const DeepCollectionEquality().equals(other._tableLabels, _tableLabels)&&(identical(other.reservationId, reservationId) || other.reservationId == reservationId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.guests, guests) || other.guests == guests)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.serviceChargeRate, serviceChargeRate) || other.serviceChargeRate == serviceChargeRate)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other._payments, _payments)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.openedById, openedById) || other.openedById == openedById)&&(identical(other.openedByName, openedByName) || other.openedByName == openedByName)&&(identical(other.closedById, closedById) || other.closedById == closedById)&&(identical(other.closedByName, closedByName) || other.closedByName == closedByName)&&(identical(other.voidReason, voidReason) || other.voidReason == voidReason)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,billNumber,status,orderType,const DeepCollectionEquality().hash(_tableIds),const DeepCollectionEquality().hash(_tableLabels),reservationId,customerId,customerName,customerPhone,guests,const DeepCollectionEquality().hash(_items),discountType,discountValue,taxRate,serviceChargeRate,totals,const DeepCollectionEquality().hash(_payments),notes,openedById,openedByName,closedById,closedByName,voidReason,closedAt,createdAt,updatedAt]);

@override
String toString() {
  return 'Bill(id: $id, billNumber: $billNumber, status: $status, orderType: $orderType, tableIds: $tableIds, tableLabels: $tableLabels, reservationId: $reservationId, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, guests: $guests, items: $items, discountType: $discountType, discountValue: $discountValue, taxRate: $taxRate, serviceChargeRate: $serviceChargeRate, totals: $totals, payments: $payments, notes: $notes, openedById: $openedById, openedByName: $openedByName, closedById: $closedById, closedByName: $closedByName, voidReason: $voidReason, closedAt: $closedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BillCopyWith<$Res> implements $BillCopyWith<$Res> {
  factory _$BillCopyWith(_Bill value, $Res Function(_Bill) _then) = __$BillCopyWithImpl;
@override @useResult
$Res call({
 String id, String billNumber, BillStatus status, OrderType orderType, List<String> tableIds, List<String> tableLabels, String? reservationId, String? customerId, String customerName, String customerPhone, int guests, List<BillItem> items, DiscountType discountType, double discountValue, double taxRate, double serviceChargeRate, BillTotals totals, List<Payment> payments, String notes, String openedById, String openedByName, String? closedById, String? closedByName, String voidReason, DateTime? closedAt, DateTime? createdAt, DateTime? updatedAt
});


@override $BillTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class __$BillCopyWithImpl<$Res>
    implements _$BillCopyWith<$Res> {
  __$BillCopyWithImpl(this._self, this._then);

  final _Bill _self;
  final $Res Function(_Bill) _then;

/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? billNumber = null,Object? status = null,Object? orderType = null,Object? tableIds = null,Object? tableLabels = null,Object? reservationId = freezed,Object? customerId = freezed,Object? customerName = null,Object? customerPhone = null,Object? guests = null,Object? items = null,Object? discountType = null,Object? discountValue = null,Object? taxRate = null,Object? serviceChargeRate = null,Object? totals = null,Object? payments = null,Object? notes = null,Object? openedById = null,Object? openedByName = null,Object? closedById = freezed,Object? closedByName = freezed,Object? voidReason = null,Object? closedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Bill(
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
as List<BillItem>,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,serviceChargeRate: null == serviceChargeRate ? _self.serviceChargeRate : serviceChargeRate // ignore: cast_nullable_to_non_nullable
as double,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as BillTotals,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<Payment>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
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

/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BillTotalsCopyWith<$Res> get totals {
  
  return $BillTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}

// dart format on
