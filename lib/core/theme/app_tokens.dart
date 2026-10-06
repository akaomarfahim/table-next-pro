import 'package:flutter/material.dart';

/// Spacing scale (4pt grid).
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  static const EdgeInsets pagePaddingCompact = EdgeInsets.all(lg);
  static const EdgeInsets pagePaddingRegular = EdgeInsets.all(xl);
}

/// Corner radius scale.
abstract final class AppRadius {
  static const double xs = 6;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;

  static BorderRadius get smAll => BorderRadius.circular(sm);
  static BorderRadius get mdAll => BorderRadius.circular(md);
  static BorderRadius get lgAll => BorderRadius.circular(lg);
  static BorderRadius get xlAll => BorderRadius.circular(xl);
}

/// Animation durations.
abstract final class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
}

/// Raw brand colours. Prefer `Theme.of(context).colorScheme` and
/// [AppPalette] in widgets; these exist to build the themes.
abstract final class AppColors {
  // Brand
  static const Color brand = Color(0xFFE35D2F);
  static const Color brandLight = Color(0xFFFF8B5E);
  static const Color teal = Color(0xFF14A38B);
  static const Color tealLight = Color(0xFF3DD5B9);

  // Light neutrals
  static const Color lightBackground = Color(0xFFF4F5F7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceLow = Color(0xFFF9FAFB);
  static const Color lightSurfaceHigh = Color(0xFFEEF0F3);
  static const Color lightOutline = Color(0xFFE3E6EB);
  static const Color lightText = Color(0xFF101828);
  static const Color lightTextMuted = Color(0xFF667085);

  // Dark neutrals
  static const Color darkBackground = Color(0xFF0B0D12);
  static const Color darkSurface = Color(0xFF13161D);
  static const Color darkSurfaceLow = Color(0xFF181B23);
  static const Color darkSurfaceHigh = Color(0xFF20242E);
  static const Color darkOutline = Color(0xFF2A2F3A);
  static const Color darkText = Color(0xFFF2F4F7);
  static const Color darkTextMuted = Color(0xFF98A2B3);

  // Semantic
  static const Color success = Color(0xFF12B76A);
  static const Color warning = Color(0xFFF79009);
  static const Color danger = Color(0xFFF04438);
  static const Color info = Color(0xFF2E90FA);
  static const Color violet = Color(0xFF7A5AF8);
  static const Color slate = Color(0xFF667085);
}
