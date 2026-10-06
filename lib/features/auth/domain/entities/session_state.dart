import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../business/domain/entities/business.dart';
import 'app_user.dart';

part 'session_state.freezed.dart';

/// Lifecycle of the device session.
///
/// * [SessionNeedsActivation] – device is not linked to any business yet.
/// * [SessionLocked] – device is linked to a business; PIN required.
/// * [SessionUnlocked] – a staff member is signed in.
@freezed
sealed class SessionState with _$SessionState {
  const SessionState._();

  const factory SessionState.needsActivation() = SessionNeedsActivation;

  const factory SessionState.locked({required Business business}) =
      SessionLocked;

  const factory SessionState.unlocked({
    required Business business,
    required AppUser user,
  }) = SessionUnlocked;

  Business? get businessOrNull => switch (this) {
        SessionNeedsActivation() => null,
        SessionLocked(:final business) => business,
        SessionUnlocked(:final business) => business,
      };

  AppUser? get userOrNull => switch (this) {
        SessionUnlocked(:final user) => user,
        _ => null,
      };

  bool get isUnlocked => this is SessionUnlocked;
}

/// Device ↔ business link persisted in secure storage.
@freezed
abstract class DeviceActivation with _$DeviceActivation {
  const factory DeviceActivation({
    required String businessId,
    required String activatedByUserId,
    required DateTime activatedAt,
  }) = _DeviceActivation;
}
