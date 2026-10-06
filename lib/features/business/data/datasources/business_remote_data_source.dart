import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/data/firestore_guard.dart';
import '../../../../core/errors/app_exception.dart';
import '../models/business_model.dart';

class BusinessRemoteDataSource {
  BusinessRemoteDataSource(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(FirestorePaths.businesses);

  Future<BusinessModel> fetch(String id) => FirestoreGuard.read(() async {
        final doc = await _col.doc(id).get();
        if (!doc.exists) throw const NotFoundException('Business not found.');
        return BusinessModel.fromJson(FirestoreGuard.withId(doc));
      });

  Stream<BusinessModel> watch(String id) => FirestoreGuard.stream(
        _col.doc(id).snapshots().where((d) => d.exists).map(
              (d) => BusinessModel.fromJson(FirestoreGuard.withId(d)),
            ),
      );

  /// Reserves a new document id without writing.
  String newId() => _col.doc().id;

  Future<void> create(String id, BusinessModel model) => FirestoreGuard.write(
        () => _col.doc(id).set(FirestoreGuard.forCreate(model.toJson())),
      );

  Future<void> update(BusinessModel model) => FirestoreGuard.write(
        () => _col.doc(model.id).update(FirestoreGuard.forUpdate(model.toJson())),
      );
}
