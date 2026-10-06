// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyStats {

 DateTime get date; double get revenue; int get bills; int get guests; double get discounts; double get tax; int get reservations; int get reservationCovers; int get cancellations; int get noShows; int get voids; double get payCash; double get payCard; double get payMobile; double get payOther;
/// Create a copy of DailyStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyStatsCopyWith<DailyStats> get copyWith => _$DailyStatsCopyWithImpl<DailyStats>(this as DailyStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyStats&&(identical(other.date, date) || other.date == date)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.bills, bills) || other.bills == bills)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.discounts, discounts) || other.discounts == discounts)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.reservations, reservations) || other.reservations == reservations)&&(identical(other.reservationCovers, reservationCovers) || other.reservationCovers == reservationCovers)&&(identical(other.cancellations, cancellations) || other.cancellations == cancellations)&&(identical(other.noShows, noShows) || other.noShows == noShows)&&(identical(other.voids, voids) || other.voids == voids)&&(identical(other.payCash, payCash) || other.payCash == payCash)&&(identical(other.payCard, payCard) || other.payCard == payCard)&&(identical(other.payMobile, payMobile) || other.payMobile == payMobile)&&(identical(other.payOther, payOther) || other.payOther == payOther));
}


@override
int get hashCode => Object.hash(runtimeType,date,revenue,bills,guests,discounts,tax,reservations,reservationCovers,cancellations,noShows,voids,payCash,payCard,payMobile,payOther);

@override
String toString() {
  return 'DailyStats(date: $date, revenue: $revenue, bills: $bills, guests: $guests, discounts: $discounts, tax: $tax, reservations: $reservations, reservationCovers: $reservationCovers, cancellations: $cancellations, noShows: $noShows, voids: $voids, payCash: $payCash, payCard: $payCard, payMobile: $payMobile, payOther: $payOther)';
}


}

/// @nodoc
abstract mixin class $DailyStatsCopyWith<$Res>  {
  factory $DailyStatsCopyWith(DailyStats value, $Res Function(DailyStats) _then) = _$DailyStatsCopyWithImpl;
@useResult
$Res call({
 DateTime date, double revenue, int bills, int guests, double discounts, double tax, int reservations, int reservationCovers, int cancellations, int noShows, int voids, double payCash, double payCard, double payMobile, double payOther
});




}
/// @nodoc
class _$DailyStatsCopyWithImpl<$Res>
    implements $DailyStatsCopyWith<$Res> {
  _$DailyStatsCopyWithImpl(this._self, this._then);

  final DailyStats _self;
  final $Res Function(DailyStats) _then;

/// Create a copy of DailyStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? revenue = null,Object? bills = null,Object? guests = null,Object? discounts = null,Object? tax = null,Object? reservations = null,Object? reservationCovers = null,Object? cancellations = null,Object? noShows = null,Object? voids = null,Object? payCash = null,Object? payCard = null,Object? payMobile = null,Object? payOther = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,bills: null == bills ? _self.bills : bills // ignore: cast_nullable_to_non_nullable
as int,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as int,discounts: null == discounts ? _self.discounts : discounts // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,reservations: null == reservations ? _self.reservations : reservations // ignore: cast_nullable_to_non_nullable
as int,reservationCovers: null == reservationCovers ? _self.reservationCovers : reservationCovers // ignore: cast_nullable_to_non_nullable
as int,cancellations: null == cancellations ? _self.cancellations : cancellations // ignore: cast_nullable_to_non_nullable
as int,noShows: null == noShows ? _self.noShows : noShows // ignore: cast_nullable_to_non_nullable
as int,voids: null == voids ? _self.voids : voids // ignore: cast_nullable_to_non_nullable
as int,payCash: null == payCash ? _self.payCash : payCash // ignore: cast_nullable_to_non_nullable
as double,payCard: null == payCard ? _self.payCard : payCard // ignore: cast_nullable_to_non_nullable
as double,payMobile: null == payMobile ? _self.payMobile : payMobile // ignore: cast_nullable_to_non_nullable
as double,payOther: null == payOther ? _self.payOther : payOther // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyStats].
extension DailyStatsPatterns on DailyStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyStats value)  $default,){
final _that = this;
switch (_that) {
case _DailyStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyStats value)?  $default,){
final _that = this;
switch (_that) {
case _DailyStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double revenue,  int bills,  int guests,  double discounts,  double tax,  int reservations,  int reservationCovers,  int cancellations,  int noShows,  int voids,  double payCash,  double payCard,  double payMobile,  double payOther)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyStats() when $default != null:
return $default(_that.date,_that.revenue,_that.bills,_that.guests,_that.discounts,_that.tax,_that.reservations,_that.reservationCovers,_that.cancellations,_that.noShows,_that.voids,_that.payCash,_that.payCard,_that.payMobile,_that.payOther);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double revenue,  int bills,  int guests,  double discounts,  double tax,  int reservations,  int reservationCovers,  int cancellations,  int noShows,  int voids,  double payCash,  double payCard,  double payMobile,  double payOther)  $default,) {final _that = this;
switch (_that) {
case _DailyStats():
return $default(_that.date,_that.revenue,_that.bills,_that.guests,_that.discounts,_that.tax,_that.reservations,_that.reservationCovers,_that.cancellations,_that.noShows,_that.voids,_that.payCash,_that.payCard,_that.payMobile,_that.payOther);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double revenue,  int bills,  int guests,  double discounts,  double tax,  int reservations,  int reservationCovers,  int cancellations,  int noShows,  int voids,  double payCash,  double payCard,  double payMobile,  double payOther)?  $default,) {final _that = this;
switch (_that) {
case _DailyStats() when $default != null:
return $default(_that.date,_that.revenue,_that.bills,_that.guests,_that.discounts,_that.tax,_that.reservations,_that.reservationCovers,_that.cancellations,_that.noShows,_that.voids,_that.payCash,_that.payCard,_that.payMobile,_that.payOther);case _:
  return null;

}
}

}

