import 'package:flutter/widgets.dart';

/// Window size classes, aligned with Material 3 guidance but tuned for
/// restaurant tablets (iPad / Android tablets in landscape fall into
/// [ScreenSize.medium] or [ScreenSize.expanded]).
enum ScreenSize {
  compact, // phones
  medium, // tablets (portrait & most landscape)
  expanded; // large tablets landscape & desktop

  bool get isCompact => this == ScreenSize.compact;
  bool get isMedium => this == ScreenSize.medium;
  bool get isExpanded => this == ScreenSize.expanded;
  bool get isAtLeastMedium => this != ScreenSize.compact;
}

abstract final class Breakpoints {
  static const double medium = 600;
  static const double expanded = 1200;

  /// Content width above which master/detail layouts are used.
  static const double twoPane = 840;

  static ScreenSize fromWidth(double width) {
    if (width >= expanded) return ScreenSize.expanded;
    if (width >= medium) return ScreenSize.medium;
    return ScreenSize.compact;
  }
}

extension ResponsiveContextX on BuildContext {
  ScreenSize get screenClass =>
      Breakpoints.fromWidth(MediaQuery.sizeOf(this).width);

  bool get isCompact => screenClass.isCompact;
  bool get isTabletUp => screenClass.isAtLeastMedium;

  /// Picks a value based on the current window size class.
  T responsive<T>({required T compact, T? medium, T? expanded}) {
    return switch (screenClass) {
      ScreenSize.compact => compact,
      ScreenSize.medium => medium ?? compact,
      ScreenSize.expanded => expanded ?? medium ?? compact,
    };
  }

  EdgeInsets get pagePadding => responsive(
        compact: const EdgeInsets.all(16),
        medium: const EdgeInsets.all(24),
        expanded: const EdgeInsets.all(28),
      );
}
