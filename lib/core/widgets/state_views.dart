import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../errors/app_exception.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_tokens.dart';

/// Friendly empty state with icon, title, message and optional action.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.action,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: compact ? 56 : 80,
                height: compact ? 56 : 80,
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: compact ? 26 : 36,
                  color: context.colors.primary,
                ),
              ),
              SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
              Text(
                title,
                textAlign: TextAlign.center,
                style: compact ? context.text.titleSmall : context.text.titleMedium,
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.palette.textMuted,
                  ),
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: AppSpacing.lg),
                action!,
              ],
            ],
          ),
        ),
      ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.04, end: 0),
    );
  }
}

/// Error view with retry button.
class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.error, this.onRetry});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final isOffline = mapToAppException(error) is NetworkException;
    return EmptyState(
      icon: isOffline ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
      title: isOffline ? 'You are offline' : 'Something went wrong',
      message: errorMessageOf(error),
      action: onRetry == null
          ? null
          : OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
    );
  }
}

/// Shimmering placeholder box.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.width,
    this.height = 16,
    this.radius = AppRadius.sm,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// List-shaped loading skeleton.
class SkeletonList extends StatelessWidget {
  const SkeletonList({
    super.key,
    this.itemCount = 8,
    this.itemHeight = 64,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  final int itemCount;
  final double itemHeight;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      color: context.isDark ? Colors.white : Colors.grey,
      colorOpacity: context.isDark ? 0.08 : 0.25,
      child: ListView.separated(
        padding: padding,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) => Row(
          children: [
            SkeletonBox(width: itemHeight * 0.7, height: itemHeight * 0.7, radius: 999),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: 140 + (index % 3) * 40, height: 14),
                  const SizedBox(height: AppSpacing.sm),
                  SkeletonBox(width: 90 + (index % 2) * 50, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Grid-shaped loading skeleton.
class SkeletonGrid extends StatelessWidget {
  const SkeletonGrid({
    super.key,
    this.itemCount = 6,
    this.minTileWidth = 220,
    this.tileHeight = 120,
  });

  final int itemCount;
  final double minTileWidth;
  final double tileHeight;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: context.isDark ? Colors.white : Colors.grey,
      colorOpacity: context.isDark ? 0.08 : 0.25,
      child: LayoutBuilder(
        builder: (context, c) {
          final cols = (c.maxWidth / minTileWidth).floor().clamp(1, 6);
          return GridView.builder(
            padding: const EdgeInsets.all(AppSpacing.lg),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              mainAxisExtent: tileHeight,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
            ),
            itemCount: itemCount,
            itemBuilder: (_, _) => const SkeletonBox(height: double.infinity, radius: AppRadius.lg),
          );
        },
      ),
    );
  }
}

/// Renders an [AsyncValue] with consistent loading / error states.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget? loading;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      data: data,
      loading: () =>
          loading ?? const Center(child: CircularProgressIndicator.adaptive()),
      error: (e, _) => ErrorState(error: e, onRetry: onRetry),
    );
  }
}
