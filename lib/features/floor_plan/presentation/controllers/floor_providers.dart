import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../data/repositories/floor_repository_impl.dart';
import '../../domain/entities/floor_area.dart';
import '../../domain/entities/floor_element.dart';

part 'floor_providers.g.dart';

@Riverpod(keepAlive: true)
Stream<List<FloorArea>> floors(Ref ref) =>
    ref.watch(floorRepositoryProvider).watchFloors();

@Riverpod(keepAlive: true)
Stream<List<FloorElement>> floorElements(Ref ref) =>
    ref.watch(floorRepositoryProvider).watchElements();

/// All tables across floors, sorted naturally by label (T1, T2, T10).
@riverpod
AsyncValue<List<FloorElement>> allTables(Ref ref) {
  return ref.watch(floorElementsProvider).whenData(
        (elements) => elements.where((e) => e.isTable).toList()
          ..sort((a, b) => naturalCompare(a.label, b.label)),
      );
}

/// Currently selected floor tab (remembered on this device).
@Riverpod(keepAlive: true)
class SelectedFloorId extends _$SelectedFloorId {
  @override
  String? build() => ref
      .read(localStorageServiceProvider)
      .getSetting<String>(StorageKeys.lastFloorId);

  void select(String id) {
    state = id;
    ref.read(localStorageServiceProvider).setSetting(StorageKeys.lastFloorId, id);
  }
}

/// Resolves the selected floor, falling back to the first one.
@riverpod
FloorArea? activeFloor(Ref ref) {
  final floors = ref.watch(floorsProvider).value ?? const [];
  if (floors.isEmpty) return null;
  final selected = ref.watch(selectedFloorIdProvider);
  return floors.firstWhere((f) => f.id == selected, orElse: () => floors.first);
}

/// "T2" < "T10" comparison.
int naturalCompare(String a, String b) {
  final re = RegExp(r'(\d+)|(\D+)');
  final pa = re.allMatches(a.toLowerCase()).map((m) => m.group(0)!).toList();
  final pb = re.allMatches(b.toLowerCase()).map((m) => m.group(0)!).toList();
  for (var i = 0; i < pa.length && i < pb.length; i++) {
    final na = int.tryParse(pa[i]);
    final nb = int.tryParse(pb[i]);
    final c = (na != null && nb != null) ? na.compareTo(nb) : pa[i].compareTo(pb[i]);
    if (c != 0) return c;
  }
  return pa.length.compareTo(pb.length);
}
