import 'dart:convert';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../domain/entities/session_state.dart';

/// Persists the device ↔ business link in secure storage.
class SessionLocalDataSource {
  SessionLocalDataSource(this._secure);

  final SecureStorageService _secure;

  Future<DeviceActivation?> read() async {
    final raw = await _secure.read(StorageKeys.deviceActivation);
    if (raw == null || raw.isEmpty) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return DeviceActivation(
        businessId: map['businessId'] as String,
        activatedByUserId: map['activatedByUserId'] as String? ?? '',
        activatedAt: DateTime.tryParse(map['activatedAt'] as String? ?? '') ??
            DateTime.now(),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> write(DeviceActivation activation) {
    return _secure.write(
      StorageKeys.deviceActivation,
      jsonEncode(<String, dynamic>{
        'businessId': activation.businessId,
        'activatedByUserId': activation.activatedByUserId,
        'activatedAt': activation.activatedAt.toIso8601String(),
      }),
    );
  }

  Future<void> clear() => _secure.delete(StorageKeys.deviceActivation);
}
