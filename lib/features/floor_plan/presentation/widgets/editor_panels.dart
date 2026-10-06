import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/floor_element.dart';
import '../../domain/entities/floor_enums.dart';
import '../controllers/floor_editor_controller.dart';
import 'structure_style.dart';

/// Palette of things that can be added to the floor.
class ElementPalette extends ConsumerStatefulWidget {
  const ElementPalette({super.key, this.onAdded});

  /// Called after an element is added (used to close sheets on phones).
  final VoidCallback? onAdded;

  @override
  ConsumerState<ElementPalette> createState() => _ElementPaletteState();
}

class _ElementPaletteState extends ConsumerState<ElementPalette> {
  int _seats = 4;

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(floorEditorControllerProvider.notifier);

    Widget tableTile(TableShape shape, IconData icon) => _PaletteTile(
          icon: icon,
          label: shape.label,
          color: context.colors.primary,
          onTap: () {
            controller.addTable(shape, _seats);
            widget.onAdded?.call();
          },
        );

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Tables', style: context.text.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: Text(
                'Seats for new table',
                style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
              ),
            ),
            QuantityStepper(
              value: _seats,
              min: 1,
              max: 30,
              compact: true,
              onChanged: (v) => setState(() => _seats = v),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          children: [
            tableTile(TableShape.round, Icons.circle_outlined),
            tableTile(TableShape.rectangle, Icons.rectangle_outlined),
            tableTile(TableShape.square, Icons.crop_square_rounded),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        Text('Structures', style: context.text.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          children: [
            for (final type in StructureType.values)
              _PaletteTile(
                icon: type.icon,
                label: type.label,
                color: type.color,
                onTap: () {
                  controller.addStructure(type);
                  widget.onAdded?.call();
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _PaletteTile extends StatelessWidget {
  const _PaletteTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Add $label',
      child: Material(
        color: color.withValues(alpha: context.isDark ? 0.14 : 0.08),
        borderRadius: AppRadius.mdAll,
        child: InkWell(
          borderRadius: AppRadius.mdAll,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Properties of the selected element.
class ElementInspector extends ConsumerStatefulWidget {
  const ElementInspector({super.key, required this.element});

  final FloorElement element;

  @override
  ConsumerState<ElementInspector> createState() => _ElementInspectorState();
}

class _ElementInspectorState extends ConsumerState<ElementInspector> {
  late final TextEditingController _label =
      TextEditingController(text: widget.element.label);
  String? _labelError;

  @override
  void didUpdateWidget(covariant ElementInspector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.element.id != widget.element.id) {
      _label.text = widget.element.label;
      _labelError = null;
    }
  }

  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  void _commitLabel() {
    final controller = ref.read(floorEditorControllerProvider.notifier);
    final e = widget.element;
    final text = _label.text.trim();
    if (text == e.label) return;
    if (e.isTable) {
      final error = controller.validateLabel(e.id, text);
      setState(() => _labelError = error);
      if (error != null) return;
    }
    controller.update(e.copyWith(label: text));
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.element;
    final controller = ref.read(floorEditorControllerProvider.notifier);
    const gap = SizedBox(height: AppSpacing.lg);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Row(
          children: [
            Icon(
              e.isTable ? Icons.table_restaurant_rounded : (e.structureType?.icon ?? Icons.category),
              color: e.isTable ? context.colors.primary : e.structureType?.color,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                e.isTable ? 'Table' : (e.structureType?.label ?? 'Structure'),
                style: context.text.titleMedium,
              ),
            ),
          ],
        ),
        gap,
        Focus(
          onFocusChange: (focused) {
            if (!focused) _commitLabel();
          },
          child: TextField(
            controller: _label,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: e.isTable ? 'Table label' : 'Label',
              errorText: _labelError,
              isDense: true,
            ),
            onSubmitted: (_) => _commitLabel(),
          ),
        ),
        gap,
        if (e.isTable) ...[
          Text('Shape', style: context.text.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<TableShape>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: TableShape.round, icon: Icon(Icons.circle_outlined), label: Text('Round')),
              ButtonSegment(value: TableShape.rectangle, icon: Icon(Icons.rectangle_outlined), label: Text('Rect')),
              ButtonSegment(value: TableShape.square, icon: Icon(Icons.crop_square_rounded), label: Text('Square')),
            ],
            selected: {e.tableShape},
            onSelectionChanged: (s) => controller.update(e.copyWith(tableShape: s.first)),
          ),
          gap,
          Row(
            children: [
              Expanded(child: Text('Chairs', style: context.text.labelLarge)),
              QuantityStepper(
                value: e.seats,
                min: 1,
                max: 30,
                onChanged: (v) => controller.update(e.copyWith(seats: v)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'The table grows automatically with the number of chairs.',
            style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
          ),
          if (e.tableShape == TableShape.rectangle) ...[
            gap,
            Row(
              children: [
                Expanded(child: Text('Orientation', style: context.text.labelLarge)),
                SegmentedButton<bool>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(value: false, icon: Icon(Icons.swap_horiz_rounded)),
                    ButtonSegment(value: true, icon: Icon(Icons.swap_vert_rounded)),
                  ],
                  selected: {e.isVertical},
                  onSelectionChanged: (_) => controller.rotateSelected(),
                ),
              ],
            ),
          ],
        ] else ...[
          Text('Type', style: context.text.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          DropdownButtonFormField<StructureType>(
            key: ValueKey(e.id),
            initialValue: e.structureType,
            isDense: true,
            decoration: const InputDecoration(isDense: true),
            items: [
              for (final t in StructureType.values)
                DropdownMenuItem(
                  value: t,
                  child: Row(
                    children: [
                      Icon(t.icon, size: 18, color: t.color),
                      const SizedBox(width: AppSpacing.sm),
                      Text(t.label),
                    ],
                  ),
                ),
            ],
            onChanged: (t) {
              if (t == null) return;
              final wasDefaultLabel =
                  e.label.isEmpty || e.label == e.structureType?.label;
              controller.update(
                e.copyWith(structureType: t, label: wasDefaultLabel ? t.label : e.label),
              );
              if (wasDefaultLabel) _label.text = t.label;
            },
          ),
          gap,
          _DimensionSlider(
            label: 'Width',
            value: e.width,
            onChanged: (v) => controller.update(e.copyWith(width: v), recordUndo: false),
            onChangeStart: controller.beginInteraction,
          ),
          _DimensionSlider(
            label: 'Height',
            value: e.height,
            onChanged: (v) => controller.update(e.copyWith(height: v), recordUndo: false),
            onChangeStart: controller.beginInteraction,
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: controller.rotateSelected,
            icon: const Icon(Icons.rotate_90_degrees_cw_rounded),
            label: const Text('Rotate 90°'),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        const Divider(),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: controller.duplicateSelected,
                icon: const Icon(Icons.copy_rounded, size: 18),
                label: const Text('Duplicate'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.palette.danger,
                  side: BorderSide(color: context.palette.danger.withValues(alpha: 0.5)),
                ),
                onPressed: controller.deleteSelected,
                icon: const Icon(Icons.delete_outline_rounded, size: 18),
                label: const Text('Delete'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Position ${e.x.round()}, ${e.y.round()} · Size ${e.size.width.round()}×${e.size.height.round()}',
          style: context.text.labelSmall?.copyWith(color: context.palette.textMuted),
        ),
      ],
    );
  }
}

class _DimensionSlider extends StatelessWidget {
  const _DimensionSlider({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.onChangeStart,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final VoidCallback onChangeStart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 56, child: Text(label, style: context.text.labelLarge)),
        Expanded(
          child: Slider(
            value: value.clamp(8.0, 800.0),
            min: 8,
            max: 800,
            divisions: 158,
            label: value.round().toString(),
            onChangeStart: (_) => onChangeStart(),
            onChanged: (v) => onChanged(v.roundToDouble()),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            value.round().toString(),
            textAlign: TextAlign.end,
            style: context.text.labelMedium,
          ),
        ),
      ],
    );
  }
}
