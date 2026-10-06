// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All open bills (kept alive: used by billing, dashboard and live floor).

@ProviderFor(openBills)
const openBillsProvider = OpenBillsProvider._();

/// All open bills (kept alive: used by billing, dashboard and live floor).

final class OpenBillsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Bill>>,
          List<Bill>,
          Stream<List<Bill>>
        >
    with $FutureModifier<List<Bill>>, $StreamProvider<List<Bill>> {
  /// All open bills (kept alive: used by billing, dashboard and live floor).
  const OpenBillsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openBillsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openBillsHash();

  @$internal
  @override
  $StreamProviderElement<List<Bill>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Bill>> create(Ref ref) {
    return openBills(ref);
  }
}

String _$openBillsHash() => r'ce1539467691f9699ab6c3d8f108f4b3e7c03130';

@ProviderFor(billById)
const billByIdProvider = BillByIdFamily._();

final class BillByIdProvider
    extends $FunctionalProvider<AsyncValue<Bill?>, Bill?, Stream<Bill?>>
    with $FutureModifier<Bill?>, $StreamProvider<Bill?> {
  const BillByIdProvider._({
    required BillByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'billByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$billByIdHash();

  @override
  String toString() {
    return r'billByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Bill?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Bill?> create(Ref ref) {
    final argument = this.argument as String;
    return billById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BillByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$billByIdHash() => r'3a9e0d92c7938dc61af35320b3d825f56f242520';

final class BillByIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Bill?>, String> {
  const BillByIdFamily._()
    : super(
        retry: null,
        name: r'billByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BillByIdProvider call(String id) =>
      BillByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'billByIdProvider';
}

@ProviderFor(BillHistoryDate)
const billHistoryDateProvider = BillHistoryDateProvider._();

final class BillHistoryDateProvider
    extends $NotifierProvider<BillHistoryDate, DateTime> {
  const BillHistoryDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billHistoryDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billHistoryDateHash();

  @$internal
  @override
  BillHistoryDate create() => BillHistoryDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$billHistoryDateHash() => r'c8ee122eacb5a2ee2136a0351018b57a38b2ce52';

abstract class _$BillHistoryDate extends $Notifier<DateTime> {
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

@ProviderFor(closedBillsForDay)
const closedBillsForDayProvider = ClosedBillsForDayFamily._();

final class ClosedBillsForDayProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Bill>>,
          List<Bill>,
          Stream<List<Bill>>
        >
    with $FutureModifier<List<Bill>>, $StreamProvider<List<Bill>> {
  const ClosedBillsForDayProvider._({
    required ClosedBillsForDayFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'closedBillsForDayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$closedBillsForDayHash();

  @override
  String toString() {
    return r'closedBillsForDayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Bill>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Bill>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return closedBillsForDay(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ClosedBillsForDayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$closedBillsForDayHash() => r'13a67864ba70fd6febbf3aecb90edc81930cd429';

final class ClosedBillsForDayFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Bill>>, DateTime> {
  const ClosedBillsForDayFamily._()
    : super(
        retry: null,
        name: r'closedBillsForDayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ClosedBillsForDayProvider call(DateTime day) =>
      ClosedBillsForDayProvider._(argument: day, from: this);

  @override
  String toString() => r'closedBillsForDayProvider';
}

@ProviderFor(customerBills)
const customerBillsProvider = CustomerBillsFamily._();

final class CustomerBillsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Bill>>,
          List<Bill>,
          FutureOr<List<Bill>>
        >
    with $FutureModifier<List<Bill>>, $FutureProvider<List<Bill>> {
  const CustomerBillsProvider._({
    required CustomerBillsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'customerBillsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerBillsHash();

  @override
  String toString() {
    return r'customerBillsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Bill>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Bill>> create(Ref ref) {
    final argument = this.argument as String;
    return customerBills(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerBillsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerBillsHash() => r'6c83741f68c8e20f05abd22b527480fda44ae932';

final class CustomerBillsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Bill>>, String> {
  const CustomerBillsFamily._()
    : super(
        retry: null,
        name: r'customerBillsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CustomerBillsProvider call(String customerId) =>
      CustomerBillsProvider._(argument: customerId, from: this);

  @override
  String toString() => r'customerBillsProvider';
}
