import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/data/firestore_guard.dart';
import '../models/floor_models.dart';

class FloorRemoteDataSource {
  FloorRemoteDataSource(this._db, this._businessId);

  final FirebaseFirestore _db;
  final String _businessId;

  CollectionReference<Map<String, dynamic>> get _floors =>
      _db.collection(FirestorePaths.floors(_businessId));
  CollectionReference<Map<String, dynamic>> get _elements =>
      _db.collection(FirestorePaths.floorElements(_businessId));

  String newElementId() => _elements.doc().id;

  Stream<List<FloorAreaModel>> watchFloors() => FirestoreGuard.stream(
        _floors.orderBy(FirestoreFields.sortOrder).snapshots().map(
              (s) => s.docs
                  .map((d) => FloorAreaModel.fromJson(FirestoreGuard.withId(d)))
                  .toList(),
            ),
      );

  Stream<List<FloorElementModel>> watchElements() => FirestoreGuard.stream(
        _elements.snapshots().map(
              (s) => s.docs
                  .map((d) => FloorElementModel.fromJson(FirestoreGuard.withId(d)))
                  .where((e) => e.active)
                  .toList(),
            ),
      );

  Future<FloorAreaModel> createFloor(FloorAreaModel model) async {
    final ref = _floors.doc();
    await FirestoreGuard.write(
      () => ref.set(FirestoreGuard.forCreate(model.toJson())),
    );
    return model.copyWith(id: ref.id);
  }

  Future<void> updateFloor(FloorAreaModel model) => FirestoreGuard.write(
        () => _floors.doc(model.id).update(FirestoreGuard.forUpdate(model.toJson())),
      );

  Future<void> deleteFloor(String floorId) => FirestoreGuard.write(() async {
        final elements =
            await _elements.where('floorId', isEqualTo: floorId).get();
        final batch = _db.batch();
        for (final doc in elements.docs) {
          batch.delete(doc.reference);
        }
        batch.delete(_floors.doc(floorId));
        await batch.commit();
      });

  Future<void> saveLayout({
    required List<FloorElementModel> upserts,
    required Set<String> deletedIds,
  }) =>
      FirestoreGuard.write(() {
        final batch = _db.batch();
        for (final model in upserts) {
          final data = model.createdAt == null
              ? FirestoreGuard.forCreate(model.toJson())
              : FirestoreGuard.forUpdate(model.toJson());
          batch.set(_elements.doc(model.id), data, SetOptions(merge: true));
        }
        for (final id in deletedIds) {
          batch.delete(_elements.doc(id));
        }
        return batch.commit();
      });
}
