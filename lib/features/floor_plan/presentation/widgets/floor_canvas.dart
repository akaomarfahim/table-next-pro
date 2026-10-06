import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/floor_area.dart';
import '../../domain/entities/floor_element.dart';
import 'floor_element_views.dart';

enum FloorCanvasMode { view, edit }

/// Zoomable, pannable floor plan canvas.
///
/// * [FloorCanvasMode.view] – tap tables (live status, table picker).
/// * [FloorCanvasMode.edit] – drag elements, resize structures.
class FloorCanvas extends StatefulWidget {
  const FloorCanvas({
    super.key,
    required this.floor,
    required this.elements,
    this.mode = FloorCanvasMode.view,
    this.selectedIds = const {},
    this.tableVisual,
    this.onElementTap,
    this.onBackgroundTap,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    this.onResize,
    this.snapToGrid = true,
    this.gridSize = 20,
    this.transformationController,
  });

  final FloorArea floor;
  final List<FloorElement> elements;
  final FloorCanvasMode mode;
  final Set<String> selectedIds;
  final TableVisual Function(FloorElement table)? tableVisual;
  final ValueChanged<FloorElement>? onElementTap;
  final VoidCallback? onBackgroundTap;
  final ValueChanged<String>? onDragStart;
  final void Function(String id, Offset topLeft)? onDragUpdate;
  final ValueChanged<String>? onDragEnd;
  final void Function(String id, Size size)? onResize;
  final bool snapToGrid;
  final double gridSize;
  final TransformationController? transformationController;

  @override
  State<FloorCanvas> createState() => FloorCanvasState();
}

class FloorCanvasState extends State<FloorCanvas> {
  final GlobalKey _canvasKey = GlobalKey();
  late TransformationController _controller =
      widget.transformationController ?? TransformationController();
  Offset _grabOffset = Offset.zero;
  Size _resizeStart = Size.zero;
  Offset _resizeOrigin = Offset.zero;
  Size? _viewport;
  String? _fittedFloorId;

  bool get _editing => widget.mode == FloorCanvasMode.edit;

