import 'package:flutter/foundation.dart';

/// Compile-time and global application configuration.
///
/// Values that differ per deployment are injected with `--dart-define`:
///
/// ```bash
/// flutter run --dart-define=TNP_PROVISIONING_CODE=MY-SECRET-CODE
/// ```
abstract final class AppConfig {
  static const String appName = 'TableNext Pro';
  static const String appTagline = 'Reservations · Floor · Billing';
  static const String appVersion = '1.0.0';

  /// Code required to create a brand-new business from the activation
  /// screen. When empty, provisioning is only available in debug builds.
  static const String provisioningCode = String.fromEnvironment(
    'TNP_PROVISIONING_CODE',
  );

  static bool get canProvision => provisioningCode.isNotEmpty || kDebugMode;

  /// Number of digits in a staff PIN.
  static const int pinLength = 4;

  /// Failed PIN attempts before a temporary cooldown is applied.
  static const int maxPinAttempts = 5;
  static const Duration pinCooldown = Duration(seconds: 30);

  /// Default inactivity auto-lock in minutes (0 = never).
  static const int defaultAutoLockMinutes = 5;

  /// Page size used for large collections (customers).
  static const int customersPageSize = 25;
  static const int searchResultLimit = 12;

  /// Firestore write acknowledgement timeout. Writes are applied to the
  /// local cache immediately, so a timeout means "queued, will sync".
  static const Duration writeAckTimeout = Duration(seconds: 8);
}
