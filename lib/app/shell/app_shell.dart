import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_config.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/widgets/common_widgets.dart';
import '../../core/widgets/offline_banner.dart';
import '../../features/auth/presentation/controllers/session_controller.dart';
import 'nav_destinations.dart';

/// Adaptive navigation chrome:
/// * phone   → bottom [NavigationBar] + "More" sheet
/// * tablet  → [NavigationRail]
/// * desktop → expanded sidebar
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.location, required this.child});

  /// Current router location (passed by the ShellRoute builder).
  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = NavDestination.indexOf(location);
    final size = context.screenClass;

    final body = Column(
      children: [
        const OfflineBanner(),
        Expanded(child: child),
      ],
    );

    void go(int i) => context.go(NavDestination.all[i].path);

    switch (size) {
      case ScreenSize.compact:
        final primary = NavDestination.all.take(NavDestination.primaryOnPhone).toList();
        final selected = index < primary.length ? index : primary.length;
        return Scaffold(
          body: body,
          bottomNavigationBar: NavigationBar(
            selectedIndex: selected,
            onDestinationSelected: (i) {
              if (i < primary.length) {
                go(i);
              } else {
                _showMoreSheet(context, ref, index);
              }
            },
            destinations: [
              for (final d in primary)
                NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: d.label,
                ),
              const NavigationDestination(
                icon: Icon(Icons.grid_view_outlined),
                selectedIcon: Icon(Icons.grid_view_rounded),
                label: 'More',
              ),
            ],
          ),
        );
      case ScreenSize.medium:
        return Scaffold(
          body: SafeArea(
            right: false,
            top: false,
            bottom: false,
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: index,
                  onDestinationSelected: go,
                  labelType: NavigationRailLabelType.all,
                  groupAlignment: -0.85,
                  minWidth: 84,
                  leading: const Padding(
                    padding: EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.md),
                    child: _BrandMark(size: 40),
                  ),
                  trailing: const Padding(
                    padding: EdgeInsets.only(top: AppSpacing.xl, bottom: AppSpacing.lg),
                    child: _RailUserButton(),
                  ),
                  destinations: [
                    for (final d in NavDestination.all)
                      NavigationRailDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.selectedIcon),
                        label: Text(d.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: body),
              ],
            ),
          ),
        );
      case ScreenSize.expanded:
        return Scaffold(
          body: Row(
            children: [
              _Sidebar(selectedIndex: index, onSelected: go),
              const VerticalDivider(width: 1),
              Expanded(child: body),
            ],
          ),
        );
    }
  }

  void _showMoreSheet(BuildContext context, WidgetRef ref, int currentIndex) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (sheetContext) {
        final user = ref.read(currentUserProvider);
        final business = ref.read(currentBusinessProvider);
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (user != null)
                ListTile(
                  leading: InitialsAvatar(name: user.name),
                  title: Text(user.name),
                  subtitle: Text('${user.role.label} · ${business?.name ?? ''}'),
                  trailing: FilledButton.tonalIcon(
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      ref.read(sessionControllerProvider.notifier).lock();
                    },
                    icon: const Icon(Icons.lock_rounded, size: 18),
                    label: const Text('Lock'),
                  ),
                ),
              const Divider(height: AppSpacing.xl),
              for (var i = NavDestination.primaryOnPhone; i < NavDestination.all.length; i++)
                ListTile(
                  selected: i == currentIndex,
                  leading: Icon(NavDestination.all[i].icon),
                  title: Text(NavDestination.all[i].label),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    context.go(NavDestination.all[i].path);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.colors.primary, context.colors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(
        Icons.table_restaurant_rounded,
        color: Colors.white,
        size: size * 0.55,
      ),
    );
  }
}

class _RailUserButton extends ConsumerWidget {
  const _RailUserButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.filledTonal(
          tooltip: 'Lock screen',
          onPressed: () => ref.read(sessionControllerProvider.notifier).lock(),
          icon: const Icon(Icons.lock_rounded),
        ),
        const SizedBox(height: AppSpacing.md),
        if (user != null)
          Tooltip(
            message: '${user.name} · ${user.role.label}',
            child: InitialsAvatar(name: user.name, size: 40),
          ),
      ],
    );
  }
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar({required this.selectedIndex, required this.onSelected});

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final business = ref.watch(currentBusinessProvider);

    return Container(
      width: 264,
      color: context.colors.surface,
      child: SafeArea(
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Row(
                children: [
                  const _BrandMark(size: 40),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          business?.name ?? AppConfig.appName,
                          style: context.text.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          AppConfig.appName,
                          style: context.text.labelSmall?.copyWith(
                            color: context.palette.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                children: [
                  for (var i = 0; i < NavDestination.all.length; i++)
                    _SidebarItem(
                      destination: NavDestination.all[i],
                      selected: i == selectedIndex,
                      onTap: () => onSelected(i),
                    )
                        .animate(delay: (30 * i).ms)
                        .fadeIn(duration: 250.ms)
                        .slideX(begin: -0.05, end: 0),
                ],
              ),
            ),
            if (user != null)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceContainer,
                    borderRadius: AppRadius.lgAll,
                  ),
                  child: Row(
                    children: [
                      InitialsAvatar(name: user.name, size: 40),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: context.text.titleSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              user.role.label,
                              style: context.text.bodySmall?.copyWith(
                                color: context.palette.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Lock screen',
                        onPressed: () =>
                            ref.read(sessionControllerProvider.notifier).lock(),
                        icon: const Icon(Icons.lock_rounded),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final NavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? context.colors.primary : context.palette.textMuted;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: selected
            ? context.colors.primary.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: AppRadius.mdAll,
        child: InkWell(
          borderRadius: AppRadius.mdAll,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(
                  selected ? destination.selectedIcon : destination.icon,
                  color: color,
                  size: 22,
                ),
                const SizedBox(width: 14),
                Text(
                  destination.label,
                  style: context.text.titleSmall?.copyWith(
                    color: selected ? context.colors.primary : context.colors.onSurface,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