  @override
  void didUpdateWidget(covariant FloorCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.transformationController != null &&
        widget.transformationController != _controller) {
      _controller = widget.transformationController!;
    }
    if (oldWidget.floor.id != widget.floor.id) _fittedFloorId = null;
  }

  @override
  void dispose() {
    if (widget.transformationController == null) _controller.dispose();
    super.dispose();
  }

  /// Fits the entire canvas inside the viewport.
  void fitToScreen() {
    final viewport = _viewport;
    if (viewport == null) return;
    final scale = (viewport.width / widget.floor.width)
        .clamp(0.1, 4.0)
        .toDouble();
    final scaleY = (viewport.height / widget.floor.height).clamp(0.1, 4.0).toDouble();
    final s = (scale < scaleY ? scale : scaleY) * 0.96;
    final dx = (viewport.width - widget.floor.width * s) / 2;
    final dy = (viewport.height - widget.floor.height * s) / 2;
    _controller.value = Matrix4.identity()
      ..translateByDouble(dx, dy, 0, 1)
      ..scaleByDouble(s, s, 1, 1);
  }

  void zoomBy(double factor) {
    final viewport = _viewport;
    if (viewport == null) return;
    final focal = Offset(viewport.width / 2, viewport.height / 2);
    final m = _controller.value.clone();
    final current = m.getMaxScaleOnAxis();
    final target = (current * factor).clamp(0.2, 3.0);
    final f = target / current;
    _controller.value = Matrix4.identity()
      ..translateByDouble(focal.dx, focal.dy, 0, 1)
      ..scaleByDouble(f, f, 1, 1)
      ..translateByDouble(-focal.dx, -focal.dy, 0, 1)
      ..multiply(m);
  }

  Offset _toCanvas(Offset global) {
    final box = _canvasKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.globalToLocal(global) ?? Offset.zero;
  }

  Offset _snap(Offset p) {
    if (!widget.snapToGrid) return p;
    final g = widget.gridSize / 2;
    return Offset((p.dx / g).roundToDouble() * g, (p.dy / g).roundToDouble() * g);
  }

  Offset _clamp(Offset p, Size size) => Offset(
        p.dx.clamp(0, (widget.floor.width - size.width).clamp(0, double.infinity)).toDouble(),
        p.dy.clamp(0, (widget.floor.height - size.height).clamp(0, double.infinity)).toDouble(),
      );

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final sorted = [...widget.elements]..sort((a, b) => a.layer.compareTo(b.layer));

    return LayoutBuilder(
      builder: (context, constraints) {
        _viewport = constraints.biggest;
        if (_fittedFloorId != widget.floor.id &&
            constraints.maxWidth.isFinite &&
            constraints.maxHeight.isFinite) {
          _fittedFloorId = widget.floor.id;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) fitToScreen();
          });
        }
        return ClipRect(
          child: ColoredBox(
            color: context.theme.scaffoldBackgroundColor,
            child: InteractiveViewer(
              transformationController: _controller,
              constrained: false,
              minScale: 0.2,
              maxScale: 3,
              boundaryMargin: const EdgeInsets.all(600),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: widget.onBackgroundTap,
                child: SizedBox(
                  key: _canvasKey,
                  width: widget.floor.width,
                  height: widget.floor.height,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: palette.canvas,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: palette.border, width: 2),
                          ),
                          child: CustomPaint(
                            painter: _GridPainter(
                              color: palette.canvasGrid,
                              step: widget.gridSize,
                              show: _editing,
                            ),
                          ),
                        ),
                      ),
                      for (final e in sorted) _buildElement(context, e),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildElement(BuildContext context, FloorElement e) {
    final size = e.size;
    final selected = widget.selectedIds.contains(e.id);

    Widget content = e.isTable
        ? TableView(
            element: e,
            visual: widget.tableVisual?.call(e) ?? TableVisual(selected: selected),
          )
        : StructureView(element: e, selected: selected && _editing);

    if (_editing && selected && e.isStructure) {
      content = Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: content),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: (d) {
                _resizeStart = size;
                _resizeOrigin = _toCanvas(d.globalPosition);
                widget.onDragStart?.call(e.id);
              },
              onPanUpdate: (d) {
                final delta = _toCanvas(d.globalPosition) - _resizeOrigin;
                var w = _resizeStart.width + delta.dx;
                var h = _resizeStart.height + delta.dy;
                if (widget.snapToGrid) {
                  final g = widget.gridSize / 2;
                  w = (w / g).roundToDouble() * g;
                  h = (h / g).roundToDouble() * g;
                }
                widget.onResize?.call(e.id, Size(w.clamp(8.0, 2000.0), h.clamp(8.0, 2000.0)));
              },
              onPanEnd: (_) => widget.onDragEnd?.call(e.id),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: const Icon(Icons.open_in_full_rounded, size: 13, color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    return AnimatedPositioned(
      key: ValueKey(e.id),
      duration: _editing ? Duration.zero : const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      left: e.x,
      top: e.y,
      width: size.width,
      height: size.height,
      child: MouseRegion(
        cursor: _editing ? SystemMouseCursors.move : SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => widget.onElementTap?.call(e),
          onPanStart: _editing
              ? (d) {
                  _grabOffset = _toCanvas(d.globalPosition) - Offset(e.x, e.y);
                  widget.onElementTap?.call(e);
                  widget.onDragStart?.call(e.id);
                }
              : null,
          onPanUpdate: _editing
              ? (d) {
                  final raw = _toCanvas(d.globalPosition) - _grabOffset;
                  widget.onDragUpdate?.call(e.id, _clamp(_snap(raw), size));
                }
              : null,
          onPanEnd: _editing ? (_) => widget.onDragEnd?.call(e.id) : null,
          child: content,
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color, required this.step, required this.show});

  final Color color;
  final double step;
  final bool show;

  @override
  void paint(Canvas canvas, Size size) {
    if (!show) {
      // Subtle dot grid in view mode.
      final dot = Paint()..color = color;
      for (var x = step * 2; x < size.width; x += step * 2) {
        for (var y = step * 2; y < size.height; y += step * 2) {
          canvas.drawCircle(Offset(x, y), 1.2, dot);
        }
      }
      return;
    }
    final minor = Paint()
      ..color = color
      ..strokeWidth = 0.6;
    final major = Paint()
      ..color = color
      ..strokeWidth = 1.4;
    var i = 0;
    for (var x = 0.0; x <= size.width; x += step, i++) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), i % 5 == 0 ? major : minor);
    }
    i = 0;
    for (var y = 0.0; y <= size.height; y += step, i++) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), i % 5 == 0 ? major : minor);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) =>
      old.color != color || old.step != step || old.show != show;
}
