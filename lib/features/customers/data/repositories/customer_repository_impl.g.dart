// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(customerRepository)
const customerRepositoryProvider = CustomerRepositoryProvider._();

final class CustomerRepositoryProvider
    extends
        $FunctionalProvider<
          CustomerRepository,
          CustomerRepository,
          CustomerRepository
        >
    with $Provider<CustomerRepository> {
  const CustomerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerRepositoryHash();

  @$internal
  @override
  $ProviderElement<CustomerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CustomerRepository create(Ref ref) {
    return customerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomerRepository>(value),
    );
  }
}

String _$customerRepositoryHash() =>
    r'0db1986cc6f686589871d4884cea022ca5d9343d';

@ProviderFor(customerMaintenance)
const customerMaintenanceProvider = CustomerMaintenanceProvider._();

final class CustomerMaintenanceProvider
    extends
        $FunctionalProvider<
          CustomerMaintenanceDataSource,
          CustomerMaintenanceDataSource,
          CustomerMaintenanceDataSource
        >
    with $Provider<CustomerMaintenanceDataSource> {
  const CustomerMaintenanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerMaintenanceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerMaintenanceHash();

  @$internal
  @override
  $ProviderElement<CustomerMaintenanceDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CustomerMaintenanceDataSource create(Ref ref) {
    return customerMaintenance(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomerMaintenanceDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomerMaintenanceDataSource>(
        value,
      ),
    );
  }
}

String _$customerMaintenanceHash() =>
    r'c5fca1434686420149d0e6e7f514401521856ef1';
