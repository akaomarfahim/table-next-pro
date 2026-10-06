import 'dart:math' as math;
import 'dart:ui';

import '../entities/floor_enums.dart';

/// A chair placed around a table, in the table element's local
/// coordinate space (unrotated).
class ChairSpot {
  const ChairSpot({required this.center, required this.angle});

  final Offset center;

  /// Rotation in radians (0 = chair's long edge horizontal).
  final double angle;
}

/// Computed layout of a table: overall element size, the table top
/// rectangle and every chair position.
class TableLayout {
  const TableLayout({
    required this.size,
    required this.tableRect,
    required this.chairs,
  });

  final Size size;
  final Rect tableRect;
  final List<ChairSpot> chairs;
}

/// Pure geometry for tables. The table grows with its seat count, which
/// makes capacity readable at a glance on the floor plan.
abstract final class TableGeometry {
  static const double chairWidth = 22;
  static const double chairDepth = 14;
  static const double chairGap = 5;
  static const double chairPitch = 34;
  static const double margin = chairDepth + chairGap;

  static const int minSeats = 1;
  static const int maxSeats = 30;

  static TableLayout layout(TableShape shape, int seats) {
    final n = seats.clamp(minSeats, maxSeats);
    return switch (shape) {
      TableShape.round => _round(n),
      TableShape.rectangle => _rectangle(n),
      TableShape.square => _square(n),
    };
  }

  /// Element size (before orientation is applied).
  static Size sizeFor(TableShape shape, int seats) => layout(shape, seats).size;

  static TableLayout _round(int n) {
    final diameter = math.max(64.0, n * chairPitch / math.pi + 18);
    final total = diameter + margin * 2;
    final center = Offset(total / 2, total / 2);
    final radius = diameter / 2 + chairGap + chairDepth / 2;
    final chairs = <ChairSpot>[
      for (var i = 0; i < n; i++)
        () {
          final a = (2 * math.pi * i / n) - math.pi / 2;
          return ChairSpot(
            center: center + Offset(math.cos(a) * radius, math.sin(a) * radius),
            angle: a + math.pi / 2,
          );
        }(),
    ];
    return TableLayout(
      size: Size(total, total),
      tableRect: Rect.fromCircle(center: center, radius: diameter / 2),
      chairs: chairs,
    );
  }

  static TableLayout _rectangle(int n) {
    final ends = n >= 8 ? 2 : 0;
    final sides = n - ends;
    final top = (sides / 2).ceil();
    final bottom = sides - top;
    final perSide = math.max(top, 1);
    final tableW = math.max(76.0, perSide * chairPitch + 18);
    final tableH = ends > 0 ? 76.0 : 64.0;
    final rect = Rect.fromLTWH(margin, margin, tableW, tableH);

    final chairs = <ChairSpot>[
      ..._alongHorizontal(rect, top, isTop: true),
      ..._alongHorizontal(rect, bottom, isTop: false),
      if (ends > 0) ...[
        ChairSpot(
          center: Offset(rect.left - chairGap - chairDepth / 2, rect.center.dy),
          angle: math.pi / 2,
        ),
        ChairSpot(
          center: Offset(rect.right + chairGap + chairDepth / 2, rect.center.dy),
          angle: math.pi / 2,
        ),
      ],
    ];
    return TableLayout(
      size: Size(tableW + margin * 2, tableH + margin * 2),
      tableRect: rect,
      chairs: chairs,
    );
  }

  static TableLayout _square(int n) {
    // Distribute round-robin: top, bottom, left, right.
    final counts = [0, 0, 0, 0];
    for (var i = 0; i < n; i++) {
      counts[i % 4]++;
    }
    final maxPerSide = counts.reduce(math.max);
    final side = math.max(76.0, maxPerSide * chairPitch + 18);
    final rect = Rect.fromLTWH(margin, margin, side, side);
    final chairs = <ChairSpot>[
      ..._alongHorizontal(rect, counts[0], isTop: true),
      ..._alongHorizontal(rect, counts[1], isTop: false),
      ..._alongVertical(rect, counts[2], isLeft: true),
      ..._alongVertical(rect, counts[3], isLeft: false),
    ];
    return TableLayout(
      size: Size(side + margin * 2, side + margin * 2),
      tableRect: rect,
      chairs: chairs,
    );
  }

  static Iterable<ChairSpot> _alongHorizontal(
    Rect rect,
    int count, {
    required bool isTop,
  }) sync* {
    final y = isTop
        ? rect.top - chairGap - chairDepth / 2
        : rect.bottom + chairGap + chairDepth / 2;
    for (var i = 0; i < count; i++) {
      final x = rect.left + rect.width * (i + 0.5) / count;
      yield ChairSpot(center: Offset(x, y), angle: 0);
    }
  }

  static Iterable<ChairSpot> _alongVertical(
    Rect rect,
    int count, {
    required bool isLeft,
  }) sync* {
    final x = isLeft
        ? rect.left - chairGap - chairDepth / 2
        : rect.right + chairGap + chairDepth / 2;
    for (var i = 0; i < count; i++) {
      final y = rect.top + rect.height * (i + 0.5) / count;
      yield ChairSpot(center: Offset(x, y), angle: math.pi / 2);
    }
  }
}
