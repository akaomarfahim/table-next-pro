// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns the device session: activation, PIN lock/unlock and sign-out.
///
/// Action methods throw [AppException]s for the UI to display; they never
/// put the provider into an error state (that would break routing).

@ProviderFor(SessionController)
const sessionControllerProvider = SessionControllerProvider._();

/// Owns the device session: activation, PIN lock/unlock and sign-out.
///
/// Action methods throw [AppException]s for the UI to display; they never
/// put the provider into an error state (that would break routing).
final class SessionControllerProvider
    extends $AsyncNotifierProvider<SessionController, SessionState> {
  /// Owns the device session: activation, PIN lock/unlock and sign-out.
  ///
  /// Action methods throw [AppException]s for the UI to display; they never
  /// put the provider into an error state (that would break routing).
  const SessionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionControllerHash();

  @$internal
  @override
  SessionController create() => SessionController();
}

String _$sessionControllerHash() => r'40ea1e93b9851ef7d0c33b85803b889e6891b996';

/// Owns the device session: activation, PIN lock/unlock and sign-out.
///
/// Action methods throw [AppException]s for the UI to display; they never
/// put the provider into an error state (that would break routing).

abstract class _$SessionController extends $AsyncNotifier<SessionState> {
  FutureOr<SessionState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<SessionState>, SessionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SessionState>, SessionState>,
              AsyncValue<SessionState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// The business this device is linked to (null before activation).

@ProviderFor(currentBusinessId)
const currentBusinessIdProvider = CurrentBusinessIdProvider._();

/// The business this device is linked to (null before activation).

final class CurrentBusinessIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// The business this device is linked to (null before activation).
  const CurrentBusinessIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentBusinessIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentBusinessIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return currentBusinessId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$currentBusinessIdHash() => r'926acbb16474d4e53fba95f694f9cd591c76f7c6';

/// Live business profile (settings changes from other devices apply
/// immediately). Falls back to the session copy while loading.

@ProviderFor(liveBusiness)
const liveBusinessProvider = LiveBusinessProvider._();

/// Live business profile (settings changes from other devices apply
/// immediately). Falls back to the session copy while loading.

final class LiveBusinessProvider
    extends
        $FunctionalProvider<AsyncValue<Business>, Business, Stream<Business>>
    with $FutureModifier<Business>, $StreamProvider<Business> {
  /// Live business profile (settings changes from other devices apply
  /// immediately). Falls back to the session copy while loading.
  const LiveBusinessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveBusinessProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveBusinessHash();

  @$internal
  @override
  $StreamProviderElement<Business> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Business> create(Ref ref) {
    return liveBusiness(ref);
  }
}

String _$liveBusinessHash() => r'4038a75538c0c261d1bea9b3bf293276ad6bd8e4';

@ProviderFor(currentBusiness)
const currentBusinessProvider = CurrentBusinessProvider._();

final class CurrentBusinessProvider
    extends $FunctionalProvider<Business?, Business?, Business?>
    with $Provider<Business?> {
  const CurrentBusinessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentBusinessProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentBusinessHash();

  @$internal
  @override
  $ProviderElement<Business?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Business? create(Ref ref) {
    return currentBusiness(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Business? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Business?>(value),
    );
  }
}

String _$currentBusinessHash() => r'70d6e8b3ab29883fb29310277f19efd30ad4e950';

/// Business id for data-layer providers. Only read while a business is
/// active (all operational screens are behind the session guard).

@ProviderFor(requireBusinessId)
const requireBusinessIdProvider = RequireBusinessIdProvider._();

/// Business id for data-layer providers. Only read while a business is
/// active (all operational screens are behind the session guard).

final class RequireBusinessIdProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Business id for data-layer providers. Only read while a business is
  /// active (all operational screens are behind the session guard).
  const RequireBusinessIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requireBusinessIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requireBusinessIdHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return requireBusinessId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$requireBusinessIdHash() => r'8ea9652a922e6926e72f623aa33eee6c26529dbd';

@ProviderFor(currentUser)
const currentUserProvider = CurrentUserProvider._();

final class CurrentUserProvider
    extends $FunctionalProvider<AppUser?, AppUser?, AppUser?>
    with $Provider<AppUser?> {
  const CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $ProviderElement<AppUser?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppUser? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppUser? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppUser?>(value),
    );
  }
}

String _$currentUserHash() => r'74c4ece316b7f1c029e7362c100864022efac3c2';

/// Convenience permission check.

@ProviderFor(hasPermission)
const hasPermissionProvider = HasPermissionFamily._();

/// Convenience permission check.

final class HasPermissionProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Convenience permission check.
  const HasPermissionProvider._({
    required HasPermissionFamily super.from,
    required Permission super.argument,
  }) : super(
         retry: null,
         name: r'hasPermissionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hasPermissionHash();

  @override
  String toString() {
    return r'hasPermissionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as Permission;
    return hasPermission(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HasPermissionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hasPermissionHash() => r'ed32966677d3a8b12a64eb1aa4a8a00177d32db2';

/// Convenience permission check.

final class HasPermissionFamily extends $Family
    with $FunctionalFamilyOverride<bool, Permission> {
  const HasPermissionFamily._()
    : super(
        retry: null,
        name: r'hasPermissionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Convenience permission check.

  HasPermissionProvider call(Permission permission) =>
      HasPermissionProvider._(argument: permission, from: this);

  @override
  String toString() => r'hasPermissionProvider';
}
