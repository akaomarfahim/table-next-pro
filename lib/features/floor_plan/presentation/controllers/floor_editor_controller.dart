import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/floor_repository_impl.dart';
import '../../domain/entities/floor_area.dart';
import '../../domain/entities/floor_element.dart';
import '../../domain/entities/floor_enums.dart';
import '../../domain/services/table_geometry.dart';
import 'floor_providers.dart';

part 'floor_editor_controller.freezed.dart';
part 'floor_editor_controller.g.dart';

@freezed
abstract class FloorEditorState with _$FloorEditorState {
  const FloorEditorState._();

  const factory FloorEditorState({
    FloorArea? floor,
    @Default(<FloorElement>[]) List<FloorElement> elements,
    String? selectedId,
    @Default(<String>{}) Set<String> deletedIds,
    /// Ids that exist in Firestore (deleting them must be persisted).
    @Default(<String>{}) Set<String> persistedIds,
    @Default(false) bool dirty,
    @Default(false) bool saving,
    @Default(<List<FloorElement>>[]) List<List<FloorElement>> undoStack,
  }) = _FloorEditorState;

  FloorElement? get selected {
    final id = selectedId;
    if (id == null) return null;
    for (final e in elements) {
      if (e.id == id) return e;
    }
    return null;
  }

  int get tableCount => elements.where((e) => e.isTable).length;
  int get seatCount =>
      elements.where((e) => e.isTable).fold(0, (sum, e) => sum + e.seats);
  bool get canUndo => undoStack.isNotEmpty;
}

/// Draft state of the floor plan editor. Nothing is written to Firestore
/// until [save] is called, so staff can experiment freely.
@riverpod
class FloorEditorController extends _$FloorEditorController {
  static const int _maxUndo = 40;

  @override
  FloorEditorState build() => const FloorEditorState();

  /// Loads [floor] with its persisted elements (discarding any draft).
  void load(FloorArea floor, List<FloorElement> allElements) {
    final elements = allElements.where((e) => e.floorId == floor.id).toList();
    state = FloorEditorState(
      floor: floor,
      elements: elements,
      persistedIds: elements.map((e) => e.id).toSet(),
    );
  }

  void select(String? id) => state = state.copyWith(selectedId: id);

  // ---------------------------------------------------------------------------
  // Mutations
  // ---------------------------------------------------------------------------

  void _pushUndo() {
    final stack = [...state.undoStack, state.elements];
    if (stack.length > _maxUndo) stack.removeAt(0);
    state = state.copyWith(undoStack: stack);
  }

  void _apply(List<FloorElement> elements, {String? selectId, bool keepSelection = true}) {
    state = state.copyWith(
      elements: elements,
      dirty: true,
      selectedId: selectId ?? (keepSelection ? state.selectedId : null),
    );
  }

  void undo() {
    if (!state.canUndo) return;
    final stack = [...state.undoStack];
    final previous = stack.removeLast();
    final previousIds = previous.map((e) => e.id).toSet();
    final restoredDeletes = state.deletedIds.difference(previousIds);
    state = state.copyWith(
      elements: previous,
      undoStack: stack,
      deletedIds: restoredDeletes,
      dirty: true,
      selectedId: previousIds.contains(state.selectedId) ? state.selectedId : null,
    );
  }

  Offset _placement(Size size, Offset? near) {
    final floor = state.floor!;
    final base = near ?? Offset(floor.width / 2, floor.height / 2);
    var pos = base - Offset(size.width / 2, size.height / 2);
    // Nudge so new items do not stack exactly on top of each other.
    while (state.elements.any((e) => (e.x - pos.dx).abs() < 4 && (e.y - pos.dy).abs() < 4)) {
      pos += const Offset(24, 24);
    }
    final maxX = floor.width - size.width;
    final maxY = floor.height - size.height;
    return Offset(
      maxX <= 0 ? 0.0 : pos.dx.clamp(0.0, maxX),
      maxY <= 0 ? 0.0 : pos.dy.clamp(0.0, maxY),
    );
  }

  String _nextTableLabel() {
    var max = 0;
    final re = RegExp(r'^T(\d+)$', caseSensitive: false);
    for (final e in ref.read(floorElementsProvider).value ?? const <FloorElement>[]) {
      final m = re.firstMatch(e.label);
      if (m != null) max = max < int.parse(m.group(1)!) ? int.parse(m.group(1)!) : max;
    }
    for (final e in state.elements) {
      final m = re.firstMatch(e.label);
      if (m != null) max = max < int.parse(m.group(1)!) ? int.parse(m.group(1)!) : max;
    }
    return 'T${max + 1}';
  }

