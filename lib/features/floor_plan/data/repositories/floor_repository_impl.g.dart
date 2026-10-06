// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(floorRepository)
const floorRepositoryProvider = FloorRepositoryProvider._();

final class FloorRepositoryProvider
    extends
        $FunctionalProvider<FloorRepository, FloorRepository, FloorRepository>
    with $Provider<FloorRepository> {
  const FloorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'floorRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$floorRepositoryHash();

  @$internal
  @override
  $ProviderElement<FloorRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FloorRepository create(Ref ref) {
    return floorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FloorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FloorRepository>(value),
    );
  }
}

String _$floorRepositoryHash() => r'47a606f45915ce4c84c271ada8cd35e7b2c9d358';
