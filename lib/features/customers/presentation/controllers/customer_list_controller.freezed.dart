// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_list_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerListState {

 List<Customer> get items; Object? get cursor; bool get hasMore; bool get isLoadingMore; String get query;
/// Create a copy of CustomerListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerListStateCopyWith<CustomerListState> get copyWith => _$CustomerListStateCopyWithImpl<CustomerListState>(this as CustomerListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerListState&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.cursor, cursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(cursor),hasMore,isLoadingMore,query);

@override
String toString() {
  return 'CustomerListState(items: $items, cursor: $cursor, hasMore: $hasMore, isLoadingMore: $isLoadingMore, query: $query)';
}


}

/// @nodoc
abstract mixin class $CustomerListStateCopyWith<$Res>  {
  factory $CustomerListStateCopyWith(CustomerListState value, $Res Function(CustomerListState) _then) = _$CustomerListStateCopyWithImpl;
@useResult
$Res call({
 List<Customer> items, Object? cursor, bool hasMore, bool isLoadingMore, String query
});




}
/// @nodoc
class _$CustomerListStateCopyWithImpl<$Res>
    implements $CustomerListStateCopyWith<$Res> {
  _$CustomerListStateCopyWithImpl(this._self, this._then);

  final CustomerListState _self;
  final $Res Function(CustomerListState) _then;

/// Create a copy of CustomerListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? cursor = freezed,Object? hasMore = null,Object? isLoadingMore = null,Object? query = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Customer>,cursor: freezed == cursor ? _self.cursor : cursor ,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerListState].
extension CustomerListStatePatterns on CustomerListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerListState value)  $default,){
final _that = this;
switch (_that) {
case _CustomerListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerListState value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Customer> items,  Object? cursor,  bool hasMore,  bool isLoadingMore,  String query)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerListState() when $default != null:
return $default(_that.items,_that.cursor,_that.hasMore,_that.isLoadingMore,_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Customer> items,  Object? cursor,  bool hasMore,  bool isLoadingMore,  String query)  $default,) {final _that = this;
switch (_that) {
case _CustomerListState():
return $default(_that.items,_that.cursor,_that.hasMore,_that.isLoadingMore,_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Customer> items,  Object? cursor,  bool hasMore,  bool isLoadingMore,  String query)?  $default,) {final _that = this;
switch (_that) {
case _CustomerListState() when $default != null:
return $default(_that.items,_that.cursor,_that.hasMore,_that.isLoadingMore,_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerListState implements CustomerListState {
  const _CustomerListState({final  List<Customer> items = const <Customer>[], this.cursor, this.hasMore = false, this.isLoadingMore = false, this.query = ''}): _items = items;
  

 final  List<Customer> _items;
@override@JsonKey() List<Customer> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  Object? cursor;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  String query;

/// Create a copy of CustomerListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerListStateCopyWith<_CustomerListState> get copyWith => __$CustomerListStateCopyWithImpl<_CustomerListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerListState&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other.cursor, cursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(cursor),hasMore,isLoadingMore,query);

@override
String toString() {
  return 'CustomerListState(items: $items, cursor: $cursor, hasMore: $hasMore, isLoadingMore: $isLoadingMore, query: $query)';
}


}

/// @nodoc
abstract mixin class _$CustomerListStateCopyWith<$Res> implements $CustomerListStateCopyWith<$Res> {
  factory _$CustomerListStateCopyWith(_CustomerListState value, $Res Function(_CustomerListState) _then) = __$CustomerListStateCopyWithImpl;
@override @useResult
$Res call({
 List<Customer> items, Object? cursor, bool hasMore, bool isLoadingMore, String query
});




}
/// @nodoc
class __$CustomerListStateCopyWithImpl<$Res>
    implements _$CustomerListStateCopyWith<$Res> {
  __$CustomerListStateCopyWithImpl(this._self, this._then);

  final _CustomerListState _self;
  final $Res Function(_CustomerListState) _then;

/// Create a copy of CustomerListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? cursor = freezed,Object? hasMore = null,Object? isLoadingMore = null,Object? query = null,}) {
  return _then(_CustomerListState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Customer>,cursor: freezed == cursor ? _self.cursor : cursor ,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