  void addTable(TableShape shape, int seats, {Offset? near}) {
    final floor = state.floor;
    if (floor == null) return;
    _pushUndo();
    final size = TableGeometry.sizeFor(shape, seats);
    final pos = _placement(size, near);
    final element = FloorElement(
      id: ref.read(floorRepositoryProvider).newElementId(),
      floorId: floor.id,
      kind: ElementKind.table,
      label: _nextTableLabel(),
      tableShape: shape,
      seats: seats,
      x: pos.dx,
      y: pos.dy,
    );
    _apply([...state.elements, element], selectId: element.id);
  }

  void addStructure(StructureType type, {Offset? near}) {
    final floor = state.floor;
    if (floor == null) return;
    _pushUndo();
    final size = Size(type.defaultWidth, type.defaultHeight);
    final pos = _placement(size, near);
    final element = FloorElement(
      id: ref.read(floorRepositoryProvider).newElementId(),
      floorId: floor.id,
      kind: ElementKind.structure,
      structureType: type,
      label: type.label,
      x: pos.dx,
      y: pos.dy,
      width: size.width,
      height: size.height,
    );
    _apply([...state.elements, element], selectId: element.id);
  }

  /// Call once at the start of a drag / resize gesture (one undo step).
  void beginInteraction() => _pushUndo();

  void move(String id, Offset topLeft) {
    _apply([
      for (final e in state.elements)
        if (e.id == id) e.copyWith(x: topLeft.dx, y: topLeft.dy) else e,
    ]);
  }

  void resize(String id, Size size) {
    _apply([
      for (final e in state.elements)
        if (e.id == id)
          (e.structureType?.isLinear ?? false)
              ? (size.width >= size.height
                  ? e.copyWith(width: size.width, height: e.height < e.width ? e.height : e.width)
                  : e.copyWith(height: size.height, width: e.width < e.height ? e.width : e.height))
              : e.copyWith(width: size.width, height: size.height)
        else
          e,
    ]);
  }

  void update(FloorElement updated, {bool recordUndo = true}) {
    if (recordUndo) _pushUndo();
    _apply([
      for (final e in state.elements) if (e.id == updated.id) _keepInside(updated) else e,
    ]);
  }

  FloorElement _keepInside(FloorElement e) {
    final floor = state.floor;
    if (floor == null) return e;
    final s = e.size;
    return e.copyWith(
      x: e.x.clamp(0, (floor.width - s.width).clamp(0, double.infinity)).toDouble(),
      y: e.y.clamp(0, (floor.height - s.height).clamp(0, double.infinity)).toDouble(),
    );
  }

  void rotateSelected() {
    final e = state.selected;
    if (e == null) return;
    if (e.isTable) {
      update(e.copyWith(rotation: e.isVertical ? 0 : 90));
    } else {
      update(e.copyWith(width: e.height, height: e.width));
    }
  }

  void duplicateSelected() {
    final e = state.selected;
    if (e == null) return;
    _pushUndo();
    final copy = _keepInside(
      e.copyWith(
        id: ref.read(floorRepositoryProvider).newElementId(),
        label: e.isTable ? _nextTableLabel() : e.label,
        x: e.x + 30,
        y: e.y + 30,
        createdAt: null,
        updatedAt: null,
      ),
    );
    _apply([...state.elements, copy], selectId: copy.id);
  }

  void deleteSelected() {
    final e = state.selected;
    if (e == null) return;
    _pushUndo();
    state = state.copyWith(
      elements: state.elements.where((x) => x.id != e.id).toList(),
      deletedIds: state.persistedIds.contains(e.id)
          ? {...state.deletedIds, e.id}
          : state.deletedIds,
      selectedId: null,
      dirty: true,
    );
  }

  /// Returns null when the label is unique on all floors, else an error.
  String? validateLabel(String id, String label) {
    final trimmed = label.trim();
    if (trimmed.isEmpty) return 'Label is required';
    final others = [
      ...state.elements,
      ...(ref.read(floorElementsProvider).value ?? const <FloorElement>[])
          .where((e) => e.floorId != state.floor?.id),
    ];
    final clash = others.any(
      (e) => e.isTable && e.id != id && e.label.toLowerCase() == trimmed.toLowerCase(),
    );
    return clash ? 'Another table already uses "$trimmed"' : null;
  }

  Future<void> save() async {
    final floor = state.floor;
    if (floor == null || !state.dirty) return;
    state = state.copyWith(saving: true);
    try {
      await ref.read(floorRepositoryProvider).saveLayout(
            floorId: floor.id,
            elements: state.elements,
            deletedIds: state.deletedIds,
          );
      if (!ref.mounted) return;
      state = state.copyWith(
        saving: false,
        dirty: false,
        deletedIds: const {},
        persistedIds: state.elements.map((e) => e.id).toSet(),
        undoStack: const [],
      );
    } catch (_) {
      if (ref.mounted) state = state.copyWith(saving: false);
      rethrow;
    }
  }
}
