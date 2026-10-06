import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/firebase_providers.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../domain/entities/floor_area.dart';
import '../../domain/entities/floor_element.dart';
import '../../domain/repositories/floor_repository.dart';
import '../datasources/floor_remote_data_source.dart';
import '../models/floor_models.dart';

part 'floor_repository_impl.g.dart';

class FloorRepositoryImpl implements FloorRepository {
  FloorRepositoryImpl(this._remote);

  final FloorRemoteDataSource _remote;

  @override
  String newElementId() => _remote.newElementId();

  @override
  Stream<List<FloorArea>> watchFloors() =>
      _remote.watchFloors().map((l) => l.map((m) => m.toEntity()).toList());

  @override
  Stream<List<FloorElement>> watchElements() =>
      _remote.watchElements().map((l) => l.map((m) => m.toEntity()).toList());

  @override
  Future<FloorArea> createFloor({required String name, required int sortOrder}) async {
    final model = await _remote.createFloor(
      FloorAreaModel(name: name.trim(), sortOrder: sortOrder),
    );
    return model.toEntity();
  }

  @override
  Future<void> updateFloor(FloorArea floor) =>
      _remote.updateFloor(FloorAreaModel.fromEntity(floor));

  @override
  Future<void> deleteFloor(String floorId) => _remote.deleteFloor(floorId);

  @override
  Future<void> saveLayout({
    required String floorId,
    required List<FloorElement> elements,
    required Set<String> deletedIds,
  }) {
    return _remote.saveLayout(
      upserts: elements
          .where((e) => e.floorId == floorId)
          .map(FloorElementModel.fromEntity)
          .toList(),
      deletedIds: deletedIds,
    );
  }
}

@Riverpod(keepAlive: true)
FloorRepository floorRepository(Ref ref) => FloorRepositoryImpl(
      FloorRemoteDataSource(
        ref.watch(firestoreProvider),
        ref.watch(requireBusinessIdProvider),
      ),
    );
