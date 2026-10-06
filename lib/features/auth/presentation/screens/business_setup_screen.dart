import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/pin_hasher.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../business/domain/entities/business.dart';
import '../controllers/session_controller.dart';
import '../widgets/auth_layout.dart';

/// Provisioning wizard: creates a business and its owner account, then
/// links this device to it.
class BusinessSetupScreen extends ConsumerStatefulWidget {
  const BusinessSetupScreen({super.key});

  @override
  ConsumerState<BusinessSetupScreen> createState() => _BusinessSetupScreenState();
}

class _BusinessSetupScreenState extends ConsumerState<BusinessSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _currencyCode = TextEditingController(text: 'BDT');
  final _currencySymbol = TextEditingController(text: '৳');
  final _tax = TextEditingController(text: '5');
  final _service = TextEditingController(text: '0');
  final _ownerName = TextEditingController();
  final _username = TextEditingController();
  final _pin = TextEditingController();
  final _pinConfirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    for (final c in [
      _code,
      _name,
      _phone,
      _address,
      _currencyCode,
      _currencySymbol,
      _tax,
      _service,
      _ownerName,
      _username,
      _pin,
      _pinConfirm,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    try {
      await ref.read(sessionControllerProvider.notifier).provisionBusiness(
            provisioningCode: _code.text,
            business: Business(
              id: '',
              name: _name.text.trim(),
              phone: _phone.text.trim(),
              address: _address.text.trim(),
              currencyCode: _currencyCode.text.trim().toUpperCase(),
              currencySymbol: _currencySymbol.text.trim(),
              taxRate: double.tryParse(_tax.text) ?? 0,
              serviceChargeRate: double.tryParse(_service.text) ?? 0,
            ),
            ownerName: _ownerName.text,
            username: _username.text,
            pin: _pin.text,
          );
    } catch (e) {
      if (mounted) context.showSnack(errorMessageOf(e), error: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;

  String? _percent(String? v) {
    final value = double.tryParse(v ?? '');
    if (value == null || value < 0 || value > 100) return '0 – 100';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppSpacing.md);
    final percentFormatter =
        FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(\.\d{0,2})?'));

    return AuthLayout(
      heroTitle: 'Open your\nrestaurant.',
      heroSubtitle:
          'Create the business workspace and the owner account. You can add staff, tables and menu afterwards.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text('New restaurant', style: context.text.headlineSmall),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            if (AppConfig.provisioningCode.isNotEmpty) ...[
              const _SectionLabel('Authorisation'),
              TextFormField(
                controller: _code,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Provisioning code',
                  prefixIcon: Icon(Icons.key_rounded),
                ),
                validator: _required,
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
            const _SectionLabel('Restaurant'),
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Restaurant name',
                prefixIcon: Icon(Icons.storefront_rounded),
              ),
              validator: _required,
            ),
            gap,
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.call_outlined),
              ),
            ),
            gap,
            TextFormField(
              controller: _address,
              maxLines: 2,
              minLines: 1,
              decoration: const InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.place_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const _SectionLabel('Billing'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _currencyCode,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(labelText: 'Currency code'),
                    validator: _required,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextFormField(
                    controller: _currencySymbol,
                    decoration: const InputDecoration(labelText: 'Symbol'),
                    validator: _required,
                  ),
                ),
              ],
            ),
            gap,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _tax,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [percentFormatter],
                    decoration: const InputDecoration(labelText: 'VAT / Tax %'),
                    validator: _percent,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextFormField(
                    controller: _service,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [percentFormatter],
                    decoration: const InputDecoration(labelText: 'Service charge %'),
                    validator: _percent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            const _SectionLabel('Owner account'),
            TextFormField(
              controller: _ownerName,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Full name',
                prefixIcon: Icon(Icons.badge_outlined),
              ),
              validator: _required,
            ),
            gap,
            TextFormField(
              controller: _username,
              autocorrect: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9._-]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Username',
                helperText: 'Used once per device to activate it',
                prefixIcon: Icon(Icons.alternate_email_rounded),
              ),
              validator: (v) =>
                  (v == null || v.trim().length < 3) ? 'At least 3 characters' : null,
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _pin,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: AppConfig.pinLength,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: 'PIN', counterText: ''),
                    validator: (v) => PinHasher.validate(v ?? ''),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextFormField(
                    controller: _pinConfirm,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: AppConfig.pinLength,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: 'Confirm PIN',
                      counterText: '',
                    ),
                    validator: (v) => v != _pin.text ? 'PINs do not match' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            LoadingButton(
              label: 'Create restaurant',
              icon: Icons.rocket_launch_rounded,
              loading: _loading,
              expand: true,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Text(
        text.toUpperCase(),
        style: context.text.labelSmall?.copyWith(
          color: context.palette.textMuted,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
