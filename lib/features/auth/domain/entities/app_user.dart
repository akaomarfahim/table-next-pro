import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_role.dart';

part 'app_user.freezed.dart';

/// A staff member. Stored in the global `users` collection with a
/// `businessId` so the business can be resolved at sign-in.
@freezed
abstract class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser({
    required String id,
    required String businessId,
    required String name,
    required String username,
    required UserRole role,
    @Default('') String pinHash,
    @Default('') String phone,
    @Default(true) bool active,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AppUser;

  bool can(Permission permission) => active && role.can(permission);

  String get firstName => name.trim().split(RegExp(r'\s+')).first;
}