/// @nodoc


class _DailyStats extends DailyStats {
  const _DailyStats({required this.date, this.revenue = 0.0, this.bills = 0, this.guests = 0, this.discounts = 0.0, this.tax = 0.0, this.reservations = 0, this.reservationCovers = 0, this.cancellations = 0, this.noShows = 0, this.voids = 0, this.payCash = 0.0, this.payCard = 0.0, this.payMobile = 0.0, this.payOther = 0.0}): super._();
  

@override final  DateTime date;
@override@JsonKey() final  double revenue;
@override@JsonKey() final  int bills;
@override@JsonKey() final  int guests;
@override@JsonKey() final  double discounts;
@override@JsonKey() final  double tax;
@override@JsonKey() final  int reservations;
@override@JsonKey() final  int reservationCovers;
@override@JsonKey() final  int cancellations;
@override@JsonKey() final  int noShows;
@override@JsonKey() final  int voids;
@override@JsonKey() final  double payCash;
@override@JsonKey() final  double payCard;
@override@JsonKey() final  double payMobile;
@override@JsonKey() final  double payOther;

/// Create a copy of DailyStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyStatsCopyWith<_DailyStats> get copyWith => __$DailyStatsCopyWithImpl<_DailyStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyStats&&(identical(other.date, date) || other.date == date)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.bills, bills) || other.bills == bills)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.discounts, discounts) || other.discounts == discounts)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.reservations, reservations) || other.reservations == reservations)&&(identical(other.reservationCovers, reservationCovers) || other.reservationCovers == reservationCovers)&&(identical(other.cancellations, cancellations) || other.cancellations == cancellations)&&(identical(other.noShows, noShows) || other.noShows == noShows)&&(identical(other.voids, voids) || other.voids == voids)&&(identical(other.payCash, payCash) || other.payCash == payCash)&&(identical(other.payCard, payCard) || other.payCard == payCard)&&(identical(other.payMobile, payMobile) || other.payMobile == payMobile)&&(identical(other.payOther, payOther) || other.payOther == payOther));
}


@override
int get hashCode => Object.hash(runtimeType,date,revenue,bills,guests,discounts,tax,reservations,reservationCovers,cancellations,noShows,voids,payCash,payCard,payMobile,payOther);

@override
String toString() {
  return 'DailyStats(date: $date, revenue: $revenue, bills: $bills, guests: $guests, discounts: $discounts, tax: $tax, reservations: $reservations, reservationCovers: $reservationCovers, cancellations: $cancellations, noShows: $noShows, voids: $voids, payCash: $payCash, payCard: $payCard, payMobile: $payMobile, payOther: $payOther)';
}


}

/// @nodoc
abstract mixin class _$DailyStatsCopyWith<$Res> implements $DailyStatsCopyWith<$Res> {
  factory _$DailyStatsCopyWith(_DailyStats value, $Res Function(_DailyStats) _then) = __$DailyStatsCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double revenue, int bills, int guests, double discounts, double tax, int reservations, int reservationCovers, int cancellations, int noShows, int voids, double payCash, double payCard, double payMobile, double payOther
});




}
/// @nodoc
class __$DailyStatsCopyWithImpl<$Res>
    implements _$DailyStatsCopyWith<$Res> {
  __$DailyStatsCopyWithImpl(this._self, this._then);

  final _DailyStats _self;
  final $Res Function(_DailyStats) _then;

/// Create a copy of DailyStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? revenue = null,Object? bills = null,Object? guests = null,Object? discounts = null,Object? tax = null,Object? reservations = null,Object? reservationCovers = null,Object? cancellations = null,Object? noShows = null,Object? voids = null,Object? payCash = null,Object? payCard = null,Object? payMobile = null,Object? payOther = null,}) {
  return _then(_DailyStats(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,bills: null == bills ? _self.bills : bills // ignore: cast_nullable_to_non_nullable
as int,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as int,discounts: null == discounts ? _self.discounts : discounts // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,reservations: null == reservations ? _self.reservations : reservations // ignore: cast_nullable_to_non_nullable
as int,reservationCovers: null == reservationCovers ? _self.reservationCovers : reservationCovers // ignore: cast_nullable_to_non_nullable
as int,cancellations: null == cancellations ? _self.cancellations : cancellations // ignore: cast_nullable_to_non_nullable
as int,noShows: null == noShows ? _self.noShows : noShows // ignore: cast_nullable_to_non_nullable
as int,voids: null == voids ? _self.voids : voids // ignore: cast_nullable_to_non_nullable
as int,payCash: null == payCash ? _self.payCash : payCash // ignore: cast_nullable_to_non_nullable
as double,payCard: null == payCard ? _self.payCard : payCard // ignore: cast_nullable_to_non_nullable
as double,payMobile: null == payMobile ? _self.payMobile : payMobile // ignore: cast_nullable_to_non_nullable
as double,payOther: null == payOther ? _self.payOther : payOther // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
