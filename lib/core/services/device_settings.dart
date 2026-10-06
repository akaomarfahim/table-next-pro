import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../constants/storage_keys.dart';
import 'local_storage_service.dart';

part 'device_settings.g.dart';

/// Inactivity auto-lock timeout (minutes, 0 = never) for this device.
@Riverpod(keepAlive: true)
class AutoLockMinutes extends _$AutoLockMinutes {
  static const List<int> options = [0, 1, 2, 5, 10, 15, 30];

  @override
  int build() {
    return ref
            .watch(localStorageServiceProvider)
            .getSetting<int>(StorageKeys.autoLockMinutes) ??
        AppConfig.defaultAutoLockMinutes;
  }

  Future<void> set(int minutes) async {
    state = minutes;
    await ref
        .read(localStorageServiceProvider)
        .setSetting(StorageKeys.autoLockMinutes, minutes);
  }
}

/// Whether floor-plan elements snap to the grid while dragging.
@Riverpod(keepAlive: true)
class SnapToGrid extends _$SnapToGrid {
  @override
  bool build() {
    return ref
            .watch(localStorageServiceProvider)
            .getSetting<bool>(StorageKeys.floorSnapToGrid) ??
        true;
  }

  Future<void> toggle() async {
    state = !state;
    await ref
        .read(localStorageServiceProvider)
        .setSetting(StorageKeys.floorSnapToGrid, state);
  }
}
