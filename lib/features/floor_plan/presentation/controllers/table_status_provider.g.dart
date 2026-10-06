// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Combines today's reservations, open bills and the clock into a status
/// map keyed by table id.

@ProviderFor(tableStatuses)
const tableStatusesProvider = TableStatusesProvider._();

/// Combines today's reservations, open bills and the clock into a status
/// map keyed by table id.

final class TableStatusesProvider
    extends
        $FunctionalProvider<
          Map<String, TableLiveStatus>,
          Map<String, TableLiveStatus>,
          Map<String, TableLiveStatus>
        >
    with $Provider<Map<String, TableLiveStatus>> {
  /// Combines today's reservations, open bills and the clock into a status
  /// map keyed by table id.
  const TableStatusesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tableStatusesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tableStatusesHash();

  @$internal
  @override
  $ProviderElement<Map<String, TableLiveStatus>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, TableLiveStatus> create(Ref ref) {
    return tableStatuses(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, TableLiveStatus> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, TableLiveStatus>>(value),
    );
  }
}

String _$tableStatusesHash() => r'3f2e9a49516bcfba7e17a0d57bf0588520bf2946';
