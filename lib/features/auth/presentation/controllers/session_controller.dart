import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/logger_service.dart';
import '../../../business/data/repositories/business_repository_impl.dart';
import '../../../business/domain/entities/business.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/session_state.dart';
import '../../domain/entities/user_role.dart';

part 'session_controller.g.dart';

/// Owns the device session: activation, PIN lock/unlock and sign-out.
///
/// Action methods throw [AppException]s for the UI to display; they never
/// put the provider into an error state (that would break routing).
@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  int _failedAttempts = 0;
  DateTime? _cooldownUntil;

  @override
  Future<SessionState> build() async {
    final auth = ref.watch(authRepositoryProvider);
    final businessRepo = ref.watch(businessRepositoryProvider);

    final activation = await auth.getActivation();
    if (activation == null) return const SessionState.needsActivation();

    final cached = businessRepo.getCachedBusiness();
    if (cached != null && cached.id == activation.businessId) {
      return SessionState.locked(business: cached);
    }
    try {
      final business = await businessRepo.getBusiness(activation.businessId);
      return SessionState.locked(business: business);
    } on NotFoundException {
      // Business was deleted remotely: unlink the device.
      await auth.clearActivation();
      return const SessionState.needsActivation();
    }
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  /// First-time sign in on this device with username + PIN.
  Future<void> activate({required String username, required String pin}) async {
    _guardCooldown();
    final auth = ref.read(authRepositoryProvider);
    final businessRepo = ref.read(businessRepositoryProvider);
    try {
      final user = await auth.signInWithUsername(username: username, pin: pin);
      final business = await businessRepo.getBusiness(user.businessId);
      if (!business.active) {
        throw const PermissionDeniedException(
          'This business account is inactive. Please contact support.',
        );
      }
      await auth.saveActivation(
        DeviceActivation(
          businessId: business.id,
          activatedByUserId: user.id,
          activatedAt: DateTime.now(),
        ),
      );
      _resetAttempts();
      unawaited(auth.recordLogin(user.id));
      _log('Device activated for business ${business.id} by ${user.username}');
      state = AsyncData(SessionState.unlocked(business: business, user: user));
    } on AuthenticationException {
      _registerFailure();
      rethrow;
    }
  }

  /// Unlocks the PIN screen. Any active staff PIN of the business works.
  Future<AppUser> unlock(String pin) async {
    _guardCooldown();
    final business = state.value?.businessOrNull;
    if (business == null) {
      throw const AuthenticationException('Device is not activated.');
    }
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .verifyPin(businessId: business.id, pin: pin);
      _resetAttempts();
      unawaited(ref.read(authRepositoryProvider).recordLogin(user.id));
      state = AsyncData(SessionState.unlocked(business: business, user: user));
      return user;
    } on AuthenticationException {
      _registerFailure();
      rethrow;
    }
  }

  /// Verifies a PIN belongs to a user allowed to perform [permission]
  /// without changing the signed-in user (manager override).
  Future<AppUser> authorize(String pin, Permission permission) async {
    final business = state.value?.businessOrNull;
    if (business == null) throw const AuthenticationException();
    final user = await ref
        .read(authRepositoryProvider)
        .verifyPin(businessId: business.id, pin: pin);
    if (!user.can(permission)) throw const PermissionDeniedException();
    return user;
  }

  void lock() {
    final current = state.value;
    if (current case SessionUnlocked(:final business)) {
      _log('Session locked');
      state = AsyncData(SessionState.locked(business: business));
    }
  }

  /// Creates a brand-new business with its owner and signs in.
  Future<void> provisionBusiness({
    required String provisioningCode,
    required Business business,
    required String ownerName,
    required String username,
    required String pin,
  }) async {
    if (AppConfig.provisioningCode.isNotEmpty &&
        provisioningCode.trim() != AppConfig.provisioningCode) {
      throw const AuthenticationException('Invalid provisioning code.');
    }
    if (!AppConfig.canProvision) {
      throw const PermissionDeniedException('Provisioning is disabled.');
    }
    final auth = ref.read(authRepositoryProvider);
    final owner = await auth.provisionBusiness(
      business: business,
      ownerName: ownerName,
      username: username,
      pin: pin,
    );
    final created = await ref
        .read(businessRepositoryProvider)
        .getBusiness(owner.businessId)
        .catchError((Object _) => business.copyWith(id: owner.businessId));
    await auth.saveActivation(
      DeviceActivation(
        businessId: owner.businessId,
        activatedByUserId: owner.id,
        activatedAt: DateTime.now(),
      ),
    );
    _log('Provisioned business ${owner.businessId}');
    state = AsyncData(SessionState.unlocked(business: created, user: owner));
  }

  /// Unlinks this device from its business.
  Future<void> deactivateDevice() async {
    await ref.read(authRepositoryProvider).clearActivation();
    await ref.read(businessRepositoryProvider).clearCache();
    _log('Device deactivated');
    state = const AsyncData(SessionState.needsActivation());
  }

  /// Keeps the session in sync after the business profile is edited.
  void replaceBusiness(Business business) {
    final current = state.value;
    switch (current) {
      case SessionLocked():
        state = AsyncData(SessionState.locked(business: business));
      case SessionUnlocked(:final user):
        state = AsyncData(SessionState.unlocked(business: business, user: user));
      case SessionNeedsActivation() || null:
        break;
    }
  }

  /// Keeps the session in sync when the signed in user edits themselves.
  void replaceUser(AppUser user) {
    final current = state.value;
    if (current case SessionUnlocked(:final business, user: final old)
        when old.id == user.id) {
      if (!user.active) {
        state = AsyncData(SessionState.locked(business: business));
      } else {
        state = AsyncData(SessionState.unlocked(business: business, user: user));
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Brute-force protection
  // ---------------------------------------------------------------------------

  Duration? get remainingCooldown {
    final until = _cooldownUntil;
    if (until == null) return null;
    final left = until.difference(DateTime.now());
    return left.isNegative ? null : left;
  }

  void _guardCooldown() {
    final left = remainingCooldown;
    if (left != null) {
      throw ValidationException(
        'Too many attempts. Try again in ${left.inSeconds + 1}s.',
      );
    }
  }

  void _registerFailure() {
    _failedAttempts++;
    if (_failedAttempts >= AppConfig.maxPinAttempts) {
      _cooldownUntil = DateTime.now().add(AppConfig.pinCooldown);
      _failedAttempts = 0;
    }
  }

  void _resetAttempts() {
    _failedAttempts = 0;
    _cooldownUntil = null;
  }

  void _log(String message) => ref.read(talkerProvider).info('[Session] $message');
}

// -----------------------------------------------------------------------------
// Derived session providers
// -----------------------------------------------------------------------------

/// The business this device is linked to (null before activation).
@Riverpod(keepAlive: true)
String? currentBusinessId(Ref ref) => ref.watch(
      sessionControllerProvider.select((s) => s.value?.businessOrNull?.id),
    );

/// Live business profile (settings changes from other devices apply
/// immediately). Falls back to the session copy while loading.
@Riverpod(keepAlive: true)
Stream<Business> liveBusiness(Ref ref) {
  final id = ref.watch(currentBusinessIdProvider);
  if (id == null) return const Stream.empty();
  return ref.watch(businessRepositoryProvider).watchBusiness(id);
}

@Riverpod(keepAlive: true)
Business? currentBusiness(Ref ref) {
  final live = ref.watch(liveBusinessProvider).value;
  final session = ref.watch(
    sessionControllerProvider.select((s) => s.value?.businessOrNull),
  );
  if (live != null && live.id == session?.id) return live;
  return session;
}

/// Business id for data-layer providers. Only read while a business is
/// active (all operational screens are behind the session guard).
@Riverpod(keepAlive: true)
String requireBusinessId(Ref ref) {
  final id = ref.watch(currentBusinessIdProvider);
  if (id == null) throw StateError('No business is linked to this device.');
  return id;
}

@Riverpod(keepAlive: true)
AppUser? currentUser(Ref ref) => ref.watch(
      sessionControllerProvider.select((s) => s.value?.userOrNull),
    );

/// Convenience permission check.
@riverpod
bool hasPermission(Ref ref, Permission permission) =>
    ref.watch(currentUserProvider)?.can(permission) ?? false;
