import '../entities/daily_stats.dart';

abstract interface class StatsRepository {
  /// One entry per day in [from, to] (days without activity are zero-filled).
  Stream<List<DailyStats>> watchDays(DateTime from, DateTime to);
}
