// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Inactivity auto-lock timeout (minutes, 0 = never) for this device.

@ProviderFor(AutoLockMinutes)
const autoLockMinutesProvider = AutoLockMinutesProvider._();

/// Inactivity auto-lock timeout (minutes, 0 = never) for this device.
final class AutoLockMinutesProvider
    extends $NotifierProvider<AutoLockMinutes, int> {
  /// Inactivity auto-lock timeout (minutes, 0 = never) for this device.
  const AutoLockMinutesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autoLockMinutesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$autoLockMinutesHash();

  @$internal
  @override
  AutoLockMinutes create() => AutoLockMinutes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$autoLockMinutesHash() => r'104a9c1305051edb80e849e91632738f957b881e';

/// Inactivity auto-lock timeout (minutes, 0 = never) for this device.

abstract class _$AutoLockMinutes extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Whether floor-plan elements snap to the grid while dragging.

@ProviderFor(SnapToGrid)
const snapToGridProvider = SnapToGridProvider._();

/// Whether floor-plan elements snap to the grid while dragging.
final class SnapToGridProvider extends $NotifierProvider<SnapToGrid, bool> {
  /// Whether floor-plan elements snap to the grid while dragging.
  const SnapToGridProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'snapToGridProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$snapToGridHash();

  @$internal
  @override
  SnapToGrid create() => SnapToGrid();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$snapToGridHash() => r'bf8da7f2fcdba4de3cd49d3cb2b9e5a226523580';

/// Whether floor-plan elements snap to the grid while dragging.

abstract class _$SnapToGrid extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
