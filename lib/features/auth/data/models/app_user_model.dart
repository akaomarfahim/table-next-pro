import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/json_converters.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';

part 'app_user_model.freezed.dart';
part 'app_user_model.g.dart';

@freezed
abstract class AppUserModel with _$AppUserModel {
  const AppUserModel._();

  const factory AppUserModel({
    @JsonKey(includeToJson: false) @Default('') String id,
    required String businessId,
    required String name,
    required String username,
    @JsonKey(unknownEnumValue: UserRole.waiter) @Default(UserRole.waiter) UserRole role,
    @Default('') String pinHash,
    @Default('') String phone,
    @Default(true) bool active,
    @NullableTimestampConverter() DateTime? lastLoginAt,
    @NullableTimestampConverter() DateTime? createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _AppUserModel;

  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserModelFromJson(json);

  factory AppUserModel.fromEntity(AppUser e) => AppUserModel(
        id: e.id,
        businessId: e.businessId,
        name: e.name,
        username: e.username,
        role: e.role,
        pinHash: e.pinHash,
        phone: e.phone,
        active: e.active,
        lastLoginAt: e.lastLoginAt,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  AppUser toEntity() => AppUser(
        id: id,
        businessId: businessId,
        name: name,
        username: username,
        role: role,
        pinHash: pinHash,
        phone: phone,
        active: active,
        lastLoginAt: lastLoginAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
