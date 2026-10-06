// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Realtime list of staff for the current business.

@ProviderFor(staffUsers)
const staffUsersProvider = StaffUsersProvider._();

/// Realtime list of staff for the current business.

final class StaffUsersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AppUser>>,
          List<AppUser>,
          Stream<List<AppUser>>
        >
    with $FutureModifier<List<AppUser>>, $StreamProvider<List<AppUser>> {
  /// Realtime list of staff for the current business.
  const StaffUsersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffUsersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffUsersHash();

  @$internal
  @override
  $StreamProviderElement<List<AppUser>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<AppUser>> create(Ref ref) {
    return staffUsers(ref);
  }
}

String _$staffUsersHash() => r'4624759f65de4e7c3fba63baec804098433f5113';
