import '../entities/app_user.dart';

/// Staff management for a business.
abstract interface class UserRepository {
  Stream<List<AppUser>> watchUsers(String businessId);

  Future<List<AppUser>> getUsers(String businessId);

  Future<bool> isUsernameTaken(String username, {String? excludeUserId});

  /// Creates a user and returns it. [pin] is hashed before storage.
  Future<AppUser> createUser(AppUser user, {required String pin});

  /// Updates profile fields. When [newPin] is set the PIN hash is replaced.
  Future<void> updateUser(AppUser user, {String? newPin});

  Future<void> setActive(String userId, {required bool active});

  /// New user id (allocated client side so the PIN can be salted with it).
  String newUserId();
}
