import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_tokens.dart';

/// Animated banner shown while the device is offline.
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final online = ref.watch(isOnlineProvider).value ?? true;
    const online = true;
    return AnimatedSize(
      duration: AppDurations.medium,
      curve: Curves.easeOutCubic,
      child: online
          ? const SizedBox(width: double.infinity)
          : Material(
              color: context.palette.warning.withValues(alpha: 0.15),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(Icons.cloud_off_rounded, size: 18, color: context.palette.warning),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'Offline mode — changes are saved on this device and will sync automatically.',
                          style: context.text.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
