import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/data/daily_stats_writer.dart';
import '../../../../core/data/firestore_guard.dart';
import '../models/bill_model.dart';

class BillRemoteDataSource {
  BillRemoteDataSource(this._db, this._businessId);

  final FirebaseFirestore _db;
  final String _businessId;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(FirestorePaths.bills(_businessId));

  BillModel _map(DocumentSnapshot<Map<String, dynamic>> d) =>
      BillModel.fromJson(FirestoreGuard.withId(d));

  String newId() => _col.doc().id;

  Stream<List<BillModel>> watchOpen() => FirestoreGuard.stream(
        _col.where('status', isEqualTo: 'open').snapshots().map(
              (s) => s.docs.map(_map).toList()
                ..sort((a, b) => (a.createdAt ?? DateTime.now())
                    .compareTo(b.createdAt ?? DateTime.now())),
            ),
      );

  Stream<BillModel?> watchById(String id) => FirestoreGuard.stream(
        _col.doc(id).snapshots().map((d) => d.exists ? _map(d) : null),
      );

  Stream<List<BillModel>> watchClosed(DateTime from, DateTime to) =>
      FirestoreGuard.stream(
        _col
            .where(
              'closedAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(from),
              isLessThan: Timestamp.fromDate(to),
            )
            .orderBy('closedAt', descending: true)
            .snapshots()
            .map((s) => s.docs.map(_map).toList()),
      );

  Future<List<BillModel>> fetchByCustomer(String customerId, int limit) =>
      FirestoreGuard.read(() async {
        final snap = await _col
            .where('customerId', isEqualTo: customerId)
            .limit(limit)
            .get();
        return snap.docs.map(_map).toList()
          ..sort((a, b) => (b.createdAt ?? DateTime(2000))
              .compareTo(a.createdAt ?? DateTime(2000)));
      });

  /// Sequential bill number via a transaction on `counters/bills`.
  /// Transactions need connectivity, so an offline fallback number is used
  /// when the server cannot be reached quickly.
  Future<String> nextBillNumber() async {
    final ref = _db.doc(FirestorePaths.billCounter(_businessId));
    try {
      final next = await _db
          .runTransaction<int>((tx) async {
            final snap = await tx.get(ref);
            final current = (snap.data()?['next'] as num?)?.toInt() ?? 1;
            tx.set(ref, {'next': current + 1}, SetOptions(merge: true));
            return current;
          })
          .timeout(const Duration(seconds: 5));
      return next.toString().padLeft(5, '0');
    } catch (_) {
      final now = DateTime.now();
      final suffix = Random().nextInt(90) + 10;
      String two(int v) => v.toString().padLeft(2, '0');
      return 'OFF-${two(now.day)}${two(now.hour)}${two(now.minute)}$suffix';
    }
  }

  Future<void> create(BillModel model) => FirestoreGuard.write(
        () => _col.doc(model.id).set(FirestoreGuard.forCreate(model.toJson())),
      );

  Future<void> update(BillModel model) => FirestoreGuard.write(
        () => _col.doc(model.id).update(FirestoreGuard.forUpdate(model.toJson())),
      );

  Future<void> settle({
    required BillModel model,
    required DateTime closedAt,
    required Map<String, num> statIncrements,
  }) =>
      FirestoreGuard.write(() {
        final batch = _db.batch()
          ..update(_col.doc(model.id), FirestoreGuard.forUpdate(model.toJson()));

        final customerId = model.customerId;
        if (customerId != null && customerId.isNotEmpty) {
          batch.set(
            _db.collection(FirestorePaths.customers(_businessId)).doc(customerId),
            {
              'visitCount': FieldValue.increment(1),
              'totalSpent': FieldValue.increment(model.total),
              'lastVisitAt': Timestamp.fromDate(closedAt),
              FirestoreFields.updatedAt: FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true),
          );
        }

        final reservationId = model.reservationId;
        if (reservationId != null && reservationId.isNotEmpty) {
          batch.set(
            _db.collection(FirestorePaths.reservations(_businessId)).doc(reservationId),
            {
              'status': 'completed',
              'completedAt': Timestamp.fromDate(closedAt),
              'billId': model.id,
              FirestoreFields.updatedAt: FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true),
          );
        }

        DailyStatsWriter.increment(batch, _db, _businessId, closedAt, statIncrements);
        return batch.commit();
      });

  Future<void> voidBill({
    required BillModel model,
    required DateTime closedAt,
  }) =>
      FirestoreGuard.write(() {
        final batch = _db.batch()
          ..update(_col.doc(model.id), FirestoreGuard.forUpdate(model.toJson()));
        DailyStatsWriter.increment(batch, _db, _businessId, closedAt, {
          DailyStatKeys.voids: 1,
        });
        return batch.commit();
      });
}
