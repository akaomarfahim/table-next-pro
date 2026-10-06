import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage_plus/flutter_secure_storage_plus.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'local_storage_service.dart';
import 'logger_service.dart';

/// Secure key/value storage (Keychain / Keystore / DPAPI / libsecret).
///
/// If the platform keystore is unavailable (e.g. macOS without keychain
/// entitlements during development) it transparently falls back to the
/// Hive cache box so the app keeps working, and logs a warning.
class SecureStorageService {
  SecureStorageService({required this._fallback, required this._talker, FlutterSecureStoragePlus? storage})
    : _storage = storage ?? FlutterSecureStoragePlus();

  final FlutterSecureStoragePlus _storage;
  final LocalStorageService _fallback;
  final Talker _talker;

  static const String _fallbackPrefix = 'secure_fallback__';

  Future<String?> read(String key) async {
    try {
      final value = await _storage.read(key: key);
      return value ?? _fallback.getCachedString('$_fallbackPrefix$key');
    } catch (e, st) {
      _talker.warning('Secure storage read failed, using fallback', e, st);
      return _fallback.getCachedString('$_fallbackPrefix$key');
    }
  }

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e, st) {
      _talker.warning('Secure storage write failed, using fallback', e, st);
      await _fallback.putCachedString('$_fallbackPrefix$key', value);
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e, st) {
      _talker.warning('Secure storage delete failed', e, st);
    }
    await _fallback.removeCached('$_fallbackPrefix$key');
  }
}

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService(fallback: ref.watch(localStorageServiceProvider), talker: ref.watch(talkerProvider));
});
