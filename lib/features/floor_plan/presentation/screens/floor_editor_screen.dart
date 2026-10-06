import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/services/device_settings.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../auth/domain/entities/user_role.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../data/repositories/floor_repository_impl.dart';
import '../../domain/entities/floor_area.dart';
import '../controllers/floor_editor_controller.dart';
import '../controllers/floor_providers.dart';
import '../widgets/editor_panels.dart';
import '../widgets/floor_canvas.dart';
import '../widgets/floor_element_views.dart';
import '../widgets/floor_selector.dart';

/// Drag & drop floor plan designer: tables (round / rectangle / square with
/// chair counts) and structures (kitchen, bar, register, walls ...).
class FloorEditorScreen extends ConsumerStatefulWidget {
  const FloorEditorScreen({super.key});

  @override
  ConsumerState<FloorEditorScreen> createState() => _FloorEditorScreenState();
}

class _FloorEditorScreenState extends ConsumerState<FloorEditorScreen> {
  final _canvasKey = GlobalKey<FloorCanvasState>();
  final _transform = TransformationController();

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  void _syncFromRemote() {
    final editor = ref.read(floorEditorControllerProvider);
    if (editor.dirty || editor.saving) return;
    final floor = ref.read(activeFloorProvider);
    final elements = ref.read(floorElementsProvider).value;
    if (floor == null || elements == null) return;
    ref.read(floorEditorControllerProvider.notifier).load(floor, elements);
  }

  Future<bool> _confirmDiscard() async {
    if (!ref.read(floorEditorControllerProvider).dirty) return true;
    return showConfirmDialog(
      context,
      title: 'Discard changes?',
      message: 'You have unsaved layout changes. Leave without saving?',
      confirmLabel: 'Discard',
      destructive: true,
    );
  }

  Future<void> _save() async {
    try {
      await ref.read(floorEditorControllerProvider.notifier).save();
      if (mounted) context.showSnack('Floor plan saved');
    } catch (e) {
      if (mounted) context.showError(e);
    }
  }

  Future<void> _switchFloor(FloorArea floor) async {
    if (!await _confirmDiscard()) return;
    ref.read(selectedFloorIdProvider.notifier).select(floor.id);
    final elements = ref.read(floorElementsProvider).value ?? const [];
    ref.read(floorEditorControllerProvider.notifier).load(floor, elements);
  }

  Future<void> _addFloor() async {
    final floors = ref.read(floorsProvider).value ?? const [];
    final name = await showTextPrompt(
      context,
      title: 'New floor / area',
      label: 'Name (e.g. Rooftop)',
      confirmLabel: 'Create',
      validator: (v) => v.trim().isEmpty ? 'Required' : null,
    );
    if (name == null) return;
    try {
      final floor = await ref
          .read(floorRepositoryProvider)
          .createFloor(name: name, sortOrder: floors.length);
      if (!mounted) return;
      if (await _confirmDiscard()) {
        ref.read(selectedFloorIdProvider.notifier).select(floor.id);
        ref.read(floorEditorControllerProvider.notifier).load(floor, const []);
      }
    } catch (e) {
      if (mounted) context.showError(e);
    }
  }

