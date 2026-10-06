// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_editor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Draft state of the floor plan editor. Nothing is written to Firestore
/// until [save] is called, so staff can experiment freely.

@ProviderFor(FloorEditorController)
const floorEditorControllerProvider = FloorEditorControllerProvider._();

/// Draft state of the floor plan editor. Nothing is written to Firestore
/// until [save] is called, so staff can experiment freely.
final class FloorEditorControllerProvider
    extends $NotifierProvider<FloorEditorController, FloorEditorState> {
  /// Draft state of the floor plan editor. Nothing is written to Firestore
  /// until [save] is called, so staff can experiment freely.
  const FloorEditorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'floorEditorControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$floorEditorControllerHash();

  @$internal
  @override
  FloorEditorController create() => FloorEditorController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FloorEditorState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FloorEditorState>(value),
    );
  }
}

String _$floorEditorControllerHash() =>
    r'de1184bb3b1d3f616b2354e735fc8a2b44cf92a7';

/// Draft state of the floor plan editor. Nothing is written to Firestore
/// until [save] is called, so staff can experiment freely.

abstract class _$FloorEditorController extends $Notifier<FloorEditorState> {
  FloorEditorState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FloorEditorState, FloorEditorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FloorEditorState, FloorEditorState>,
              FloorEditorState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
