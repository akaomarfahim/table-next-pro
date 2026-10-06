import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/firebase_providers.dart';
import '../../../../core/utils/pin_hasher.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/app_user_model.dart';

part 'user_repository_impl.g.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._remote);

  final UserRemoteDataSource _remote;

  @override
  String newUserId() => _remote.newId();

  @override
  Stream<List<AppUser>> watchUsers(String businessId) => _remote
      .watchByBusiness(businessId)
      .map((list) => list.map((m) => m.toEntity()).toList()
        ..sort((a, b) => a.role.index.compareTo(b.role.index) != 0
            ? a.role.index.compareTo(b.role.index)
            : a.name.toLowerCase().compareTo(b.name.toLowerCase())));

  @override
  Future<List<AppUser>> getUsers(String businessId) async =>
      (await _remote.fetchByBusiness(businessId)).map((m) => m.toEntity()).toList();

  @override
  Future<bool> isUsernameTaken(String username, {String? excludeUserId}) async {
    final existing = await _remote.findByUsername(username);
    return existing != null && existing.id != excludeUserId;
  }

  Future<void> _ensurePinUnique(
    String businessId,
    String userId,
    String pin,
  ) async {
    final users = await _remote.fetchByBusiness(businessId);
    final clash = users.any(
      (u) =>
          u.id != userId &&
          PinHasher.verify(userId: u.id, pin: pin, expectedHash: u.pinHash),
    );
    if (clash) {
      throw const ConflictException(
        'This PIN is already used by another staff member. Choose a different PIN.',
      );
    }
  }

  @override
  Future<AppUser> createUser(AppUser user, {required String pin}) async {
    final pinError = PinHasher.validate(pin);
    if (pinError != null) throw ValidationException(pinError);
    final username = user.username.trim().toLowerCase();
    if (await isUsernameTaken(username)) {
      throw const ConflictException('This username is already taken.');
    }
    final id = user.id.isEmpty ? _remote.newId() : user.id;
    await _ensurePinUnique(user.businessId, id, pin);
    final entity = user.copyWith(
      id: id,
      username: username,
      pinHash: PinHasher.hash(userId: id, pin: pin),
    );
    await _remote.create(AppUserModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<void> updateUser(AppUser user, {String? newPin}) async {
    final username = user.username.trim().toLowerCase();
    if (await isUsernameTaken(username, excludeUserId: user.id)) {
      throw const ConflictException('This username is already taken.');
    }
    var entity = user.copyWith(username: username);
    if (newPin != null && newPin.isNotEmpty) {
      final pinError = PinHasher.validate(newPin);
      if (pinError != null) throw ValidationException(pinError);
      await _ensurePinUnique(user.businessId, user.id, newPin);
      entity = entity.copyWith(pinHash: PinHasher.hash(userId: user.id, pin: newPin));
    }
    await _remote.update(AppUserModel.fromEntity(entity));
  }

  @override
  Future<void> setActive(String userId, {required bool active}) =>
      _remote.patch(userId, {'active': active});
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) =>
    UserRepositoryImpl(UserRemoteDataSource(ref.watch(firestoreProvider)));
