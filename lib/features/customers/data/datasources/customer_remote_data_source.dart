import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/data/firestore_guard.dart';
import '../../../../core/domain/page_result.dart';
import '../models/customer_model.dart';

/// Firestore queries for customers. All queries are single-field ordered,
/// which Firestore indexes automatically (no composite indexes needed).
class CustomerRemoteDataSource {
  CustomerRemoteDataSource(this._db, this._businessId);

  final FirebaseFirestore _db;
  final String _businessId;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(FirestorePaths.customers(_businessId));

  CustomerModel _map(DocumentSnapshot<Map<String, dynamic>> d) =>
      CustomerModel.fromJson(FirestoreGuard.withId(d));

  Future<PageResult<CustomerModel>> fetchPage({
    required int limit,
    Object? cursor,
  }) =>
      FirestoreGuard.read(() async {
        var query = _col
            .orderBy(FirestoreFields.updatedAt, descending: true)
            .limit(limit + 1);
        if (cursor is DocumentSnapshot) {
          query = query.startAfterDocument(cursor);
        }
        final snap = await query.get();
        final docs = snap.docs;
        final hasMore = docs.length > limit;
        final pageDocs = hasMore ? docs.sublist(0, limit) : docs;
        return PageResult(
          items: pageDocs.map(_map).toList(),
          cursor: pageDocs.isEmpty ? null : pageDocs.last,
          hasMore: hasMore,
        );
      });

  Future<List<CustomerModel>> prefixSearch({
    required String field,
    required String prefix,
    required int limit,
  }) =>
      FirestoreGuard.read(() async {
        final snap = await _col
            .orderBy(field)
            .startAt([prefix])
            .endAt(['$prefix'])
            .limit(limit)
            .get();
        return snap.docs.map(_map).toList();
      });

  Future<CustomerModel?> fetchById(String id) => FirestoreGuard.read(() async {
        final doc = await _col.doc(id).get();
        return doc.exists ? _map(doc) : null;
      });

  Stream<CustomerModel?> watchById(String id) => FirestoreGuard.stream(
        _col.doc(id).snapshots().map((d) => d.exists ? _map(d) : null),
      );

  Future<CustomerModel?> findByPhone(String normalized) =>
      FirestoreGuard.read(() async {
        final snap = await _col
            .where('phoneNormalized', isEqualTo: normalized)
            .limit(1)
            .get();
        return snap.docs.isEmpty ? null : _map(snap.docs.first);
      });

  String newId() => _col.doc().id;

  Future<void> create(CustomerModel model) => FirestoreGuard.write(
        () => _col.doc(model.id).set(FirestoreGuard.forCreate(model.toJson())),
      );

  Future<void> update(CustomerModel model) => FirestoreGuard.write(
        () => _col
            .doc(model.id)
            .update(FirestoreGuard.forUpdate(model.toProfileJson())),
      );

  Future<void> delete(String id) =>
      FirestoreGuard.write(() => _col.doc(id).delete());
}
