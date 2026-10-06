import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/data/firestore_guard.dart';
import '../../../../core/utils/phone_utils.dart';

/// One-off maintenance for imported customer data.
///
/// Customers imported from another system usually lack the search fields
/// (`phoneNormalized`, `nameLower`) and `updatedAt`, which means they will
/// not appear in the paged list or in search. This walks the collection by
/// document id in pages and patches only documents that need it.
///
/// Cost: one read per customer and one write per patched customer, so run
/// it once after an import (17k customers ≈ 17k reads + ≤17k writes — this
/// fits within the free daily quota but should not be run repeatedly).
class CustomerMaintenanceDataSource {
  CustomerMaintenanceDataSource(this._db, this._businessId);

  final FirebaseFirestore _db;
  final String _businessId;

  Future<({int scanned, int patched})> backfillSearchFields({
    void Function(int scanned, int patched)? onProgress,
    int pageSize = 400,
  }) async {
    final col = _db.collection(FirestorePaths.customers(_businessId));
    var scanned = 0;
    var patched = 0;
    DocumentSnapshot<Map<String, dynamic>>? last;

    while (true) {
      var query = col.orderBy(FieldPath.documentId).limit(pageSize);
      if (last != null) query = query.startAfterDocument(last);
      final snap = await FirestoreGuard.read(query.get);
      if (snap.docs.isEmpty) break;

      final batch = _db.batch();
      var batchCount = 0;
      for (final doc in snap.docs) {
        final data = doc.data();
        final name = (data['name'] as String? ?? '').trim();
        final phone = (data['phone'] as String? ?? '').trim();
        final patch = <String, dynamic>{};
        final normalized = PhoneUtils.normalize(phone);
        if (data['phoneNormalized'] != normalized) patch['phoneNormalized'] = normalized;
        if (data['nameLower'] != name.toLowerCase()) patch['nameLower'] = name.toLowerCase();
        if (data['updatedAt'] == null) patch['updatedAt'] = FieldValue.serverTimestamp();
        if (data['createdAt'] == null) patch['createdAt'] = FieldValue.serverTimestamp();
        if (patch.isNotEmpty) {
          batch.update(doc.reference, patch);
          batchCount++;
        }
      }
      if (batchCount > 0) {
        await FirestoreGuard.write(batch.commit);
        patched += batchCount;
      }
      scanned += snap.docs.length;
      onProgress?.call(scanned, patched);
      last = snap.docs.last;
      if (snap.docs.length < pageSize) break;
    }
    return (scanned: scanned, patched: patched);
  }
}
