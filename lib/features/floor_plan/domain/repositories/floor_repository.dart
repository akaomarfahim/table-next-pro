import '../entities/floor_area.dart';
import '../entities/floor_element.dart';

abstract interface class FloorRepository {
  Stream<List<FloorArea>> watchFloors();

  /// All active elements of every floor (layouts are small, so a single
  /// listener is cheaper than one per floor).
  Stream<List<FloorElement>> watchElements();

  Future<FloorArea> createFloor({required String name, required int sortOrder});

  Future<void> updateFloor(FloorArea floor);

  /// Deletes a floor together with all of its elements.
  Future<void> deleteFloor(String floorId);

  /// Persists the editor draft for one floor in a single atomic batch:
  /// upserts [elements] and deletes [deletedIds].
  Future<void> saveLayout({
    required String floorId,
    required List<FloorElement> elements,
    required Set<String> deletedIds,
  });

  String newElementId();
}
