import 'package:flutter/material.dart';

import 'breakpoints.dart';

/// Builds a different widget depending on the *available* width (not the
/// screen width) so it composes correctly inside split panes.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
  });

  final WidgetBuilder compact;
  final WidgetBuilder? medium;
  final WidgetBuilder? expanded;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Breakpoints.fromWidth(constraints.maxWidth);
        final builder = switch (size) {
          ScreenSize.expanded => expanded ?? medium ?? compact,
          ScreenSize.medium => medium ?? compact,
          ScreenSize.compact => compact,
        };
        return builder(context);
      },
    );
  }
}

/// Centers [child] and limits its width — keeps forms and lists readable on
/// large screens.
class MaxWidthBox extends StatelessWidget {
  const MaxWidthBox({
    super.key,
    required this.child,
    this.maxWidth = 1280,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final double maxWidth;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

/// Adaptive grid column count based on available width.
int adaptiveColumns(
  double width, {
  double minTileWidth = 260,
  int maxColumns = 6,
}) {
  final count = (width / minTileWidth).floor();
  return count.clamp(1, maxColumns);
}
