import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/storage_keys.dart';
import '../services/local_storage_service.dart';

part 'theme_controller.g.dart';

/// Persists the user's preferred [ThemeMode] on the device.
@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemeMode build() {
    final stored = ref
        .watch(localStorageServiceProvider)
        .getSetting<String>(StorageKeys.themeMode);
    return ThemeMode.values.firstWhere(
      (m) => m.name == stored,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    await ref
        .read(localStorageServiceProvider)
        .setSetting(StorageKeys.themeMode, mode.name);
  }
}
