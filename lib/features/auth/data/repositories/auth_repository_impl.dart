import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/firebase_providers.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/utils/pin_hasher.dart';
import '../../../business/data/models/business_model.dart';
import '../../../business/domain/entities/business.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';
import '../../domain/entities/session_state.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/session_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/app_user_model.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._local);

  final UserRemoteDataSource _remote;
  final SessionLocalDataSource _local;

  @override
  Future<DeviceActivation?> getActivation() => _local.read();

  @override
  Future<void> saveActivation(DeviceActivation activation) =>
      _local.write(activation);

  @override
  Future<void> clearActivation() => _local.clear();

  @override
  Future<AppUser> signInWithUsername({
    required String username,
    required String pin,
  }) async {
    final model = await _remote.findByUsername(username);
    if (model == null ||
        !model.active ||
        !PinHasher.verify(userId: model.id, pin: pin, expectedHash: model.pinHash)) {
      throw const AuthenticationException('Incorrect username or PIN.');
    }
    return model.toEntity();
  }

  @override
  Future<AppUser> verifyPin({
    required String businessId,
    required String pin,
  }) async {
    final users = await _remote.fetchByBusiness(businessId);
    for (final user in users) {
      if (!user.active) continue;
      if (PinHasher.verify(userId: user.id, pin: pin, expectedHash: user.pinHash)) {
        return user.toEntity();
      }
    }
    throw const AuthenticationException('Incorrect PIN.');
  }

  @override
  Future<void> recordLogin(String userId) async {
    try {
      await _remote.patch(userId, {'lastLoginAt': FieldValue.serverTimestamp()});
    } catch (_) {
      // Non-critical.
    }
  }

  @override
  Future<AppUser> provisionBusiness({
    required Business business,
    required String ownerName,
    required String username,
    required String pin,
  }) async {
    final pinError = PinHasher.validate(pin);
    if (pinError != null) throw ValidationException(pinError);
    final normalized = username.trim().toLowerCase();
    if (normalized.length < 3) {
      throw const ValidationException('Username must be at least 3 characters.');
    }
    if (await _remote.findByUsername(normalized) != null) {
      throw const ConflictException('This username is already taken.');
    }

    final businessId = _remote.newBusinessId();
    final ownerId = _remote.newId();
    final owner = AppUser(
      id: ownerId,
      businessId: businessId,
      name: ownerName.trim(),
      username: normalized,
      role: UserRole.owner,
      pinHash: PinHasher.hash(userId: ownerId, pin: pin),
    );

    await _remote.createBusinessWithOwner(
      businessId: businessId,
      businessData: BusinessModel.fromEntity(business.copyWith(id: businessId)).toJson(),
      owner: AppUserModel.fromEntity(owner),
    );
    return owner;
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    UserRemoteDataSource(ref.watch(firestoreProvider)),
    SessionLocalDataSource(ref.watch(secureStorageServiceProvider)),
  );
}
