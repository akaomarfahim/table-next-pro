import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/pin_hasher.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';
import '../controllers/session_controller.dart';

/// Create / edit a staff member.
class StaffFormSheet extends ConsumerStatefulWidget {
  const StaffFormSheet({super.key, this.user});

  final AppUser? user;

  static Future<void> show(BuildContext context, {AppUser? user}) =>
      showAdaptiveSheet<void>(
        context: context,
        builder: (_) => StaffFormSheet(user: user),
      );

  @override
  ConsumerState<StaffFormSheet> createState() => _StaffFormSheetState();
}

class _StaffFormSheetState extends ConsumerState<StaffFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name =
      TextEditingController(text: widget.user?.name);
  late final TextEditingController _username =
      TextEditingController(text: widget.user?.username);
  late final TextEditingController _phone =
      TextEditingController(text: widget.user?.phone);
  final _pin = TextEditingController();
  late UserRole _role = widget.user?.role ?? UserRole.waiter;
  bool _saving = false;

  bool get _isEdit => widget.user != null;

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _phone.dispose();
    _pin.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final current = ref.read(currentUserProvider);
    final businessId = ref.read(requireBusinessIdProvider);
    if (_role == UserRole.owner && current?.role != UserRole.owner) {
      context.showSnack('Only an owner can assign the Owner role.', error: true);
      return;
    }
    setState(() => _saving = true);
    final repo = ref.read(userRepositoryProvider);
    try {
      if (_isEdit) {
        final updated = widget.user!.copyWith(
          name: _name.text.trim(),
          username: _username.text.trim(),
          phone: _phone.text.trim(),
          role: _role,
        );
        await repo.updateUser(updated, newPin: _pin.text.isEmpty ? null : _pin.text);
        ref.read(sessionControllerProvider.notifier).replaceUser(updated);
      } else {
        await repo.createUser(
          AppUser(
            id: '',
            businessId: businessId,
            name: _name.text.trim(),
            username: _username.text.trim(),
            phone: _phone.text.trim(),
            role: _role,
          ),
          pin: _pin.text,
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop();
      context.showSnack(_isEdit ? 'Staff member updated' : 'Staff member added');
    } catch (e) {
      if (mounted) context.showError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppSpacing.md);
    final canManage = ref.watch(hasPermissionProvider(Permission.manageStaff));
    return SheetScaffold(
      title: _isEdit ? 'Edit staff member' : 'Add staff member',
      subtitle: 'Each staff member unlocks the app with their own PIN',
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        LoadingButton(label: 'Save', loading: _saving, onPressed: _save),
      ],
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Full name'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            gap,
            TextFormField(
              controller: _username,
              enabled: canManage,
              autocorrect: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9._-]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Username',
                helperText: 'Unique across all restaurants; used to activate devices',
              ),
              validator: (v) =>
                  (v == null || v.trim().length < 3) ? 'At least 3 characters' : null,
            ),
            gap,
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone (optional)'),
            ),
            if (canManage) ...[
            const SizedBox(height: AppSpacing.lg),
            Text('Role', style: context.text.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final role in UserRole.values)
                  ChoiceChip(
                    label: Text(role.label),
                    selected: _role == role,
                    onSelected: (_) => setState(() => _role = role),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              _role.description,
              style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
            ),
            ],
            const SizedBox(height: AppSpacing.lg),
            TextFormField(
              controller: _pin,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: AppConfig.pinLength,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: _isEdit ? 'New PIN (leave empty to keep)' : 'PIN',
                counterText: '',
                prefixIcon: const Icon(Icons.pin_outlined),
              ),
              validator: (v) {
                if (_isEdit && (v == null || v.isEmpty)) return null;
                return PinHasher.validate(v ?? '');
              },
            ),
          ],
        ),
      ),
    );
  }
}
