import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../floor_plan/domain/entities/floor_area.dart';
import '../../../floor_plan/domain/entities/floor_element.dart';
import '../../../floor_plan/presentation/controllers/floor_providers.dart';
import '../../../floor_plan/presentation/widgets/floor_canvas.dart';
import '../../../floor_plan/presentation/widgets/floor_element_views.dart';
import '../../../floor_plan/presentation/widgets/floor_selector.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/services/table_availability.dart';

/// Visual table selection on the floor plan (or as a list on phones).
/// Tables booked in the requested time window are disabled.
class TablePickerDialog extends ConsumerStatefulWidget {
  const TablePickerDialog({
    super.key,
    required this.partySize,
    required this.conflicts,
    required this.initialSelection,
    required this.windowLabel,
  });

  final int partySize;
  final Map<String, Reservation> conflicts;
  final Set<String> initialSelection;
  final String windowLabel;

  static Future<Set<String>?> show(
    BuildContext context, {
    required int partySize,
    required Map<String, Reservation> conflicts,
    required Set<String> initialSelection,
    required String windowLabel,
  }) {
    final dialog = TablePickerDialog(
      partySize: partySize,
      conflicts: conflicts,
      initialSelection: initialSelection,
      windowLabel: windowLabel,
    );
    if (context.isCompact) {
      return Navigator.of(context).push<Set<String>>(
        MaterialPageRoute(fullscreenDialog: true, builder: (_) => dialog),
      );
    }
    return showDialog<Set<String>>(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.all(AppSpacing.xl),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: MediaQuery.sizeOf(ctx).width * 0.92,
          height: MediaQuery.sizeOf(ctx).height * 0.88,
          child: dialog,
        ),
      ),
    );
  }

  @override
  ConsumerState<TablePickerDialog> createState() => _TablePickerDialogState();
}

class _TablePickerDialogState extends ConsumerState<TablePickerDialog> {
  late Set<String> _selected = {...widget.initialSelection};
  String? _floorId;
  late bool _mapView = !context.isCompact;

  void _toggle(FloorElement t) {
    if (!t.isTable || widget.conflicts.containsKey(t.id)) return;
    setState(() {
      _selected = _selected.contains(t.id)
          ? (_selected.toSet()..remove(t.id))
          : {..._selected, t.id};
    });
  }

