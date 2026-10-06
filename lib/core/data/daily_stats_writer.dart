import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_paths.dart';
import '../utils/formatters.dart';

/// Keys of the per-day aggregate document `daily_stats/{yyyy-MM-dd}`.
///
/// Aggregates are maintained with atomic increments as events happen, so
/// the dashboard reads 7 small documents instead of scanning every bill —
/// essential for staying inside the Spark plan's daily read quota.
abstract final class DailyStatKeys {
  static const String date = 'date';
  static const String revenue = 'revenue';
  static const String bills = 'bills';
  static const String guests = 'guests';
  static const String discounts = 'discounts';
  static const String tax = 'tax';
  static const String reservations = 'reservations';
  static const String reservationCovers = 'reservationCovers';
  static const String cancellations = 'cancellations';
  static const String noShows = 'noShows';
  static const String voids = 'voids';
  static const String cash = 'payCash';
  static const String card = 'payCard';
  static const String mobile = 'payMobile';
  static const String otherPayments = 'payOther';
}

abstract final class DailyStatsWriter {
  static DocumentReference<Map<String, dynamic>> ref(
    FirebaseFirestore db,
    String businessId,
    DateTime day,
  ) =>
      db.collection(FirestorePaths.dailyStats(businessId)).doc(Formatters.dateKey(day));

  /// Adds increments for [day] to [batch].
  static void increment(
    WriteBatch batch,
    FirebaseFirestore db,
    String businessId,
    DateTime day,
    Map<String, num> increments,
  ) {
    final data = <String, dynamic>{
      DailyStatKeys.date: Timestamp.fromDate(DateUtilsX.startOfDay(day)),
      for (final e in increments.entries)
        if (e.value != 0) e.key: FieldValue.increment(e.value),
    };
    batch.set(ref(db, businessId, day), data, SetOptions(merge: true));
  }
}
