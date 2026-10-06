import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/json_converters.dart';
import '../../domain/entities/daily_stats.dart';

part 'daily_stats_model.freezed.dart';
part 'daily_stats_model.g.dart';

@freezed
abstract class DailyStatsModel with _$DailyStatsModel {
  const DailyStatsModel._();

  const factory DailyStatsModel({
    @TimestampConverter() required DateTime date,
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
  }) = _DailyStatsModel;

  factory DailyStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DailyStatsModelFromJson(json);

  DailyStats toEntity() => DailyStats(
        date: date,
        revenue: revenue,
        bills: bills,
        guests: guests,
        discounts: discounts,
        tax: tax,
        reservations: reservations,
        reservationCovers: reservationCovers,
        cancellations: cancellations,
        noShows: noShows,
        voids: voids,
        payCash: payCash,
        payCard: payCard,
        payMobile: payMobile,
        payOther: payOther,
      );
}
