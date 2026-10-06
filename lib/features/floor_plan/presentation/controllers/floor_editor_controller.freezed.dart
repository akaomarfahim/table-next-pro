// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor_editor_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FloorEditorState {

 FloorArea? get floor; List<FloorElement> get elements; String? get selectedId; Set<String> get deletedIds;/// Ids that exist in Firestore (deleting them must be persisted).
 Set<String> get persistedIds; bool get dirty; bool get saving; List<List<FloorElement>> get undoStack;
/// Create a copy of FloorEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FloorEditorStateCopyWith<FloorEditorState> get copyWith => _$FloorEditorStateCopyWithImpl<FloorEditorState>(this as FloorEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FloorEditorState&&(identical(other.floor, floor) || other.floor == floor)&&const DeepCollectionEquality().equals(other.elements, elements)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId)&&const DeepCollectionEquality().equals(other.deletedIds, deletedIds)&&const DeepCollectionEquality().equals(other.persistedIds, persistedIds)&&(identical(other.dirty, dirty) || other.dirty == dirty)&&(identical(other.saving, saving) || other.saving == saving)&&const DeepCollectionEquality().equals(other.undoStack, undoStack));
}


@override
int get hashCode => Object.hash(runtimeType,floor,const DeepCollectionEquality().hash(elements),selectedId,const DeepCollectionEquality().hash(deletedIds),const DeepCollectionEquality().hash(persistedIds),dirty,saving,const DeepCollectionEquality().hash(undoStack));

@override
String toString() {
  return 'FloorEditorState(floor: $floor, elements: $elements, selectedId: $selectedId, deletedIds: $deletedIds, persistedIds: $persistedIds, dirty: $dirty, saving: $saving, undoStack: $undoStack)';
}


}

/// @nodoc
abstract mixin class $FloorEditorStateCopyWith<$Res>  {
  factory $FloorEditorStateCopyWith(FloorEditorState value, $Res Function(FloorEditorState) _then) = _$FloorEditorStateCopyWithImpl;
@useResult
$Res call({
 FloorArea? floor, List<FloorElement> elements, String? selectedId, Set<String> deletedIds, Set<String> persistedIds, bool dirty, bool saving, List<List<FloorElement>> undoStack
});


$FloorAreaCopyWith<$Res>? get floor;

}
/// @nodoc
class _$FloorEditorStateCopyWithImpl<$Res>
    implements $FloorEditorStateCopyWith<$Res> {
  _$FloorEditorStateCopyWithImpl(this._self, this._then);

  final FloorEditorState _self;
  final $Res Function(FloorEditorState) _then;

/// Create a copy of FloorEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? floor = freezed,Object? elements = null,Object? selectedId = freezed,Object? deletedIds = null,Object? persistedIds = null,Object? dirty = null,Object? saving = null,Object? undoStack = null,}) {
  return _then(_self.copyWith(
floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as FloorArea?,elements: null == elements ? _self.elements : elements // ignore: cast_nullable_to_non_nullable
as List<FloorElement>,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,deletedIds: null == deletedIds ? _self.deletedIds : deletedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,persistedIds: null == persistedIds ? _self.persistedIds : persistedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,dirty: null == dirty ? _self.dirty : dirty // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,undoStack: null == undoStack ? _self.undoStack : undoStack // ignore: cast_nullable_to_non_nullable
as List<List<FloorElement>>,
  ));
}
/// Create a copy of FloorEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FloorAreaCopyWith<$Res>? get floor {
    if (_self.floor == null) {
    return null;
  }

  return $FloorAreaCopyWith<$Res>(_self.floor!, (value) {
    return _then(_self.copyWith(floor: value));
  });
}
}


/// Adds pattern-matching-related methods to [FloorEditorState].
extension FloorEditorStatePatterns on FloorEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FloorEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FloorEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FloorEditorState value)  $default,){
final _that = this;
switch (_that) {
case _FloorEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FloorEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _FloorEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FloorArea? floor,  List<FloorElement> elements,  String? selectedId,  Set<String> deletedIds,  Set<String> persistedIds,  bool dirty,  bool saving,  List<List<FloorElement>> undoStack)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FloorEditorState() when $default != null:
return $default(_that.floor,_that.elements,_that.selectedId,_that.deletedIds,_that.persistedIds,_that.dirty,_that.saving,_that.undoStack);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FloorArea? floor,  List<FloorElement> elements,  String? selectedId,  Set<String> deletedIds,  Set<String> persistedIds,  bool dirty,  bool saving,  List<List<FloorElement>> undoStack)  $default,) {final _that = this;
switch (_that) {
case _FloorEditorState():
return $default(_that.floor,_that.elements,_that.selectedId,_that.deletedIds,_that.persistedIds,_that.dirty,_that.saving,_that.undoStack);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FloorArea? floor,  List<FloorElement> elements,  String? selectedId,  Set<String> deletedIds,  Set<String> persistedIds,  bool dirty,  bool saving,  List<List<FloorElement>> undoStack)?  $default,) {final _that = this;
switch (_that) {
case _FloorEditorState() when $default != null:
return $default(_that.floor,_that.elements,_that.selectedId,_that.deletedIds,_that.persistedIds,_that.dirty,_that.saving,_that.undoStack);case _:
  return null;

}
}

}

