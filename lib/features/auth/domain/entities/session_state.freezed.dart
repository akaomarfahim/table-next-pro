// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState()';
}


}

/// @nodoc
class $SessionStateCopyWith<$Res>  {
$SessionStateCopyWith(SessionState _, $Res Function(SessionState) __);
}


/// Adds pattern-matching-related methods to [SessionState].
extension SessionStatePatterns on SessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionNeedsActivation value)?  needsActivation,TResult Function( SessionLocked value)?  locked,TResult Function( SessionUnlocked value)?  unlocked,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionNeedsActivation() when needsActivation != null:
return needsActivation(_that);case SessionLocked() when locked != null:
return locked(_that);case SessionUnlocked() when unlocked != null:
return unlocked(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionNeedsActivation value)  needsActivation,required TResult Function( SessionLocked value)  locked,required TResult Function( SessionUnlocked value)  unlocked,}){
final _that = this;
switch (_that) {
case SessionNeedsActivation():
return needsActivation(_that);case SessionLocked():
return locked(_that);case SessionUnlocked():
return unlocked(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionNeedsActivation value)?  needsActivation,TResult? Function( SessionLocked value)?  locked,TResult? Function( SessionUnlocked value)?  unlocked,}){
final _that = this;
switch (_that) {
case SessionNeedsActivation() when needsActivation != null:
return needsActivation(_that);case SessionLocked() when locked != null:
return locked(_that);case SessionUnlocked() when unlocked != null:
return unlocked(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  needsActivation,TResult Function( Business business)?  locked,TResult Function( Business business,  AppUser user)?  unlocked,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionNeedsActivation() when needsActivation != null:
return needsActivation();case SessionLocked() when locked != null:
return locked(_that.business);case SessionUnlocked() when unlocked != null:
return unlocked(_that.business,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  needsActivation,required TResult Function( Business business)  locked,required TResult Function( Business business,  AppUser user)  unlocked,}) {final _that = this;
switch (_that) {
case SessionNeedsActivation():
return needsActivation();case SessionLocked():
return locked(_that.business);case SessionUnlocked():
return unlocked(_that.business,_that.user);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  needsActivation,TResult? Function( Business business)?  locked,TResult? Function( Business business,  AppUser user)?  unlocked,}) {final _that = this;
switch (_that) {
case SessionNeedsActivation() when needsActivation != null:
return needsActivation();case SessionLocked() when locked != null:
return locked(_that.business);case SessionUnlocked() when unlocked != null:
return unlocked(_that.business,_that.user);case _:
  return null;

}
}

}

/// @nodoc


class SessionNeedsActivation extends SessionState {
  const SessionNeedsActivation(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionNeedsActivation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState.needsActivation()';
}


}




/// @nodoc


class SessionLocked extends SessionState {
  const SessionLocked({required this.business}): super._();
  

 final  Business business;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionLockedCopyWith<SessionLocked> get copyWith => _$SessionLockedCopyWithImpl<SessionLocked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionLocked&&(identical(other.business, business) || other.business == business));
}


@override
int get hashCode => Object.hash(runtimeType,business);

@override
String toString() {
  return 'SessionState.locked(business: $business)';
}


}

/// @nodoc
abstract mixin class $SessionLockedCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory $SessionLockedCopyWith(SessionLocked value, $Res Function(SessionLocked) _then) = _$SessionLockedCopyWithImpl;
@useResult
$Res call({
 Business business
});


$BusinessCopyWith<$Res> get business;

}
/// @nodoc
class _$SessionLockedCopyWithImpl<$Res>
    implements $SessionLockedCopyWith<$Res> {
  _$SessionLockedCopyWithImpl(this._self, this._then);

  final SessionLocked _self;
  final $Res Function(SessionLocked) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? business = null,}) {
  return _then(SessionLocked(
business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as Business,
  ));
}

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessCopyWith<$Res> get business {
  
  return $BusinessCopyWith<$Res>(_self.business, (value) {
    return _then(_self.copyWith(business: value));
  });
}
}

/// @nodoc


class SessionUnlocked extends SessionState {
  const SessionUnlocked({required this.business, required this.user}): super._();
  

 final  Business business;
 final  AppUser user;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionUnlockedCopyWith<SessionUnlocked> get copyWith => _$SessionUnlockedCopyWithImpl<SessionUnlocked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionUnlocked&&(identical(other.business, business) || other.business == business)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,business,user);

@override
String toString() {
  return 'SessionState.unlocked(business: $business, user: $user)';
}


}

/// @nodoc
abstract mixin class $SessionUnlockedCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory $SessionUnlockedCopyWith(SessionUnlocked value, $Res Function(SessionUnlocked) _then) = _$SessionUnlockedCopyWithImpl;
@useResult
$Res call({
 Business business, AppUser user
});


