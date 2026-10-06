import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../controllers/session_controller.dart';
import '../widgets/auth_layout.dart';

/// First-launch screen: links this device to a business by signing in with
/// a staff username + PIN. The business id is resolved from the user record.
class ActivationScreen extends ConsumerStatefulWidget {
  const ActivationScreen({super.key});

  @override
  ConsumerState<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends ConsumerState<ActivationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _pin = TextEditingController();
  bool _loading = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _username.dispose();
    _pin.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref
          .read(sessionControllerProvider.notifier)
          .activate(username: _username.text, pin: _pin.text);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = errorMessageOf(e));
      _pin.clear();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Activate this device', style: context.text.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Sign in once with your staff username and PIN to link this device to your restaurant.',
              style: context.text.bodyLarge?.copyWith(color: context.palette.textMuted),
            ),
            const SizedBox(height: AppSpacing.xxl),
            TextFormField(
              controller: _username,
              autofillHints: const [AutofillHints.username],
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              validator: (v) =>
                  (v == null || v.trim().length < 3) ? 'Enter your username' : null,
            ),
            const SizedBox(height: AppSpacing.lg),
            TextFormField(
              controller: _pin,
              obscureText: _obscure,
              keyboardType: TextInputType.number,
              maxLength: AppConfig.pinLength,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: 'PIN',
                counterText: '',
                prefixIcon: const Icon(Icons.pin_outlined),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(_obscure ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                ),
              ),
              validator: (v) => (v == null || v.length != AppConfig.pinLength)
                  ? 'PIN must be ${AppConfig.pinLength} digits'
                  : null,
            ),
            AnimatedSwitcher(
              duration: AppDurations.medium,
              child: _error == null
                  ? const SizedBox(height: AppSpacing.xl)
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: context.palette.danger.withValues(alpha: 0.1),
                          borderRadius: AppRadius.mdAll,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline_rounded, color: context.palette.danger),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(child: Text(_error!)),
                          ],
                        ),
                      ),
                    ),
            ),
            LoadingButton(
              label: 'Activate device',
              icon: Icons.login_rounded,
              loading: _loading,
              expand: true,
              onPressed: _submit,
            ),
            if (AppConfig.canProvision) ...[
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text(
                      'New restaurant?',
                      style: context.text.labelMedium?.copyWith(
                        color: context.palette.textMuted,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton.icon(
                onPressed: _loading ? null : () => context.push(AppRoutes.setup),
                icon: const Icon(Icons.storefront_rounded),
                label: const Text('Set up a new restaurant'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