/// @nodoc


class _FloorEditorState extends FloorEditorState {
  const _FloorEditorState({this.floor, this.elements = const <FloorElement>[], this.selectedId, this.deletedIds = const <String>{}, this.persistedIds = const <String>{}, this.dirty = false, this.saving = false, this.undoStack = const <List<FloorElement>>[]}): super._();
  

@override final  FloorArea? floor;
@override@JsonKey() final  List<FloorElement> elements;
@override final  String? selectedId;
@override@JsonKey() final  Set<String> deletedIds;
/// Ids that exist in Firestore (deleting them must be persisted).
@override@JsonKey() final  Set<String> persistedIds;
@override@JsonKey() final  bool dirty;
@override@JsonKey() final  bool saving;
@override@JsonKey() final  List<List<FloorElement>> undoStack;

/// Create a copy of FloorEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FloorEditorStateCopyWith<_FloorEditorState> get copyWith => __$FloorEditorStateCopyWithImpl<_FloorEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FloorEditorState&&(identical(other.floor, floor) || other.floor == floor)&&const DeepCollectionEquality().equals(other.elements, elements)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId)&&const DeepCollectionEquality().equals(other.deletedIds, deletedIds)&&const DeepCollectionEquality().equals(other.persistedIds, persistedIds)&&(identical(other.dirty, dirty) || other.dirty == dirty)&&(identical(other.saving, saving) || other.saving == saving)&&const DeepCollectionEquality().equals(other.undoStack, undoStack));
}


@override
int get hashCode => Object.hash(runtimeType,floor,const DeepCollectionEquality().hash(elements),selectedId,const DeepCollectionEquality().hash(deletedIds),const DeepCollectionEquality().hash(persistedIds),dirty,saving,const DeepCollectionEquality().hash(undoStack));

@override
String toString() {
  return 'FloorEditorState(floor: $floor, elements: $elements, selectedId: $selectedId, deletedIds: $deletedIds, persistedIds: $persistedIds, dirty: $dirty, saving: $saving, undoStack: $undoStack)';
}


}

/// @nodoc
abstract mixin class _$FloorEditorStateCopyWith<$Res> implements $FloorEditorStateCopyWith<$Res> {
  factory _$FloorEditorStateCopyWith(_FloorEditorState value, $Res Function(_FloorEditorState) _then) = __$FloorEditorStateCopyWithImpl;
@override @useResult
$Res call({
 FloorArea? floor, List<FloorElement> elements, String? selectedId, Set<String> deletedIds, Set<String> persistedIds, bool dirty, bool saving, List<List<FloorElement>> undoStack
});


@override $FloorAreaCopyWith<$Res>? get floor;

}
/// @nodoc
class __$FloorEditorStateCopyWithImpl<$Res>
    implements _$FloorEditorStateCopyWith<$Res> {
  __$FloorEditorStateCopyWithImpl(this._self, this._then);

  final _FloorEditorState _self;
  final $Res Function(_FloorEditorState) _then;

/// Create a copy of FloorEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? floor = freezed,Object? elements = null,Object? selectedId = freezed,Object? deletedIds = null,Object? persistedIds = null,Object? dirty = null,Object? saving = null,Object? undoStack = null,}) {
  return _then(_FloorEditorState(
floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as FloorArea?,elements: null == elements ? _self.elements : elements // ignore: cast_nullable_to_non_nullable
as List<FloorElement>,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,deletedIds: null == deletedIds ? _self.deletedIds : deletedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,persistedIds: null == persistedIds ? _self.persistedIds : persistedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,dirty: null == dirty ? _self.dirty : dirty // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,undoStack: null == undoStack ? _self.undoStack : undoStack // ignore: cast_nullable_to_non_nullable
as List<List<FloorElement>>,
  ));
}

/// Create a copy of FloorEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FloorAreaCopyWith<$Res>? get floor {
    if (_self.floor == null) {
    return null;
  }

  return $FloorAreaCopyWith<$Res>(_self.floor!, (value) {
    return _then(_self.copyWith(floor: value));
  });
}
}

// dart format on