  Future<void> _floorMenu(FloorArea floor, String action) async {
    final repo = ref.read(floorRepositoryProvider);
    try {
      switch (action) {
        case 'rename':
          final name = await showTextPrompt(
            context,
            title: 'Rename floor',
            initialValue: floor.name,
            validator: (v) => v.trim().isEmpty ? 'Required' : null,
          );
          if (name != null) await repo.updateFloor(floor.copyWith(name: name));
        case 'delete':
          final ok = await showConfirmDialog(
            context,
            title: 'Delete "${floor.name}"?',
            message: 'All tables and structures on this floor will be removed. '
                'Existing reservations keep their table names.',
            confirmLabel: 'Delete floor',
            destructive: true,
          );
          if (ok) {
            await repo.deleteFloor(floor.id);
            ref.read(floorEditorControllerProvider.notifier).load(
                  const FloorArea(id: '', name: ''),
                  const [],
                );
          }
        default:
          final preset = CanvasPreset.values.firstWhere((p) => p.name == action);
          final updated = floor.copyWith(width: preset.width, height: preset.height);
          await repo.updateFloor(updated);
          final editor = ref.read(floorEditorControllerProvider);
          ref.read(floorEditorControllerProvider.notifier).load(updated, editor.elements);
          WidgetsBinding.instance.addPostFrameCallback((_) => _canvasKey.currentState?.fitToScreen());
      }
    } catch (e) {
      if (mounted) context.showError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canEdit = ref.watch(hasPermissionProvider(Permission.editFloorPlan));
    final floorsAsync = ref.watch(floorsProvider);
    final editor = ref.watch(floorEditorControllerProvider);
    final snap = ref.watch(snapToGridProvider);
    final controller = ref.read(floorEditorControllerProvider.notifier);

    ref.listen(activeFloorProvider, (prev, next) {
      if (prev?.id != next?.id || editor.floor == null) _syncFromRemote();
    });
    ref.listen(floorElementsProvider, (_, _) => _syncFromRemote());

    if (editor.floor == null || editor.floor!.id.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && ref.read(activeFloorProvider) != null) _syncFromRemote();
      });
    }

    if (!canEdit) {
      return Scaffold(
        appBar: AppBar(title: const Text('Floor plan editor')),
        body: const EmptyState(
          icon: Icons.lock_outline_rounded,
          title: 'Restricted',
          message: 'Only owners and managers can edit the floor plan.',
        ),
      );
    }

    final compact = context.isCompact;
    final floors = floorsAsync.value ?? const <FloorArea>[];
    final floor = editor.floor;

    return PopScope(
      canPop: !editor.dirty,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmDiscard() && context.mounted) {
          ref.read(floorEditorControllerProvider.notifier).load(
                editor.floor ?? const FloorArea(id: '', name: ''),
                ref.read(floorElementsProvider).value ?? const [],
              );
          if (context.mounted) context.go(AppRoutes.floor);
        }
      },
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.keyS, control: true): _save,
          const SingleActivator(LogicalKeyboardKey.keyS, meta: true): _save,
          const SingleActivator(LogicalKeyboardKey.keyZ, control: true): _unlessTyping(controller.undo),
          const SingleActivator(LogicalKeyboardKey.keyZ, meta: true): _unlessTyping(controller.undo),
          const SingleActivator(LogicalKeyboardKey.keyD, control: true):
              _unlessTyping(controller.duplicateSelected),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                tooltip: 'Back',
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () async {
                  if (await _confirmDiscard() && context.mounted) {
                    _syncFromRemoteForced();
                    context.go(AppRoutes.floor);
                  }
                },
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Floor plan editor'),
                  if (floor != null && floor.id.isNotEmpty)
                    Text(
                      '${editor.tableCount} tables · ${editor.seatCount} seats'
                      '${editor.dirty ? ' · Unsaved changes' : ''}',
                      style: context.text.bodySmall?.copyWith(
                        color: editor.dirty ? context.palette.warning : context.palette.textMuted,
                      ),
                    ),
                ],
              ),
              actions: [
                IconButton(
                  tooltip: 'Undo (Ctrl+Z)',
                  onPressed: editor.canUndo ? controller.undo : null,
                  icon: const Icon(Icons.undo_rounded),
                ),
                IconButton(
                  tooltip: snap ? 'Snap to grid: on' : 'Snap to grid: off',
                  isSelected: snap,
                  onPressed: () => ref.read(snapToGridProvider.notifier).toggle(),
                  icon: const Icon(Icons.grid_off_rounded),
                  selectedIcon: const Icon(Icons.grid_on_rounded),
                ),
                if (!compact) const SizedBox(width: AppSpacing.sm),
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: LoadingButton(
                    label: 'Save',
                    icon: Icons.cloud_upload_rounded,
                    loading: editor.saving,
                    onPressed: editor.dirty ? _save : null,
                  ),
                ),
              ],
            ),
            body: floorsAsync.isLoading && floors.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : floors.isEmpty
                    ? EmptyState(
                        icon: Icons.layers_rounded,
                        title: 'Create your first floor',
                        message:
                            'A floor is a dining area such as "Main hall" or "Terrace". Add tables and structures to it.',
                        action: FilledButton.icon(
                          onPressed: _addFloor,
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Add floor'),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.lg,
                              0,
                              AppSpacing.lg,
                              AppSpacing.sm,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: FloorTabs(
                                    floors: floors,
                                    selectedId: floor?.id,
                                    onSelected: _switchFloor,
                                    trailing: ActionChip(
                                      avatar: const Icon(Icons.add_rounded, size: 18),
                                      label: const Text('Add floor'),
                                      onPressed: _addFloor,
                                    ),
                                  ),
                                ),
                                if (floor != null && floor.id.isNotEmpty)
                                  PopupMenuButton<String>(
                                    tooltip: 'Floor options',
                                    icon: const Icon(Icons.more_vert_rounded),
                                    onSelected: (a) => _floorMenu(floor, a),
                                    itemBuilder: (_) => [
                                      const PopupMenuItem(value: 'rename', child: Text('Rename floor')),
                                      const PopupMenuDivider(),
                                      for (final p in CanvasPreset.values)
                                        CheckedPopupMenuItem(
                                          value: p.name,
                                          checked: floor.width == p.width && floor.height == p.height,
                                          child: Text('Canvas: ${p.label}'),
                                        ),
                                      const PopupMenuDivider(),
                                      const PopupMenuItem(value: 'delete', child: Text('Delete floor')),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: floor == null || floor.id.isEmpty
                                ? const Center(child: CircularProgressIndicator())
                                : _EditorBody(
                                    canvasKey: _canvasKey,
                                    transform: _transform,
                                    floor: floor,
                                    editor: editor,
                                    snap: snap,
                                  ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  /// Editor shortcuts must not fire while a text field has focus.
  VoidCallback _unlessTyping(VoidCallback action) => () {
        final focusContext = FocusManager.instance.primaryFocus?.context;
        final typing = focusContext?.findAncestorWidgetOfExactType<EditableText>() != null;
        if (!typing) action();
      };

  void _syncFromRemoteForced() {
    final floor = ref.read(activeFloorProvider);
    final elements = ref.read(floorElementsProvider).value;
    if (floor == null || elements == null) return;
    ref.read(floorEditorControllerProvider.notifier).load(floor, elements);
  }
}

class _EditorBody extends ConsumerWidget {
  const _EditorBody({
    required this.canvasKey,
    required this.transform,
    required this.floor,
    required this.editor,
    required this.snap,
  });

  final GlobalKey<FloorCanvasState> canvasKey;
  final TransformationController transform;
  final FloorArea floor;
  final FloorEditorState editor;
  final bool snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(floorEditorControllerProvider.notifier);
    final compact = context.isCompact;
    final selected = editor.selected;

    final canvas = Stack(
      children: [
        Positioned.fill(
          child: FloorCanvas(
            key: canvasKey,
            floor: floor,
            elements: editor.elements,
            mode: FloorCanvasMode.edit,
            snapToGrid: snap,
            transformationController: transform,
            selectedIds: {?editor.selectedId},
            tableVisual: (t) => TableVisual(selected: t.id == editor.selectedId),
            onElementTap: (e) => controller.select(e.id),
            onBackgroundTap: () => controller.select(null),
            onDragStart: (_) => controller.beginInteraction(),
            onDragUpdate: controller.move,
            onResize: controller.resize,
          ),
        ),
        Positioned(
          right: AppSpacing.lg,
          bottom: AppSpacing.lg,
          child: _ZoomControls(canvasKey: canvasKey),
        ),
        if (editor.elements.isEmpty)
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: context.colors.surface.withValues(alpha: 0.92),
                    borderRadius: AppRadius.lgAll,
                    border: Border.all(color: context.palette.border),
                  ),
                  child: Text(
                    compact
                        ? 'Tap “Add” to place tables and structures'
                        : 'Pick a table or structure from the left panel',
                    style: context.text.bodyMedium,
                  ),
                ),
              ),
            ),
          ),
      ],
    );

    if (compact) {
      return Column(
        children: [
          Expanded(child: canvas),
          Material(
            color: context.colors.surface,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (ctx) => SizedBox(
                            height: MediaQuery.sizeOf(ctx).height * 0.7,
                            child: ElementPalette(onAdded: () => Navigator.of(ctx).pop()),
                          ),
                        ),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Add'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: selected == null
                            ? null
                            : () => showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  builder: (ctx) => SizedBox(
                                    height: MediaQuery.sizeOf(ctx).height * 0.75,
                                    child: Consumer(
                                      builder: (ctx, ref, _) {
                                        final current =
                                            ref.watch(floorEditorControllerProvider).selected;
                                        if (current == null) {
                                          WidgetsBinding.instance.addPostFrameCallback(
                                            (_) => Navigator.of(ctx).maybePop(),
                                          );
                                          return const SizedBox.shrink();
                                        }
                                        return ElementInspector(element: current);
                                      },
                                    ),
                                  ),
                                ),
                        icon: const Icon(Icons.tune_rounded),
                        label: Text(selected == null ? 'Select item' : 'Edit ${selected.label}'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        SizedBox(
          width: context.screenClass.isExpanded ? 280 : 236,
          child: Material(color: context.colors.surface, child: const ElementPalette()),
        ),
        const VerticalDivider(width: 1),
        Expanded(child: canvas),
        AnimatedSwitcher(
          duration: AppDurations.medium,
          transitionBuilder: (child, anim) => SizeTransition(
            sizeFactor: anim,
            axis: Axis.horizontal,
            child: child,
          ),
          child: selected == null
              ? const SizedBox.shrink(key: ValueKey('none'))
              : Row(
                  key: const ValueKey('inspector'),
                  children: [
                    const VerticalDivider(width: 1),
                    SizedBox(
                      width: 300,
                      child: Material(
                        color: context.colors.surface,
                        child: ElementInspector(element: selected),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _ZoomControls extends StatelessWidget {
  const _ZoomControls({required this.canvasKey});

  final GlobalKey<FloorCanvasState> canvasKey;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      elevation: 3,
      shadowColor: Colors.black26,
      borderRadius: AppRadius.mdAll,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Zoom in',
            onPressed: () => canvasKey.currentState?.zoomBy(1.25),
            icon: const Icon(Icons.add_rounded),
          ),
          IconButton(
            tooltip: 'Zoom out',
            onPressed: () => canvasKey.currentState?.zoomBy(0.8),
            icon: const Icon(Icons.remove_rounded),
          ),
          IconButton(
            tooltip: 'Fit to screen',
            onPressed: () => canvasKey.currentState?.fitToScreen(),
            icon: const Icon(Icons.fit_screen_rounded),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