  void _autoAssign(List<FloorElement> tables) {
    final suggestion = TableAvailability.suggest(
      tables: tables,
      unavailableIds: widget.conflicts.keys.toSet(),
      partySize: widget.partySize,
    );
    if (suggestion.isEmpty) {
      context.showSnack('No free table combination seats ${widget.partySize}.', error: true);
      return;
    }
    setState(() {
      _selected = suggestion.map((t) => t.id).toSet();
      _floorId = suggestion.first.floorId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final floors = ref.watch(floorsProvider).value ?? const <FloorArea>[];
    final elements = ref.watch(floorElementsProvider).value ?? const <FloorElement>[];
    final tables = elements.where((e) => e.isTable).toList()
      ..sort((a, b) => naturalCompare(a.label, b.label));
    final seats = tables
        .where((t) => _selected.contains(t.id))
        .fold<int>(0, (s, t) => s + t.seats);
    final enough = seats >= widget.partySize;

    FloorArea? floor;
    if (floors.isNotEmpty) {
      floor = floors.firstWhere(
        (f) => f.id == _floorId,
        orElse: () => floors.firstWhere(
          (f) => tables.any((t) => t.floorId == f.id && _selected.contains(t.id)),
          orElse: () => floors.first,
        ),
      );
    }

    TableVisual visual(FloorElement t) {
      final conflict = widget.conflicts[t.id];
      if (conflict != null) {
        return TableVisual(
          accent: context.palette.tableUnavailable,
          caption: 'Booked ${Formatters.time(conflict.startAt)}',
          dimmed: true,
        );
      }
      if (_selected.contains(t.id)) {
        return TableVisual(accent: context.palette.tableSelected, caption: 'Selected', selected: true);
      }
      return TableVisual(
        accent: t.seats >= widget.partySize ? context.palette.tableAvailable : null,
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select tables'),
            Text(
              '${widget.partySize} guests · ${widget.windowLabel}',
              style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: _mapView ? 'List view' : 'Map view',
            onPressed: () => setState(() => _mapView = !_mapView),
            icon: Icon(_mapView ? Icons.view_list_rounded : Icons.map_rounded),
          ),
          IconButton(
            tooltip: 'Close',
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      body: tables.isEmpty
          ? const EmptyState(
              icon: Icons.table_restaurant_rounded,
              title: 'No tables configured',
              message: 'Create tables in the floor plan editor first.',
            )
          : Column(
              children: [
                if (_mapView && floors.length > 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: FloorTabs(
                      floors: floors,
                      selectedId: floor?.id,
                      onSelected: (f) => setState(() => _floorId = f.id),
                    ),
                  ),
                Expanded(
                  child: _mapView && floor != null
                      ? FloorCanvas(
                          floor: floor,
                          elements: elements.where((e) => e.floorId == floor!.id).toList(),
                          selectedIds: _selected,
                          tableVisual: visual,
                          onElementTap: _toggle,
                        )
                      : _TableList(
                          tables: tables,
                          floors: floors,
                          selected: _selected,
                          conflicts: widget.conflicts,
                          partySize: widget.partySize,
                          onTap: _toggle,
                        ),
                ),
              ],
            ),
      bottomNavigationBar: Material(
        color: context.colors.surface,
        elevation: 8,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selected.isEmpty
                            ? 'No table selected'
                            : tables
                                .where((t) => _selected.contains(t.id))
                                .map((t) => t.label)
                                .join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.text.titleSmall,
                      ),
                      Text(
                        '$seats of ${widget.partySize} seats',
                        style: context.text.bodySmall?.copyWith(
                          color: _selected.isEmpty
                              ? context.palette.textMuted
                              : (enough ? context.palette.success : context.palette.warning),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _autoAssign(tables),
                  icon: const Icon(Icons.auto_awesome_rounded),
                  label: Text(context.isCompact ? 'Auto' : 'Auto-assign'),
                ),
                const SizedBox(width: AppSpacing.sm),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(_selected),
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TableList extends StatelessWidget {
  const _TableList({
    required this.tables,
    required this.floors,
    required this.selected,
    required this.conflicts,
    required this.partySize,
    required this.onTap,
  });

  final List<FloorElement> tables;
  final List<FloorArea> floors;
  final Set<String> selected;
  final Map<String, Reservation> conflicts;
  final int partySize;
  final ValueChanged<FloorElement> onTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        for (final floor in floors) ...[
          if (tables.any((t) => t.floorId == floor.id)) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm, top: AppSpacing.sm),
              child: Text(floor.name, style: context.text.titleSmall),
            ),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final t in tables.where((t) => t.floorId == floor.id))
                  _TableChip(
                    table: t,
                    selected: selected.contains(t.id),
                    conflict: conflicts[t.id],
                    fits: t.seats >= partySize,
                    onTap: () => onTap(t),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ],
    );
  }
}

class _TableChip extends StatelessWidget {
  const _TableChip({
    required this.table,
    required this.selected,
    required this.conflict,
    required this.fits,
    required this.onTap,
  });

  final FloorElement table;
  final bool selected;
  final Reservation? conflict;
  final bool fits;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final disabled = conflict != null;
    final color = disabled
        ? context.palette.tableUnavailable
        : selected
            ? context.palette.tableSelected
            : (fits ? context.palette.tableAvailable : context.palette.textMuted);
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Material(
        color: selected ? color.withValues(alpha: 0.14) : context.colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdAll,
          side: BorderSide(color: selected ? color : context.palette.border, width: selected ? 2 : 1),
        ),
        child: InkWell(
          borderRadius: AppRadius.mdAll,
          onTap: disabled ? null : onTap,
          child: SizedBox(
            width: 96,
            height: 76,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(table.label, style: context.text.titleMedium?.copyWith(color: color, fontWeight: FontWeight.w800)),
                Text(
                  disabled ? 'Booked ${Formatters.time(conflict!.startAt)}' : '${table.seats} seats',
                  style: context.text.labelSmall?.copyWith(color: context.palette.textMuted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
