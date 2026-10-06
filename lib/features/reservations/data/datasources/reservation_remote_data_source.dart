import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/data/daily_stats_writer.dart';
import '../../../../core/data/firestore_guard.dart';
import '../models/reservation_model.dart';

/// Firestore access for reservations.
///
/// Range queries use the single field `startAt`; customer history uses a
/// single equality filter and is sorted on the client — no composite
/// indexes are required.
class ReservationRemoteDataSource {
  ReservationRemoteDataSource(this._db, this._businessId);

  final FirebaseFirestore _db;
  final String _businessId;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(FirestorePaths.reservations(_businessId));

  DocumentReference<Map<String, dynamic>> _customer(String id) =>
      _db.collection(FirestorePaths.customers(_businessId)).doc(id);

  ReservationModel _map(DocumentSnapshot<Map<String, dynamic>> d) =>
      ReservationModel.fromJson(FirestoreGuard.withId(d));

  Query<Map<String, dynamic>> _range(DateTime from, DateTime to) => _col
      .where(
        'startAt',
        isGreaterThanOrEqualTo: Timestamp.fromDate(from),
        isLessThan: Timestamp.fromDate(to),
      )
      .orderBy('startAt');

  Stream<List<ReservationModel>> watchRange(DateTime from, DateTime to) =>
      FirestoreGuard.stream(
        _range(from, to).snapshots().map((s) => s.docs.map(_map).toList()),
      );

  Future<List<ReservationModel>> fetchRange(DateTime from, DateTime to) =>
      FirestoreGuard.read(() async {
        final snap = await _range(from, to).get();
        return snap.docs.map(_map).toList();
      });

  Stream<ReservationModel?> watchById(String id) => FirestoreGuard.stream(
        _col.doc(id).snapshots().map((d) => d.exists ? _map(d) : null),
      );

  Future<List<ReservationModel>> fetchByCustomer(String customerId, int limit) =>
      FirestoreGuard.read(() async {
        final snap = await _col
            .where('customerId', isEqualTo: customerId)
            .limit(limit)
            .get();
        return snap.docs.map(_map).toList()
          ..sort((a, b) => b.startAt.compareTo(a.startAt));
      });

  String newId() => _col.doc().id;

  Future<void> create(ReservationModel model) => FirestoreGuard.write(() {
        final batch = _db.batch()
          ..set(_col.doc(model.id), FirestoreGuard.forCreate(model.toJson()))
          ..set(
            _customer(model.customerId),
            {
              'reservationCount': FieldValue.increment(1),
              FirestoreFields.updatedAt: FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true),
          );
        DailyStatsWriter.increment(batch, _db, _businessId, model.startAt, {
          DailyStatKeys.reservations: 1,
          DailyStatKeys.reservationCovers: model.partySize,
        });
        return batch.commit();
      });

  Future<void> update(ReservationModel model) => FirestoreGuard.write(
        () => _col.doc(model.id).update(FirestoreGuard.forUpdate(model.toJson())),
      );

  Future<void> changeStatus({
    required ReservationModel model,
    required Map<String, dynamic> fields,
    Map<String, num> customerIncrements = const {},
    Map<String, num> statIncrements = const {},
  }) =>
      FirestoreGuard.write(() {
        final batch = _db.batch()
          ..update(_col.doc(model.id), {
            ...fields,
            FirestoreFields.updatedAt: FieldValue.serverTimestamp(),
          });
        if (customerIncrements.isNotEmpty) {
          batch.set(
            _customer(model.customerId),
            {
              for (final e in customerIncrements.entries)
                e.key: FieldValue.increment(e.value),
              FirestoreFields.updatedAt: FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true),
          );
        }
        if (statIncrements.isNotEmpty) {
          DailyStatsWriter.increment(batch, _db, _businessId, model.startAt, statIncrements);
        }
        return batch.commit();
      });

  Future<void> patch(String id, Map<String, dynamic> data) => FirestoreGuard.write(
        () => _col.doc(id).update({
          ...data,
          FirestoreFields.updatedAt: FieldValue.serverTimestamp(),
        }),
      );
}
