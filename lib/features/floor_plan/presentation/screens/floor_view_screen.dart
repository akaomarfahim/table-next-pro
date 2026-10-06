import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../auth/domain/entities/user_role.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../domain/entities/floor_element.dart';
import '../controllers/floor_providers.dart';
import '../controllers/table_status_provider.dart';
import '../widgets/floor_canvas.dart';
import '../widgets/floor_element_views.dart';
import '../widgets/floor_selector.dart';
import '../widgets/table_details_panel.dart';

/// Live floor: every table coloured by its realtime status.
class FloorViewScreen extends ConsumerStatefulWidget {
  const FloorViewScreen({super.key});

  @override
  ConsumerState<FloorViewScreen> createState() => _FloorViewScreenState();
}

class _FloorViewScreenState extends ConsumerState<FloorViewScreen> {
  String? _selectedTableId;
  final _canvasKey = GlobalKey<FloorCanvasState>();

  void _onTableTap(FloorElement table) {
    if (!table.isTable) return;
    if (context.isTabletUp) {
      setState(() => _selectedTableId = table.id);
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => SizedBox(
        height: MediaQuery.sizeOf(ctx).height * 0.75,
        child: TableDetailsPanel(table: table),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final floorsAsync = ref.watch(floorsProvider);
    final elementsAsync = ref.watch(floorElementsProvider);
    final floor = ref.watch(activeFloorProvider);
    final statuses = ref.watch(tableStatusesProvider);
    final canEdit = ref.watch(hasPermissionProvider(Permission.editFloorPlan));

    final elements = elementsAsync.value ?? const <FloorElement>[];
    final tables = elements.where((e) => e.isTable).toList();
    var available = 0, reserved = 0, occupied = 0;
    for (final t in tables) {
      switch (statuses[t.id]?.status ?? TableStatus.available) {
        case TableStatus.available:
          available++;
        case TableStatus.reserved:
          reserved++;
        case TableStatus.occupied:
          occupied++;
      }
    }

    FloorElement? selected;
    for (final t in tables) {
      if (t.id == _selectedTableId) selected = t;
    }

    final header = Padding(
      padding: context.pagePadding.copyWith(bottom: AppSpacing.md),
      child: PageHeader(
        title: 'Live floor',
        subtitle: '$available available · $reserved reserved · $occupied occupied',
        actions: [
          if (canEdit)
            OutlinedButton.icon(
              onPressed: () => context.push(AppRoutes.floorEditor),
              icon: const Icon(Icons.edit_location_alt_rounded),
              label: const Text('Edit layout'),
            ),
          FilledButton.icon(
            onPressed: () => context.go(AppRoutes.newReservation),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Reservation'),
          ),
        ],
      ),
    );

    Widget body;
    if (floorsAsync.isLoading && !floorsAsync.hasValue) {
      body = const SkeletonGrid(itemCount: 4, minTileWidth: 400, tileHeight: 260);
    } else if (floorsAsync.hasError) {
      body = ErrorState(
        error: floorsAsync.error!,
        onRetry: () => ref.invalidate(floorsProvider),
      );
    } else if (floor == null) {
      body = EmptyState(
        icon: Icons.table_restaurant_rounded,
        title: 'No floor plan yet',
        message: 'Design your dining room: add tables with chairs, the kitchen, bar and register.',
        action: canEdit
            ? FilledButton.icon(
                onPressed: () => context.push(AppRoutes.floorEditor),
                icon: const Icon(Icons.design_services_rounded),
                label: const Text('Open floor editor'),
              )
            : null,
      );
    } else {
      final floorElements = elements.where((e) => e.floorId == floor.id).toList();
      final now = DateTime.now();
      final canvas = Stack(
        children: [
          Positioned.fill(
            child: FloorCanvas(
              key: _canvasKey,
              floor: floor,
              elements: floorElements,
              selectedIds: {?_selectedTableId},
              onElementTap: _onTableTap,
              onBackgroundTap: () => setState(() => _selectedTableId = null),
              tableVisual: (t) {
                final live = statuses[t.id];
                final status = live?.status ?? TableStatus.available;
                String? caption;
                if (live?.bill?.createdAt != null) {
                  caption = Formatters.duration(now.difference(live!.bill!.createdAt!));
                } else if (live?.currentReservation != null) {
                  caption = Formatters.time(live!.currentReservation!.startAt);
                } else if (live?.next != null) {
                  caption = 'Next ${Formatters.time(live!.next!.startAt)}';
                }
                return TableVisual(
                  accent: tableStatusColor(context, status),
                  caption: caption,
                  selected: t.id == _selectedTableId,
                );
              },
            ),
          ),
          Positioned(
            left: AppSpacing.lg,
            bottom: AppSpacing.lg,
            child: _Legend(),
          ),
          Positioned(
            right: AppSpacing.lg,
            bottom: AppSpacing.lg,
            child: Material(
              color: context.colors.surface,
              elevation: 2,
              borderRadius: AppRadius.mdAll,
              child: IconButton(
                tooltip: 'Fit to screen',
                onPressed: () => _canvasKey.currentState?.fitToScreen(),
                icon: const Icon(Icons.fit_screen_rounded),
              ),
            ),
          ),
        ],
      );

      body = Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.pagePadding.left),
            child: FloorTabs(
              floors: floorsAsync.value ?? const [],
              selectedId: floor.id,
              onSelected: (f) {
                ref.read(selectedFloorIdProvider.notifier).select(f.id);
                setState(() => _selectedTableId = null);
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                context.pagePadding.left,
                0,
                context.pagePadding.right,
                context.pagePadding.bottom,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: AppRadius.lgAll,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: context.palette.border),
                          borderRadius: AppRadius.lgAll,
                        ),
                        child: canvas,
                      ),
                    ),
                  ),
                  if (context.isTabletUp && selected != null) ...[
                    const SizedBox(width: AppSpacing.lg),
                    SizedBox(
                      width: context.screenClass.isExpanded ? 360 : 320,
                      child: Card(
                        child: TableDetailsPanel(
                          key: ValueKey(selected.id),
                          table: selected,
                          onClose: () => setState(() => _selectedTableId = null),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            header,
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget item(Color c, String label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: c, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(label, style: context.text.labelSmall),
          ],
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(alpha: 0.95),
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: context.palette.border),
      ),
      child: Wrap(
        spacing: 14,
        runSpacing: 6,
        children: [
          item(context.palette.tableAvailable, 'Available'),
          item(context.palette.tableReserved, 'Reserved (< 1h)'),
          item(context.palette.tableOccupied, 'Occupied'),
        ],
      ),
    );
  }
}
