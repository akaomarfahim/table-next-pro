// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_actions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(billActions)
const billActionsProvider = BillActionsProvider._();

final class BillActionsProvider
    extends $FunctionalProvider<BillActions, BillActions, BillActions>
    with $Provider<BillActions> {
  const BillActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billActionsHash();

  @$internal
  @override
  $ProviderElement<BillActions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BillActions create(Ref ref) {
    return billActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BillActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BillActions>(value),
    );
  }
}

String _$billActionsHash() => r'c60e47dd2393fc41f5ec9cad300c0b49177fff1d';
