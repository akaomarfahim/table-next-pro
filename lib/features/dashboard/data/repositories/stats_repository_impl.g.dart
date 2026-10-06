// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(statsRepository)
const statsRepositoryProvider = StatsRepositoryProvider._();

final class StatsRepositoryProvider
    extends
        $FunctionalProvider<StatsRepository, StatsRepository, StatsRepository>
    with $Provider<StatsRepository> {
  const StatsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statsRepositoryHash();

  @$internal
  @override
  $ProviderElement<StatsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StatsRepository create(Ref ref) {
    return statsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatsRepository>(value),
    );
  }
}

String _$statsRepositoryHash() => r'ec1ac819dcfcb2c4ebd93d6e90f926aae4783dde';

/// The last 7 days including today.

@ProviderFor(weeklyStats)
const weeklyStatsProvider = WeeklyStatsProvider._();

/// The last 7 days including today.

final class WeeklyStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DailyStats>>,
          List<DailyStats>,
          Stream<List<DailyStats>>
        >
    with $FutureModifier<List<DailyStats>>, $StreamProvider<List<DailyStats>> {
  /// The last 7 days including today.
  const WeeklyStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyStatsHash();

  @$internal
  @override
  $StreamProviderElement<List<DailyStats>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DailyStats>> create(Ref ref) {
    return weeklyStats(ref);
  }
}

String _$weeklyStatsHash() => r'160f5a0651f7dba633530ce9bcb2db2133c660ee';
