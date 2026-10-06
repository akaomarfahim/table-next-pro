// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(billRepository)
const billRepositoryProvider = BillRepositoryProvider._();

final class BillRepositoryProvider
    extends $FunctionalProvider<BillRepository, BillRepository, BillRepository>
    with $Provider<BillRepository> {
  const BillRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billRepositoryHash();

  @$internal
  @override
  $ProviderElement<BillRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BillRepository create(Ref ref) {
    return billRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BillRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BillRepository>(value),
    );
  }
}

String _$billRepositoryHash() => r'9e307097ee99529205ad450260650ccd769df719';
