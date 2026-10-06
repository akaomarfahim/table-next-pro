// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Emits `true` while the device has a network interface available.
///
/// Firestore keeps working offline (reads from cache, queues writes), so
/// this is used only to inform the user via the offline banner.

@ProviderFor(isOnline)
const isOnlineProvider = IsOnlineProvider._();

/// Emits `true` while the device has a network interface available.
///
/// Firestore keeps working offline (reads from cache, queues writes), so
/// this is used only to inform the user via the offline banner.

final class IsOnlineProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  /// Emits `true` while the device has a network interface available.
  ///
  /// Firestore keeps working offline (reads from cache, queues writes), so
  /// this is used only to inform the user via the offline banner.
  const IsOnlineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isOnlineProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isOnlineHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return isOnline(ref);
  }
}

String _$isOnlineHash() => r'bd3c8e36471681c69e5b784871f69b4d78dad7b5';
