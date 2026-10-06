import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/data/firestore_guard.dart';
import '../models/app_user_model.dart';

/// Firestore access for the global `users` collection.
///
/// Queries are single-field equality filters, so no composite indexes are
/// required.
class UserRemoteDataSource {
  UserRemoteDataSource(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(FirestorePaths.users);

  String newId() => _col.doc().id;

  String newBusinessId() => _db.collection(FirestorePaths.businesses).doc().id;

  Future<AppUserModel?> findByUsername(String username) =>
      FirestoreGuard.read(() async {
        final snap = await _col
            .where('username', isEqualTo: username.trim().toLowerCase())
            .limit(1)
            .get();
        if (snap.docs.isEmpty) return null;
        return AppUserModel.fromJson(FirestoreGuard.withId(snap.docs.first));
      });

  Future<List<AppUserModel>> fetchByBusiness(String businessId) =>
      FirestoreGuard.read(() async {
        final snap = await _col
            .where(FirestoreFields.businessId, isEqualTo: businessId)
            .get();
        return snap.docs
            .map((d) => AppUserModel.fromJson(FirestoreGuard.withId(d)))
            .toList();
      });

  Stream<List<AppUserModel>> watchByBusiness(String businessId) =>
      FirestoreGuard.stream(
        _col
            .where(FirestoreFields.businessId, isEqualTo: businessId)
            .snapshots()
            .map(
              (s) => s.docs
                  .map((d) => AppUserModel.fromJson(FirestoreGuard.withId(d)))
                  .toList(),
            ),
      );

  Future<void> create(AppUserModel model) => FirestoreGuard.write(
        () => _col.doc(model.id).set(FirestoreGuard.forCreate(model.toJson())),
      );

  Future<void> update(AppUserModel model) => FirestoreGuard.write(
        () => _col.doc(model.id).update(FirestoreGuard.forUpdate(model.toJson())),
      );

  Future<void> patch(String id, Map<String, dynamic> data) =>
      FirestoreGuard.write(
        () => _col.doc(id).update(<String, dynamic>{
          ...data,
          FirestoreFields.updatedAt: FieldValue.serverTimestamp(),
        }),
      );

  /// Writes the business + its first owner atomically.
  Future<void> createBusinessWithOwner({
    required String businessId,
    required Map<String, dynamic> businessData,
    required AppUserModel owner,
  }) =>
      FirestoreGuard.write(() {
        final batch = _db.batch()
          ..set(
            _db.doc(FirestorePaths.business(businessId)),
            FirestoreGuard.forCreate(businessData),
          )
          ..set(_col.doc(owner.id), FirestoreGuard.forCreate(owner.toJson()));
        return batch.commit();
      });
}
