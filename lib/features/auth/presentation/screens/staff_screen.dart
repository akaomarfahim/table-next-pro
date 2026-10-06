import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../../core/widgets/state_views.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';
import '../controllers/session_controller.dart';
import '../controllers/staff_providers.dart';
import '../widgets/staff_form_sheet.dart';

class StaffScreen extends ConsumerWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canManage = ref.watch(hasPermissionProvider(Permission.manageStaff));
    final staff = ref.watch(staffUsersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Staff & PINs')),
      floatingActionButton: canManage
          ? FloatingActionButton.extended(
              onPressed: () => StaffFormSheet.show(context),
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text('Add staff'),
            )
          : null,
      body: !canManage
          ? const EmptyState(
              icon: Icons.lock_outline_rounded,
              title: 'Restricted',
              message: 'Only owners and managers can manage staff.',
            )
          : AsyncValueView<List<AppUser>>(
              value: staff,
              onRetry: () => ref.invalidate(staffUsersProvider),
              loading: const SkeletonList(),
              data: (users) {
                if (users.isEmpty) {
                  return const EmptyState(
                    icon: Icons.groups_rounded,
                    title: 'No staff yet',
                    message: 'Add your team so everyone can unlock with their own PIN.',
                  );
                }
                return MaxWidthBox(
                  maxWidth: 1100,
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final cols = adaptiveColumns(c.maxWidth, minTileWidth: 340, maxColumns: 3);
                      return GridView.builder(
                        padding: context.pagePadding.copyWith(bottom: 96),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: cols,
                          mainAxisExtent: 132,
                          crossAxisSpacing: AppSpacing.md,
                          mainAxisSpacing: AppSpacing.md,
                        ),
                        itemCount: users.length,
                        itemBuilder: (context, i) => _StaffCard(user: users[i])
                            .animate(delay: (40 * i).ms)
                            .fadeIn(duration: 250.ms)
                            .slideY(begin: 0.05, end: 0),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class _StaffCard extends ConsumerWidget {
  const _StaffCard({required this.user});

  final AppUser user;

  Color _roleColor(BuildContext context) => switch (user.role) {
        UserRole.owner => context.colors.primary,
        UserRole.manager => context.palette.violet,
        UserRole.host => context.palette.info,
        UserRole.cashier => context.colors.secondary,
        UserRole.waiter => context.palette.warning,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(currentUserProvider);
    final isMe = me?.id == user.id;

    return AppCard(
      onTap: () => StaffFormSheet.show(context, user: user),
      child: Row(
        children: [
          Opacity(
            opacity: user.active ? 1 : 0.4,
            child: InitialsAvatar(name: user.name, size: 52),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        user.name,
                        style: context.text.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: AppSpacing.xs),
                      StatusBadge(label: 'You', color: context.palette.info, dense: true),
                    ],
                  ],
                ),
                Text(
                  '@${user.username}',
                  style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: [
                    StatusBadge(label: user.role.label, color: _roleColor(context), dense: true),
                    if (!user.active)
                      StatusBadge(label: 'Disabled', color: context.palette.danger, dense: true),
                    if (user.lastLoginAt != null)
                      Text(
                        'Last in ${Formatters.timeAgo(user.lastLoginAt!)}',
                        style: context.text.labelSmall?.copyWith(
                          color: context.palette.textMuted,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (!isMe)
            Switch.adaptive(
              value: user.active,
              onChanged: (value) async {
                if (!value) {
                  final ok = await showConfirmDialog(
                    context,
                    title: 'Disable ${user.firstName}?',
                    message: 'They will no longer be able to unlock the app with their PIN.',
                    confirmLabel: 'Disable',
                    destructive: true,
                  );
                  if (!ok) return;
                }
                try {
                  await ref.read(userRepositoryProvider).setActive(user.id, active: value);
                } catch (e) {
                  if (context.mounted) context.showError(e);
                }
              },
            ),
        ],
      ),
    );
  }
}
