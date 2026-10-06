// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(floors)
const floorsProvider = FloorsProvider._();

final class FloorsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FloorArea>>,
          List<FloorArea>,
          Stream<List<FloorArea>>
        >
    with $FutureModifier<List<FloorArea>>, $StreamProvider<List<FloorArea>> {
  const FloorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'floorsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$floorsHash();

  @$internal
  @override
  $StreamProviderElement<List<FloorArea>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<FloorArea>> create(Ref ref) {
    return floors(ref);
  }
}

String _$floorsHash() => r'ea864c0e1902deb8e937215788aad9f6fc14d7fa';

@ProviderFor(floorElements)
const floorElementsProvider = FloorElementsProvider._();

final class FloorElementsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FloorElement>>,
          List<FloorElement>,
          Stream<List<FloorElement>>
        >
    with
        $FutureModifier<List<FloorElement>>,
        $StreamProvider<List<FloorElement>> {
  const FloorElementsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'floorElementsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$floorElementsHash();

  @$internal
  @override
  $StreamProviderElement<List<FloorElement>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<FloorElement>> create(Ref ref) {
    return floorElements(ref);
  }
}

String _$floorElementsHash() => r'529b278faaf40ed8541a7dce3eb2c46d2c209b6f';

/// All tables across floors, sorted naturally by label (T1, T2, T10).

@ProviderFor(allTables)
const allTablesProvider = AllTablesProvider._();

/// All tables across floors, sorted naturally by label (T1, T2, T10).

final class AllTablesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FloorElement>>,
          AsyncValue<List<FloorElement>>,
          AsyncValue<List<FloorElement>>
        >
    with $Provider<AsyncValue<List<FloorElement>>> {
  /// All tables across floors, sorted naturally by label (T1, T2, T10).
  const AllTablesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allTablesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allTablesHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<FloorElement>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<FloorElement>> create(Ref ref) {
    return allTables(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<FloorElement>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<FloorElement>>>(
        value,
      ),
    );
  }
}

String _$allTablesHash() => r'2e198db7e528d81ba9a9fb2478d7eb204398ab44';

/// Currently selected floor tab (remembered on this device).

@ProviderFor(SelectedFloorId)
const selectedFloorIdProvider = SelectedFloorIdProvider._();

/// Currently selected floor tab (remembered on this device).
final class SelectedFloorIdProvider
    extends $NotifierProvider<SelectedFloorId, String?> {
  /// Currently selected floor tab (remembered on this device).
  const SelectedFloorIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedFloorIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedFloorIdHash();

  @$internal
  @override
  SelectedFloorId create() => SelectedFloorId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedFloorIdHash() => r'5501035693dc0b24b7889eb10de79029309c5d5d';

/// Currently selected floor tab (remembered on this device).

abstract class _$SelectedFloorId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Resolves the selected floor, falling back to the first one.

@ProviderFor(activeFloor)
const activeFloorProvider = ActiveFloorProvider._();

/// Resolves the selected floor, falling back to the first one.

final class ActiveFloorProvider
    extends $FunctionalProvider<FloorArea?, FloorArea?, FloorArea?>
    with $Provider<FloorArea?> {
  /// Resolves the selected floor, falling back to the first one.
  const ActiveFloorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeFloorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeFloorHash();

  @$internal
  @override
  $ProviderElement<FloorArea?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FloorArea? create(Ref ref) {
    return activeFloor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FloorArea? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FloorArea?>(value),
    );
  }
}

String _$activeFloorHash() => r'412db0cfc136238ef191aca13075841ade9759ae';
