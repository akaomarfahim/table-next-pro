/// Hive box names and keys for local persistence.
abstract final class HiveBoxes {
  static const String settings = 'tnp_settings';
  static const String cache = 'tnp_cache';
}

abstract final class StorageKeys {
  // Settings box
  static const String themeMode = 'theme_mode';
  static const String autoLockMinutes = 'auto_lock_minutes';
  static const String floorSnapToGrid = 'floor_snap_to_grid';
  static const String lastFloorId = 'last_floor_id';

  // Cache box
  static const String cachedBusiness = 'cached_business';

  // Secure storage
  static const String deviceActivation = 'device_activation';
  static const String deviceId = 'device_id';
}
