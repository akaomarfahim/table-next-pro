import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../controllers/session_controller.dart';
import '../widgets/pin_pad.dart';

/// PIN lock screen. Any active staff member of the linked business can
/// unlock with their own PIN; the PIN is verified against Firestore.
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  String _pin = '';
  bool _verifying = false;
  int _shakeCount = 0;
  String? _message;
  late Timer _clock;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _clock = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _clock.cancel();
    super.dispose();
  }

  void _onDigit(String d) {
    if (_verifying || _pin.length >= AppConfig.pinLength) return;
    setState(() {
      _pin += d;
      _message = null;
    });
    if (_pin.length == AppConfig.pinLength) _verify();
  }

  void _onBackspace() {
    if (_verifying || _pin.isEmpty) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  Future<void> _verify() async {
    setState(() => _verifying = true);
    try {
      await ref.read(sessionControllerProvider.notifier).unlock(_pin);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _shakeCount++;
        _message = errorMessageOf(e);
        _pin = '';
      });
    } finally {
      if (mounted) setState(() => _verifying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final business = ref.watch(currentBusinessProvider);
    final compact = context.isCompact;
    final shortScreen = MediaQuery.sizeOf(context).height < 700;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.colors.primary.withValues(alpha: context.isDark ? 0.18 : 0.10),
              context.theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Formatters.time(_now),
                    style: context.text.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    Formatters.dayFull(_now),
                    style: context.text.bodyMedium?.copyWith(
                      color: context.palette.textMuted,
                    ),
                  ),
                  SizedBox(height: shortScreen ? AppSpacing.lg : AppSpacing.xxl),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.lock_rounded,
                      color: context.colors.primary,
                      size: 30,
                    ),
                  ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    business?.name ?? AppConfig.appName,
                    style: context.text.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Enter your ${AppConfig.pinLength}-digit PIN',
                    style: context.text.bodyMedium?.copyWith(
                      color: context.palette.textMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PinDots(
                    length: AppConfig.pinLength,
                    filled: _pin.length,
                    shakeCount: _shakeCount,
                    error: _message != null,
                  ),
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: _verifying
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              _message ?? '',
                              textAlign: TextAlign.center,
                              style: context.text.bodySmall?.copyWith(
                                color: context.palette.danger,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  PinPad(
                    enabled: !_verifying,
                    buttonSize: compact || shortScreen ? 68 : 80,
                    onDigit: _onDigit,
                    onBackspace: _onBackspace,
                    onSubmit: () {
                      if (_pin.length == AppConfig.pinLength) _verify();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
