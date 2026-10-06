import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_stats.freezed.dart';

/// Aggregates for a single business day.
@freezed
abstract class DailyStats with _$DailyStats {
  const DailyStats._();

  const factory DailyStats({
    required DateTime date,
    @Default(0.0) double revenue,
    @Default(0) int bills,
    @Default(0) int guests,
    @Default(0.0) double discounts,
    @Default(0.0) double tax,
    @Default(0) int reservations,
    @Default(0) int reservationCovers,
    @Default(0) int cancellations,
    @Default(0) int noShows,
    @Default(0) int voids,
    @Default(0.0) double payCash,
    @Default(0.0) double payCard,
    @Default(0.0) double payMobile,
    @Default(0.0) double payOther,
  }) = _DailyStats;

  double get averageBill => bills == 0 ? 0 : revenue / bills;
}
