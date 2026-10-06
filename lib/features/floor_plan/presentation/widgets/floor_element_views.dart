import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/floor_element.dart';
import '../../domain/entities/floor_enums.dart';
import '../../domain/services/table_geometry.dart';
import 'structure_style.dart';

/// Visual state of a table on the canvas.
class TableVisual {
  const TableVisual({
    this.accent,
    this.caption,
    this.selected = false,
    this.dimmed = false,
  });

  /// Status colour (available / reserved / occupied ...). Null = neutral.
  final Color? accent;

  /// Small text under the label (e.g. "7:30 PM" or "45m").
  final String? caption;
  final bool selected;
  final bool dimmed;
}

/// Renders a table with chairs. Size grows with the seat count.
class TableView extends StatelessWidget {
  const TableView({
    super.key,
    required this.element,
    this.visual = const TableVisual(),
  });

  final FloorElement element;
  final TableVisual visual;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final layout = TableGeometry.layout(element.tableShape, element.seats);
    final accent = visual.accent;
    final selectedColor = context.colors.primary;

    final tableFill = accent == null
        ? palette.tableFill
        : Color.alphaBlend(accent.withValues(alpha: context.isDark ? 0.22 : 0.14), palette.tableFill);
    final border = visual.selected
        ? selectedColor
        : (accent ?? context.colors.outline);
    final chairFill = accent == null
        ? palette.chairFill
        : Color.alphaBlend(accent.withValues(alpha: 0.45), palette.chairFill);

    final painter = CustomPaint(
      size: layout.size,
      painter: _TablePainter(
        layout: layout,
        shape: element.tableShape,
        tableFill: tableFill,
        chairFill: chairFill,
        border: border,
        borderWidth: visual.selected ? 3 : 1.6,
        shadow: context.isDark ? Colors.black54 : const Color(0x22101828),
      ),
    );

    return Opacity(
      opacity: visual.dimmed ? 0.35 : 1,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RotatedBox(quarterTurns: element.isVertical ? 1 : 0, child: painter),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(TableGeometry.margin + 2),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      element.label,
                      style: context.text.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: accent ?? context.colors.onSurface,
                        height: 1.1,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chair_alt_rounded, size: 11, color: palette.textMuted),
                        const SizedBox(width: 2),
                        Text(
                          '${element.seats}',
                          style: context.text.labelSmall?.copyWith(
                            color: palette.textMuted,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    if (visual.caption != null)
                      Text(
                        visual.caption!,
                        style: context.text.labelSmall?.copyWith(
                          color: accent ?? palette.textMuted,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TablePainter extends CustomPainter {
  _TablePainter({
    required this.layout,
    required this.shape,
    required this.tableFill,
    required this.chairFill,
    required this.border,
    required this.borderWidth,
    required this.shadow,
  });

  final TableLayout layout;
  final TableShape shape;
  final Color tableFill;
  final Color chairFill;
  final Color border;
  final double borderWidth;
  final Color shadow;

  @override
  void paint(Canvas canvas, Size size) {
    final chairPaint = Paint()..color = chairFill;
    for (final chair in layout.chairs) {
      canvas
        ..save()
        ..translate(chair.center.dx, chair.center.dy)
        ..rotate(chair.angle);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: TableGeometry.chairWidth,
            height: TableGeometry.chairDepth,
          ),
          const Radius.circular(5),
        ),
        chairPaint,
      );
      canvas.restore();
    }

    final rect = layout.tableRect;
    final fill = Paint()..color = tableFill;
    final stroke = Paint()
      ..color = border
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    final shadowPaint = Paint()
      ..color = shadow
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    if (shape == TableShape.round) {
      final r = rect.width / 2;
      canvas
        ..drawCircle(rect.center.translate(0, 2), r, shadowPaint)
        ..drawCircle(rect.center, r, fill)
        ..drawCircle(rect.center, r - borderWidth / 2, stroke);
    } else {
      final rr = RRect.fromRectAndRadius(rect, Radius.circular(math.min(14, rect.shortestSide * 0.18)));
      canvas
        ..drawRRect(rr.shift(const Offset(0, 2)), shadowPaint)
        ..drawRRect(rr, fill)
        ..drawRRect(rr.deflate(borderWidth / 2), stroke);
    }
  }

  @override
  bool shouldRepaint(covariant _TablePainter old) =>
      old.layout.chairs.length != layout.chairs.length ||
      old.layout.size != layout.size ||
      old.shape != shape ||
      old.tableFill != tableFill ||
      old.chairFill != chairFill ||
      old.border != border ||
      old.borderWidth != borderWidth;
}

/// Renders a non-seating structure (kitchen, bar, wall ...).
class StructureView extends StatelessWidget {
  const StructureView({
    super.key,
    required this.element,
    this.selected = false,
    this.dimmed = false,
  });

  final FloorElement element;
  final bool selected;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final type = element.structureType ?? StructureType.zone;
    final color = type.color;
    final selectedBorder = Border.all(color: context.colors.primary, width: 3);

    Widget child;
    if (type.isLinear) {
      child = Container(
        decoration: BoxDecoration(
          color: type == StructureType.window
              ? color.withValues(alpha: 0.55)
              : (context.isDark ? const Color(0xFF98A2B3) : color),
          borderRadius: BorderRadius.circular(3),
          border: selected ? selectedBorder : null,
        ),
      );
    } else if (type.isRound) {
      child = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: type == StructureType.pillar ? 0.6 : 0.18),
          border: selected ? selectedBorder : Border.all(color: color, width: 1.5),
        ),
        child: type == StructureType.plant
            ? FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(type.icon, color: color),
                ),
              )
            : null,
      );
    } else {
      final isZone = type == StructureType.zone;
      child = Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: isZone ? 0.06 : (context.isDark ? 0.2 : 0.12)),
          borderRadius: BorderRadius.circular(isZone ? 18 : 12),
          border: selected
              ? selectedBorder
              : Border.all(
                  color: color.withValues(alpha: isZone ? 0.45 : 0.8),
                  width: isZone ? 1.5 : 1.6,
                ),
        ),
        padding: const EdgeInsets.all(6),
        child: Align(
          alignment: isZone ? Alignment.topLeft : Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: isZone
                ? Text(
                    element.label.isEmpty ? type.label : element.label,
                    style: context.text.labelLarge?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(type.icon, color: color, size: 26),
                      const SizedBox(height: 2),
                      Text(
                        element.label.isEmpty ? type.label : element.label,
                        textAlign: TextAlign.center,
                        style: context.text.labelMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    }

    return Opacity(opacity: dimmed ? 0.5 : 1, child: child);
  }
}
