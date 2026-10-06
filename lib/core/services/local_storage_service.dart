import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/storage_keys.dart';

/// Thin wrapper around Hive boxes used for device-level preferences and
/// lightweight offline caches. Values are stored as JSON-compatible
/// primitives / maps, so no Hive type adapters are required.
class LocalStorageService {
  LocalStorageService._(this._settings, this._cache);

  final Box<dynamic> _settings;
  final Box<dynamic> _cache;

  static Future<LocalStorageService> init() async {
    await Hive.initFlutter();
    final settings = await Hive.openBox<dynamic>(HiveBoxes.settings);
    final cache = await Hive.openBox<dynamic>(HiveBoxes.cache);
    return LocalStorageService._(settings, cache);
  }

  // ---------------------------------------------------------------------------
  // Settings
  // ---------------------------------------------------------------------------
  T? getSetting<T>(String key) {
    final value = _settings.get(key);
    return value is T ? value : null;
  }

  Future<void> setSetting(String key, Object? value) async {
    if (value == null) {
      await _settings.delete(key);
    } else {
      await _settings.put(key, value);
    }
  }

  // ---------------------------------------------------------------------------
  // Cache
  // ---------------------------------------------------------------------------
  Map<String, dynamic>? getCachedMap(String key) {
    final value = _cache.get(key);
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  Future<void> putCachedMap(String key, Map<String, dynamic> value) =>
      _cache.put(key, value);

  String? getCachedString(String key) {
    final value = _cache.get(key);
    return value is String ? value : null;
  }

  Future<void> putCachedString(String key, String value) =>
      _cache.put(key, value);

  Future<void> removeCached(String key) => _cache.delete(key);

  Future<void> clearCache() => _cache.clear();
}

/// Overridden in `bootstrap.dart` with the initialised instance.
final localStorageServiceProvider = Provider<LocalStorageService>(
  (ref) => throw UnimplementedError(
    'localStorageServiceProvider must be overridden in ProviderScope',
  ),
);
