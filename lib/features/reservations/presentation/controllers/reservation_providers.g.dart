// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Day shown on the reservations screen.

@ProviderFor(SelectedReservationDate)
const selectedReservationDateProvider = SelectedReservationDateProvider._();

/// Day shown on the reservations screen.
final class SelectedReservationDateProvider
    extends $NotifierProvider<SelectedReservationDate, DateTime> {
  /// Day shown on the reservations screen.
  const SelectedReservationDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedReservationDateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedReservationDateHash();

  @$internal
  @override
  SelectedReservationDate create() => SelectedReservationDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$selectedReservationDateHash() =>
    r'64a6d69b773d8f82bf547c31d655a41fa13b0e2d';

/// Day shown on the reservations screen.

abstract class _$SelectedReservationDate extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ReservationListFilter)
const reservationListFilterProvider = ReservationListFilterProvider._();

final class ReservationListFilterProvider
    extends $NotifierProvider<ReservationListFilter, ReservationFilter> {
  const ReservationListFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reservationListFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reservationListFilterHash();

  @$internal
  @override
  ReservationListFilter create() => ReservationListFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReservationFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReservationFilter>(value),
    );
  }
}

String _$reservationListFilterHash() =>
    r'ba9e208b7deb863f9b8895433f5129dc6c8e861d';

abstract class _$ReservationListFilter extends $Notifier<ReservationFilter> {
  ReservationFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ReservationFilter, ReservationFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReservationFilter, ReservationFilter>,
              ReservationFilter,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Realtime reservations for a single day.

@ProviderFor(reservationsForDay)
const reservationsForDayProvider = ReservationsForDayFamily._();

/// Realtime reservations for a single day.

final class ReservationsForDayProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Reservation>>,
          List<Reservation>,
          Stream<List<Reservation>>
        >
    with
        $FutureModifier<List<Reservation>>,
        $StreamProvider<List<Reservation>> {
  /// Realtime reservations for a single day.
  const ReservationsForDayProvider._({
    required ReservationsForDayFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'reservationsForDayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reservationsForDayHash();

  @override
  String toString() {
    return r'reservationsForDayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Reservation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Reservation>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return reservationsForDay(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReservationsForDayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reservationsForDayHash() =>
    r'524c95815ee35867f25437a61836f7b5058cdc73';

/// Realtime reservations for a single day.

final class ReservationsForDayFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Reservation>>, DateTime> {
  const ReservationsForDayFamily._()
    : super(
        retry: null,
        name: r'reservationsForDayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Realtime reservations for a single day.

  ReservationsForDayProvider call(DateTime day) =>
      ReservationsForDayProvider._(argument: day, from: this);

  @override
  String toString() => r'reservationsForDayProvider';
}

/// Realtime reservations around a day (±6h) for conflict detection of
/// bookings that cross midnight.

@ProviderFor(reservationsWindow)
const reservationsWindowProvider = ReservationsWindowFamily._();

/// Realtime reservations around a day (±6h) for conflict detection of
/// bookings that cross midnight.

final class ReservationsWindowProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Reservation>>,
          List<Reservation>,
          Stream<List<Reservation>>
        >
    with
        $FutureModifier<List<Reservation>>,
        $StreamProvider<List<Reservation>> {
  /// Realtime reservations around a day (±6h) for conflict detection of
  /// bookings that cross midnight.
  const ReservationsWindowProvider._({
    required ReservationsWindowFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'reservationsWindowProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reservationsWindowHash();

  @override
  String toString() {
    return r'reservationsWindowProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Reservation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Reservation>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return reservationsWindow(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReservationsWindowProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reservationsWindowHash() =>
    r'427d3267fe9227b4f17839d317d96c63be18c76e';

/// Realtime reservations around a day (±6h) for conflict detection of
/// bookings that cross midnight.

final class ReservationsWindowFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Reservation>>, DateTime> {
  const ReservationsWindowFamily._()
    : super(
        retry: null,
        name: r'reservationsWindowProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Realtime reservations around a day (±6h) for conflict detection of
  /// bookings that cross midnight.

  ReservationsWindowProvider call(DateTime day) =>
      ReservationsWindowProvider._(argument: day, from: this);

  @override
  String toString() => r'reservationsWindowProvider';
}

/// Today's reservations, kept alive for the dashboard and live floor.

@ProviderFor(todayReservations)
const todayReservationsProvider = TodayReservationsProvider._();

/// Today's reservations, kept alive for the dashboard and live floor.

final class TodayReservationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Reservation>>,
          List<Reservation>,
          Stream<List<Reservation>>
        >
    with
        $FutureModifier<List<Reservation>>,
        $StreamProvider<List<Reservation>> {
  /// Today's reservations, kept alive for the dashboard and live floor.
  const TodayReservationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayReservationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayReservationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Reservation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Reservation>> create(Ref ref) {
    return todayReservations(ref);
  }
}

String _$todayReservationsHash() => r'e17254dad4d020daa96d11c5246d86f0770c288c';

@ProviderFor(reservationById)
const reservationByIdProvider = ReservationByIdFamily._();

final class ReservationByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Reservation?>,
          Reservation?,
          Stream<Reservation?>
        >
    with $FutureModifier<Reservation?>, $StreamProvider<Reservation?> {
  const ReservationByIdProvider._({
    required ReservationByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'reservationByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reservationByIdHash();

  @override
  String toString() {
    return r'reservationByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Reservation?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Reservation?> create(Ref ref) {
    final argument = this.argument as String;
    return reservationById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReservationByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reservationByIdHash() => r'5ca3f699490b9c09c913f9a585188d0331b76e9b';

final class ReservationByIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Reservation?>, String> {
  const ReservationByIdFamily._()
    : super(
        retry: null,
        name: r'reservationByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReservationByIdProvider call(String id) =>
      ReservationByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'reservationByIdProvider';
}

@ProviderFor(customerReservations)
const customerReservationsProvider = CustomerReservationsFamily._();

final class CustomerReservationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Reservation>>,
          List<Reservation>,
          FutureOr<List<Reservation>>
        >
    with
        $FutureModifier<List<Reservation>>,
        $FutureProvider<List<Reservation>> {
  const CustomerReservationsProvider._({
    required CustomerReservationsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'customerReservationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerReservationsHash();

  @override
  String toString() {
    return r'customerReservationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Reservation>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Reservation>> create(Ref ref) {
    final argument = this.argument as String;
    return customerReservations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerReservationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerReservationsHash() =>
    r'da5483818fc4b20769e31da5e89749c01101cdd7';

final class CustomerReservationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Reservation>>, String> {
  const CustomerReservationsFamily._()
    : super(
        retry: null,
        name: r'customerReservationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CustomerReservationsProvider call(String customerId) =>
      CustomerReservationsProvider._(argument: customerId, from: this);

  @override
  String toString() => r'customerReservationsProvider';
}

/// A ticking clock (1 minute) used for "late" badges and live floor status.

@ProviderFor(minuteTicker)
const minuteTickerProvider = MinuteTickerProvider._();

/// A ticking clock (1 minute) used for "late" badges and live floor status.

final class MinuteTickerProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  /// A ticking clock (1 minute) used for "late" badges and live floor status.
  const MinuteTickerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'minuteTickerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$minuteTickerHash();

  @$internal
  @override
  $StreamProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DateTime> create(Ref ref) {
    return minuteTicker(ref);
  }
}

String _$minuteTickerHash() => r'e76f34b2698b2a8d556c507b8d50d541a8fc345d';
