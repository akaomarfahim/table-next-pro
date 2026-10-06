import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../domain/entities/floor_area.dart';
import '../controllers/floor_providers.dart';

/// Horizontal list of floor chips.
class FloorTabs extends ConsumerWidget {
  const FloorTabs({
    super.key,
    required this.floors,
    required this.selectedId,
    this.onSelected,
    this.trailing,
  });

  final List<FloorArea> floors;
  final String? selectedId;
  final ValueChanged<FloorArea>? onSelected;
  final Widget? trailing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final f in floors)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: ChoiceChip(
                avatar: Icon(
                  Icons.layers_rounded,
                  size: 16,
                  color: f.id == selectedId ? context.colors.primary : context.palette.textMuted,
                ),
                label: Text(f.name),
                selected: f.id == selectedId,
                showCheckmark: false,
                onSelected: (_) {
                  if (onSelected != null) {
                    onSelected!(f);
                  } else {
                    ref.read(selectedFloorIdProvider.notifier).select(f.id);
                  }
                },
              ),
            ),
          ?trailing,
        ],
      ),
    );
  }
}

/// Canvas size presets for a floor.
enum CanvasPreset {
  small('Small', 1200, 800),
  medium('Medium', 1600, 1000),
  large('Large', 2200, 1400),
  xl('Extra large', 3000, 1800);

  const CanvasPreset(this.label, this.width, this.height);

  final String label;
  final double width;
  final double height;
}
