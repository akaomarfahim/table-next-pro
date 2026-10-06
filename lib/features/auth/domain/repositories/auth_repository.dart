import '../../../business/domain/entities/business.dart';
import '../entities/app_user.dart';
import '../entities/session_state.dart';

/// Authentication without Firebase Auth: staff credentials are stored in
/// Firestore (`users` collection) and verified on the device.
abstract interface class AuthRepository {
  /// Returns the business this device is linked to, if any.
  Future<DeviceActivation?> getActivation();

  Future<void> saveActivation(DeviceActivation activation);

  Future<void> clearActivation();

  /// Verifies a username + PIN pair (device activation).
  /// Throws `AuthenticationException` when invalid.
  Future<AppUser> signInWithUsername({
    required String username,
    required String pin,
  });

  /// Finds the active user of [businessId] owning [pin].
  /// Throws `AuthenticationException` when no user matches.
  Future<AppUser> verifyPin({required String businessId, required String pin});

  Future<void> recordLogin(String userId);

  /// Creates a new business together with its first owner account.
  /// Returns the created owner (with the new `businessId`).
  Future<AppUser> provisionBusiness({
    required Business business,
    required String ownerName,
    required String username,
    required String pin,
  });
}
