import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/app_tokens.dart';

/// Split layout for authentication screens: a branded hero panel on
/// tablets/desktop and a compact header on phones.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.child,
    this.heroTitle = 'Run your floor\nwith confidence.',
    this.heroSubtitle =
        'Reservations, live table status, customers and billing — in sync across every device.',
  });

  final Widget child;
  final String heroTitle;
  final String heroSubtitle;

  @override
  Widget build(BuildContext context) {
    final form = Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: child.animate().fadeIn(duration: 350.ms).slideY(begin: 0.03, end: 0),
        ),
      ),
    );

    if (context.isCompact) {
      return Scaffold(body: SafeArea(child: form));
    }

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: context.screenClass.isExpanded ? 6 : 5,
            child: _HeroPanel(title: heroTitle, subtitle: heroSubtitle),
          ),
          Expanded(flex: 5, child: SafeArea(child: form)),
        ],
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: context.isDark
              ? const [Color(0xFF2A1208), Color(0xFF0B2B26)]
              : const [Color(0xFFE35D2F), Color(0xFFB8401A), Color(0xFF0F7A68)],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -80,
            top: -60,
            child: _Blob(size: 320, opacity: 0.10),
          ),
          const Positioned(
            left: -60,
            bottom: -80,
            child: _Blob(size: 280, opacity: 0.08),
          ),
          // Decorative tables
          const Positioned(right: 60, bottom: 140, child: _GhostTable(size: 120, round: true)),
          const Positioned(right: 210, bottom: 70, child: _GhostTable(size: 90, round: false)),
          const Positioned(right: 140, top: 160, child: _GhostTable(size: 70, round: true)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl + 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.table_restaurant_rounded, color: Colors.white),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        AppConfig.appName,
                        style: context.text.titleLarge?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: context.text.displaySmall?.copyWith(
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.04, end: 0),
                  const SizedBox(height: AppSpacing.lg),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Text(
                      subtitle,
                      style: context.text.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                        height: 1.5,
                      ),
                    ),
                  ).animate().fadeIn(delay: 150.ms, duration: 500.ms),
                  const SizedBox(height: AppSpacing.xxl),
                  const Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _FeatureChip(icon: Icons.event_available_rounded, label: 'Reservations'),
                      _FeatureChip(icon: Icons.grid_view_rounded, label: 'Floor plans'),
                      _FeatureChip(icon: Icons.receipt_long_rounded, label: 'Billing'),
                      _FeatureChip(icon: Icons.cloud_sync_rounded, label: 'Realtime sync'),
                    ],
                  ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}

class _GhostTable extends StatelessWidget {
  const _GhostTable({required this.size, required this.round});

  final double size;
  final bool round;

  @override
  Widget build(BuildContext context) {
    final color = Colors.white.withValues(alpha: 0.16);
    return Container(
      width: size,
      height: round ? size : size * 0.6,
      decoration: BoxDecoration(
        color: color,
        shape: round ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: round ? null : BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25), width: 2),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: 0, end: -8, duration: 2400.ms, curve: Curves.easeInOut);
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: context.text.labelMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
