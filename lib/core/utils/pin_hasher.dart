import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../config/app_config.dart';

/// Hashes staff PINs before they are stored in Firestore.
///
/// The user id acts as a per-user salt so identical PINs across users or
/// businesses never produce identical hashes.
abstract final class PinHasher {
  static const String _pepper = 'tnp.pin.v1';

  static String hash({required String userId, required String pin}) {
    final bytes = utf8.encode('$_pepper:$userId:$pin');
    return sha256.convert(bytes).toString();
  }

  static bool verify({
    required String userId,
    required String pin,
    required String expectedHash,
  }) {
    final actual = hash(userId: userId, pin: pin);
    if (actual.length != expectedHash.length) return false;
    // Constant-time comparison.
    var diff = 0;
    for (var i = 0; i < actual.length; i++) {
      diff |= actual.codeUnitAt(i) ^ expectedHash.codeUnitAt(i);
    }
    return diff == 0;
  }

  /// Returns a validation message, or null when the PIN is acceptable.
  static String? validate(String pin) {
    if (pin.length != AppConfig.pinLength) {
      return 'PIN must be ${AppConfig.pinLength} digits';
    }
    if (!RegExp(r'^\d+$').hasMatch(pin)) return 'PIN must contain digits only';
    if (RegExp(r'^(\d)\1+$').hasMatch(pin)) {
      return 'PIN cannot be the same digit repeated';
    }
    const sequences = '0123456789012';
    const reversed = '9876543210987';
    if (sequences.contains(pin) || reversed.contains(pin)) {
      return 'PIN cannot be a simple sequence';
    }
    return null;
  }
}
