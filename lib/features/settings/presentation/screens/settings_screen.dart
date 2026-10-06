import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/services/device_settings.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_controller.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../auth/domain/entities/user_role.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../../auth/presentation/widgets/staff_form_sheet.dart';
import '../../../customers/data/repositories/customer_repository_impl.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final business = ref.watch(currentBusinessProvider);
    final themeMode = ref.watch(themeControllerProvider);
    final autoLock = ref.watch(autoLockMinutesProvider);
    bool can(Permission p) => user?.can(p) ?? false;
    final padding = context.pagePadding;

    Widget tile({
      required IconData icon,
      required String title,
      String? subtitle,
      VoidCallback? onTap,
      Widget? trailing,
      Color? color,
    }) => ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (color ?? context.colors.primary).withValues(alpha: 0.1),
          borderRadius: AppRadius.smAll,
        ),
        child: Icon(icon, color: color ?? context.colors.primary, size: 20),
      ),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: trailing ?? (onTap == null ? null : const Icon(Icons.chevron_right_rounded)),
      onTap: onTap,
    );

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(padding.left, padding.top, padding.right, 48),
          children: [
            MaxWidthBox(
              maxWidth: 820,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const PageHeader(title: 'Settings'),
                  const SizedBox(height: AppSpacing.lg),
                  if (user != null)
                    AppCard(
                      child: Row(
                        children: [
                          InitialsAvatar(name: user.name, size: 56),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.name, style: context.text.titleLarge),
                                Text(
                                  '@${user.username} · ${user.role.label} · ${business?.name ?? ''}',
                                  style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => StaffFormSheet.show(context, user: user),
                            icon: const Icon(Icons.pin_outlined, size: 18),
                            label: const Text('Change PIN'),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: AppSpacing.lg),
                  _Section(
                    title: 'Appearance',
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: SegmentedButton<ThemeMode>(
                          segments: const [
                            ButtonSegment(
                              value: ThemeMode.system,
                              icon: Icon(Icons.brightness_auto_rounded),
                              label: Text('System'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.light,
                              icon: Icon(Icons.light_mode_rounded),
                              label: Text('Light'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.dark,
                              icon: Icon(Icons.dark_mode_rounded),
                              label: Text('Dark'),
                            ),
                          ],
                          selected: {themeMode},
                          onSelectionChanged: (s) => ref.read(themeControllerProvider.notifier).setMode(s.first),
                        ),
                      ),
                    ],
                  ),
                  _Section(
                    title: 'Security',
                    children: [
                      tile(
                        icon: Icons.timer_outlined,
                        title: 'Auto-lock',
                        subtitle: 'Lock the app after inactivity on this device',
                        trailing: DropdownButton<int>(
                          value: autoLock,
                          underline: const SizedBox.shrink(),
                          borderRadius: AppRadius.mdAll,
                          items: [
                            for (final m in AutoLockMinutes.options)
                              DropdownMenuItem(value: m, child: Text(m == 0 ? 'Never' : '$m min')),
                          ],
                          onChanged: (v) {
                            if (v != null) ref.read(autoLockMinutesProvider.notifier).set(v);
                          },
                        ),
                      ),
                      tile(
                        icon: Icons.lock_rounded,
                        title: 'Lock now',
                        subtitle: 'Hand the device to another staff member',
                        onTap: () => ref.read(sessionControllerProvider.notifier).lock(),
                      ),
                    ],
                  ),
                  if (can(Permission.manageBusiness) || can(Permission.manageStaff) || can(Permission.editFloorPlan))
                    _Section(
                      title: 'Restaurant',
                      children: [
                        if (can(Permission.manageBusiness))
                          tile(
                            icon: Icons.storefront_rounded,
                            title: 'Restaurant profile',
                            subtitle: 'Name, address, VAT, service charge, hours',
                            onTap: () => context.go(AppRoutes.businessProfile),
                          ),
                        if (can(Permission.manageStaff))
                          tile(
                            icon: Icons.badge_rounded,
                            title: 'Staff & PINs',
                            subtitle: 'Add staff, roles and lock-screen PINs',
                            onTap: () => context.go(AppRoutes.staff),
                          ),
                        if (can(Permission.editFloorPlan))
                          tile(
                            icon: Icons.design_services_rounded,
                            title: 'Floor plan editor',
                            subtitle: 'Tables, chairs, kitchen, bar, register…',
                            onTap: () => context.push(AppRoutes.floorEditor),
                          ),
                        tile(
                          icon: Icons.restaurant_menu_rounded,
                          title: 'Menu',
                          subtitle: 'Categories, items and prices',
                          onTap: () => context.go(AppRoutes.menu),
                        ),
                      ],
                    ),
                  _Section(
                    title: 'Device',
                    children: [
                      tile(
                        icon: Icons.fingerprint_rounded,
                        title: 'Business ID',
                        subtitle: business?.id ?? '—',
                        color: context.palette.info,
                        trailing: IconButton(
                          tooltip: 'Copy',
                          icon: const Icon(Icons.copy_rounded),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: business?.id ?? ''));
                            context.showSnack('Business ID copied');
                          },
                        ),
                      ),
                      if (can(Permission.manageBusiness))
                        tile(
                          icon: Icons.manage_search_rounded,
                          title: 'Rebuild customer search index',
                          subtitle: 'Run once after importing customers from another system',
                          color: context.palette.warning,
                          onTap: () => _runBackfill(context, ref),
                        ),
                      if (can(Permission.viewLogs))
                        tile(
                          icon: Icons.bug_report_rounded,
                          title: 'Diagnostics & logs',
                          color: context.palette.violet,
                          onTap: () => context.go(AppRoutes.logs),
                        ),
                      if (can(Permission.manageBusiness))
                        tile(
                          icon: Icons.link_off_rounded,
                          title: 'Deactivate this device',
                          subtitle: 'Unlink from ${business?.name ?? 'this business'}',
                          color: context.palette.danger,
                          onTap: () async {
                            final ok = await showConfirmDialog(
                              context,
                              title: 'Deactivate device?',
                              message: 'This device will be unlinked. A staff username and PIN will be required to activate it again.',
                              confirmLabel: 'Deactivate',
                              destructive: true,
                            );
                            if (ok) await ref.read(sessionControllerProvider.notifier).deactivateDevice();
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Center(
                    child: Text(
                      '${AppConfig.appName} v${AppConfig.appVersion}',
                      style: context.text.labelSmall?.copyWith(color: context.palette.textMuted),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _runBackfill(BuildContext context, WidgetRef ref) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Rebuild search index?',
      message:
          'Every customer document is read once and patched if needed. '
          'With ~17k customers this uses ~17k reads (and up to 17k writes) of your daily Firestore quota. '
          'Only run it after an import.',
      confirmLabel: 'Run now',
    );
    if (!ok || !context.mounted) return;
    final progress = ValueNotifier<String>('Starting…');
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: ValueListenableBuilder<String>(valueListenable: progress, builder: (_, v, _) => Text(v)),
              ),
            ],
          ),
        ),
      ),
    );
    try {
      final result = await ref
          .read(customerMaintenanceProvider)
          .backfillSearchFields(
            onProgress: (scanned, patched) => progress.value = 'Scanned $scanned · updated $patched',
          );
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        context.showSnack('Done: scanned ${result.scanned}, updated ${result.patched}');
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        context.showError(e);
      }
    } finally {
      progress.dispose();
    }
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.xs, bottom: AppSpacing.sm),
            child: Text(
              title.toUpperCase(),
              style: context.text.labelSmall?.copyWith(
                color: context.palette.textMuted,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}
