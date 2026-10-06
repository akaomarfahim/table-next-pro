// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyStatsModel _$DailyStatsModelFromJson(Map json) => _DailyStatsModel(
  date: const TimestampConverter().fromJson(json['date']),
  revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
  bills: (json['bills'] as num?)?.toInt() ?? 0,
  guests: (json['guests'] as num?)?.toInt() ?? 0,
  discounts: (json['discounts'] as num?)?.toDouble() ?? 0.0,
  tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
  reservations: (json['reservations'] as num?)?.toInt() ?? 0,
  reservationCovers: (json['reservationCovers'] as num?)?.toInt() ?? 0,
  cancellations: (json['cancellations'] as num?)?.toInt() ?? 0,
  noShows: (json['noShows'] as num?)?.toInt() ?? 0,
  voids: (json['voids'] as num?)?.toInt() ?? 0,
  payCash: (json['payCash'] as num?)?.toDouble() ?? 0.0,
  payCard: (json['payCard'] as num?)?.toDouble() ?? 0.0,
  payMobile: (json['payMobile'] as num?)?.toDouble() ?? 0.0,
  payOther: (json['payOther'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$DailyStatsModelToJson(_DailyStatsModel instance) =>
    <String, dynamic>{
      'date': const TimestampConverter().toJson(instance.date),
      'revenue': instance.revenue,
      'bills': instance.bills,
      'guests': instance.guests,
      'discounts': instance.discounts,
      'tax': instance.tax,
      'reservations': instance.reservations,
      'reservationCovers': instance.reservationCovers,
      'cancellations': instance.cancellations,
      'noShows': instance.noShows,
      'voids': instance.voids,
      'payCash': instance.payCash,
      'payCard': instance.payCard,
      'payMobile': instance.payMobile,
      'payOther': instance.payOther,
    };
