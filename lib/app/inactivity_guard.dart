import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/device_settings.dart';
import '../features/auth/presentation/controllers/session_controller.dart';

/// Locks the session after a period without user interaction.
class InactivityGuard extends ConsumerStatefulWidget {
  const InactivityGuard({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<InactivityGuard> createState() => _InactivityGuardState();
}

class _InactivityGuardState extends ConsumerState<InactivityGuard>
    with WidgetsBindingObserver {
  Timer? _timer;
  DateTime _lastActivity = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _restart();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When returning from background, lock immediately if the timeout
    // elapsed while the app was suspended (timers do not fire then).
    if (state == AppLifecycleState.resumed) {
      final minutes = ref.read(autoLockMinutesProvider);
      if (minutes > 0 &&
          DateTime.now().difference(_lastActivity) >= Duration(minutes: minutes)) {
        ref.read(sessionControllerProvider.notifier).lock();
      }
      _restart();
    }
  }

  void _onActivity() {
    _lastActivity = DateTime.now();
    _restart();
  }

  void _restart() {
    _timer?.cancel();
    final minutes = ref.read(autoLockMinutesProvider);
    final unlocked = ref.read(currentUserProvider) != null;
    if (minutes <= 0 || !unlocked) return;
    _timer = Timer(Duration(minutes: minutes), () {
      if (!mounted) return;
      ref.read(sessionControllerProvider.notifier).lock();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(autoLockMinutesProvider, (_, _) => _restart());
    ref.listen(currentUserProvider, (_, _) => _onActivity());
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _onActivity(),
      onPointerSignal: (_) => _onActivity(),
      child: widget.child,
    );
  }
}
