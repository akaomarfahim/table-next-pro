// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Current search text of the customers screen (debounced by the UI).

@ProviderFor(CustomerSearchQuery)
const customerSearchQueryProvider = CustomerSearchQueryProvider._();

/// Current search text of the customers screen (debounced by the UI).
final class CustomerSearchQueryProvider
    extends $NotifierProvider<CustomerSearchQuery, String> {
  /// Current search text of the customers screen (debounced by the UI).
  const CustomerSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerSearchQueryHash();

  @$internal
  @override
  CustomerSearchQuery create() => CustomerSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$customerSearchQueryHash() =>
    r'223cea908a3c449dd7e6ee1687340ab189b6629e';

/// Current search text of the customers screen (debounced by the UI).

abstract class _$CustomerSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Paged customer list ordered by most recently updated, or search results
/// when a query is active. Only one page (25 docs) is read at a time.

@ProviderFor(CustomerList)
const customerListProvider = CustomerListProvider._();

/// Paged customer list ordered by most recently updated, or search results
/// when a query is active. Only one page (25 docs) is read at a time.
final class CustomerListProvider
    extends $AsyncNotifierProvider<CustomerList, CustomerListState> {
  /// Paged customer list ordered by most recently updated, or search results
  /// when a query is active. Only one page (25 docs) is read at a time.
  const CustomerListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerListHash();

  @$internal
  @override
  CustomerList create() => CustomerList();
}

String _$customerListHash() => r'befa911024ba17036a500439380066f54ecb9b5e';

/// Paged customer list ordered by most recently updated, or search results
/// when a query is active. Only one page (25 docs) is read at a time.

abstract class _$CustomerList extends $AsyncNotifier<CustomerListState> {
  FutureOr<CustomerListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<CustomerListState>, CustomerListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CustomerListState>, CustomerListState>,
              AsyncValue<CustomerListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Realtime single customer.

@ProviderFor(customerById)
const customerByIdProvider = CustomerByIdFamily._();

/// Realtime single customer.

final class CustomerByIdProvider
    extends
        $FunctionalProvider<AsyncValue<Customer?>, Customer?, Stream<Customer?>>
    with $FutureModifier<Customer?>, $StreamProvider<Customer?> {
  /// Realtime single customer.
  const CustomerByIdProvider._({
    required CustomerByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'customerByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerByIdHash();

  @override
  String toString() {
    return r'customerByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Customer?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Customer?> create(Ref ref) {
    final argument = this.argument as String;
    return customerById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerByIdHash() => r'279e25dfa284f1092db7145f5a6c9d7ec9e4203d';

/// Realtime single customer.

final class CustomerByIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Customer?>, String> {
  const CustomerByIdFamily._()
    : super(
        retry: null,
        name: r'customerByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Realtime single customer.

  CustomerByIdProvider call(String id) =>
      CustomerByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'customerByIdProvider';
}

/// Customer currently highlighted in the master/detail layout.

@ProviderFor(SelectedCustomerId)
const selectedCustomerIdProvider = SelectedCustomerIdProvider._();

/// Customer currently highlighted in the master/detail layout.
final class SelectedCustomerIdProvider
    extends $NotifierProvider<SelectedCustomerId, String?> {
  /// Customer currently highlighted in the master/detail layout.
  const SelectedCustomerIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCustomerIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCustomerIdHash();

  @$internal
  @override
  SelectedCustomerId create() => SelectedCustomerId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedCustomerIdHash() =>
    r'5426efbb0687ac58a50ae51ac8ddc2866df50313';

/// Customer currently highlighted in the master/detail layout.

abstract class _$SelectedCustomerId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