$BusinessCopyWith<$Res> get business;$AppUserCopyWith<$Res> get user;

}
/// @nodoc
class _$SessionUnlockedCopyWithImpl<$Res>
    implements $SessionUnlockedCopyWith<$Res> {
  _$SessionUnlockedCopyWithImpl(this._self, this._then);

  final SessionUnlocked _self;
  final $Res Function(SessionUnlocked) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? business = null,Object? user = null,}) {
  return _then(SessionUnlocked(
business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as Business,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser,
  ));
}

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessCopyWith<$Res> get business {
  
  return $BusinessCopyWith<$Res>(_self.business, (value) {
    return _then(_self.copyWith(business: value));
  });
}/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res> get user {
  
  return $AppUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc
mixin _$DeviceActivation {

 String get businessId; String get activatedByUserId; DateTime get activatedAt;
/// Create a copy of DeviceActivation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceActivationCopyWith<DeviceActivation> get copyWith => _$DeviceActivationCopyWithImpl<DeviceActivation>(this as DeviceActivation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceActivation&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.activatedByUserId, activatedByUserId) || other.activatedByUserId == activatedByUserId)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,businessId,activatedByUserId,activatedAt);

@override
String toString() {
  return 'DeviceActivation(businessId: $businessId, activatedByUserId: $activatedByUserId, activatedAt: $activatedAt)';
}


}

/// @nodoc
abstract mixin class $DeviceActivationCopyWith<$Res>  {
  factory $DeviceActivationCopyWith(DeviceActivation value, $Res Function(DeviceActivation) _then) = _$DeviceActivationCopyWithImpl;
@useResult
$Res call({
 String businessId, String activatedByUserId, DateTime activatedAt
});




}
/// @nodoc
class _$DeviceActivationCopyWithImpl<$Res>
    implements $DeviceActivationCopyWith<$Res> {
  _$DeviceActivationCopyWithImpl(this._self, this._then);

  final DeviceActivation _self;
  final $Res Function(DeviceActivation) _then;

/// Create a copy of DeviceActivation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? businessId = null,Object? activatedByUserId = null,Object? activatedAt = null,}) {
  return _then(_self.copyWith(
businessId: null == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String,activatedByUserId: null == activatedByUserId ? _self.activatedByUserId : activatedByUserId // ignore: cast_nullable_to_non_nullable
as String,activatedAt: null == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceActivation].
extension DeviceActivationPatterns on DeviceActivation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceActivation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceActivation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceActivation value)  $default,){
final _that = this;
switch (_that) {
case _DeviceActivation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceActivation value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceActivation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String businessId,  String activatedByUserId,  DateTime activatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceActivation() when $default != null:
return $default(_that.businessId,_that.activatedByUserId,_that.activatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String businessId,  String activatedByUserId,  DateTime activatedAt)  $default,) {final _that = this;
switch (_that) {
case _DeviceActivation():
return $default(_that.businessId,_that.activatedByUserId,_that.activatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String businessId,  String activatedByUserId,  DateTime activatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DeviceActivation() when $default != null:
return $default(_that.businessId,_that.activatedByUserId,_that.activatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _DeviceActivation implements DeviceActivation {
  const _DeviceActivation({required this.businessId, required this.activatedByUserId, required this.activatedAt});
  

@override final  String businessId;
@override final  String activatedByUserId;
@override final  DateTime activatedAt;

/// Create a copy of DeviceActivation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceActivationCopyWith<_DeviceActivation> get copyWith => __$DeviceActivationCopyWithImpl<_DeviceActivation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceActivation&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.activatedByUserId, activatedByUserId) || other.activatedByUserId == activatedByUserId)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,businessId,activatedByUserId,activatedAt);

@override
String toString() {
  return 'DeviceActivation(businessId: $businessId, activatedByUserId: $activatedByUserId, activatedAt: $activatedAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceActivationCopyWith<$Res> implements $DeviceActivationCopyWith<$Res> {
  factory _$DeviceActivationCopyWith(_DeviceActivation value, $Res Function(_DeviceActivation) _then) = __$DeviceActivationCopyWithImpl;
@override @useResult
$Res call({
 String businessId, String activatedByUserId, DateTime activatedAt
});




}
/// @nodoc
class __$DeviceActivationCopyWithImpl<$Res>
    implements _$DeviceActivationCopyWith<$Res> {
  __$DeviceActivationCopyWithImpl(this._self, this._then);

  final _DeviceActivation _self;
  final $Res Function(_DeviceActivation) _then;

/// Create a copy of DeviceActivation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? businessId = null,Object? activatedByUserId = null,Object? activatedAt = null,}) {
  return _then(_DeviceActivation(
businessId: null == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String,activatedByUserId: null == activatedByUserId ? _self.activatedByUserId : activatedByUserId // ignore: cast_nullable_to_non_nullable
as String,activatedAt: null == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
