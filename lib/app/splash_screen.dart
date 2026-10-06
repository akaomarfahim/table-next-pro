import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/app_config.dart';
import '../core/extensions/context_extensions.dart';
import '../core/theme/app_tokens.dart';
import '../core/widgets/state_views.dart';
import '../features/auth/presentation/controllers/session_controller.dart';

/// Shown while the session is being restored. Displays an error with retry
/// when the business could not be loaded (e.g. first launch while offline).
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);

    return Scaffold(
      body: Center(
        child: session.hasError && !session.isLoading
            ? ErrorState(
                error: session.error!,
                onRetry: () => ref.invalidate(sessionControllerProvider),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [context.colors.primary, context.colors.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: const Icon(
                      Icons.table_restaurant_rounded,
                      color: Colors.white,
                      size: 44,
                    ),
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scaleXY(begin: 0.94, end: 1.04, duration: 900.ms),
                  const SizedBox(height: AppSpacing.xl),
                  Text(AppConfig.appName, style: context.text.headlineSmall),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    AppConfig.appTagline,
                    style: context.text.bodyMedium?.copyWith(
                      color: context.palette.textMuted,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 350.ms),
      ),
    );
  }
}
