import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/data/daily_stats_writer.dart';
import '../../../../core/data/firestore_guard.dart';
import '../../../../core/services/firebase_providers.dart';
import '../../../../core/utils/formatters.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../domain/entities/daily_stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../models/daily_stats_model.dart';

part 'stats_repository_impl.g.dart';

/// Reads the pre-aggregated `daily_stats` documents (≤ 1 read per day).
class StatsRepositoryImpl implements StatsRepository {
  StatsRepositoryImpl(this._db, this._businessId);

  final FirebaseFirestore _db;
  final String _businessId;

  @override
  Stream<List<DailyStats>> watchDays(DateTime from, DateTime to) {
    final start = DateUtilsX.startOfDay(from);
    final end = DateUtilsX.endOfDay(to);
    return FirestoreGuard.stream(
      _db
          .collection(FirestorePaths.dailyStats(_businessId))
          .where(
            DailyStatKeys.date,
            isGreaterThanOrEqualTo: Timestamp.fromDate(start),
            isLessThan: Timestamp.fromDate(end),
          )
          .snapshots()
          .map((snap) {
        final byKey = <String, DailyStats>{
          for (final d in snap.docs)
            d.id: DailyStatsModel.fromJson(d.data()).toEntity(),
        };
        final days = <DailyStats>[];
        for (var day = start; day.isBefore(end); day = day.add(const Duration(days: 1))) {
          final normalized = DateUtilsX.startOfDay(day);
          days.add(byKey[Formatters.dateKey(normalized)] ?? DailyStats(date: normalized));
        }
        return days;
      }),
    );
  }
}

@Riverpod(keepAlive: true)
StatsRepository statsRepository(Ref ref) => StatsRepositoryImpl(
      ref.watch(firestoreProvider),
      ref.watch(requireBusinessIdProvider),
    );

/// The last 7 days including today.
@riverpod
Stream<List<DailyStats>> weeklyStats(Ref ref) {
  final today = DateUtilsX.startOfDay(DateTime.now());
  return ref
      .watch(statsRepositoryProvider)
      .watchDays(today.subtract(const Duration(days: 6)), today);
}
