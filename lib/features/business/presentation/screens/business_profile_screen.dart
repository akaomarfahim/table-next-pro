import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../auth/domain/entities/user_role.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../data/repositories/business_repository_impl.dart';
import '../../domain/entities/business.dart';

/// Edit the restaurant profile and billing configuration.
class BusinessProfileScreen extends ConsumerStatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  ConsumerState<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends ConsumerState<BusinessProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  Business? _initial;
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _currencyCode = TextEditingController();
  final _currencySymbol = TextEditingController();
  final _tax = TextEditingController();
  final _service = TextEditingController();
  final _footer = TextEditingController();
  int _duration = 90;
  RangeValues _hours = const RangeValues(10, 23);
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final business = ref.read(currentBusinessProvider);
    if (business != null) _fill(business);
  }

  void _fill(Business b) {
    _initial = b;
    _name.text = b.name;
    _phone.text = b.phone;
    _email.text = b.email;
    _address.text = b.address;
    _currencyCode.text = b.currencyCode;
    _currencySymbol.text = b.currencySymbol;
    _tax.text = _trim(b.taxRate);
    _service.text = _trim(b.serviceChargeRate);
    _footer.text = b.billFooter;
    _duration = b.defaultReservationMinutes;
    _hours = RangeValues(b.openingHour.toDouble(), b.closingHour.toDouble());
  }

  String _trim(double v) => v == v.roundToDouble() ? v.toInt().toString() : v.toString();

  @override
  void dispose() {
    for (final c in [
      _name,
      _phone,
      _email,
      _address,
      _currencyCode,
      _currencySymbol,
      _tax,
      _service,
      _footer,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final initial = _initial;
    if (initial == null || !(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final updated = initial.copyWith(
      name: _name.text.trim(),
      phone: _phone.text.trim(),
      email: _email.text.trim(),
      address: _address.text.trim(),
      currencyCode: _currencyCode.text.trim().toUpperCase(),
      currencySymbol: _currencySymbol.text.trim(),
      taxRate: double.tryParse(_tax.text) ?? 0,
      serviceChargeRate: double.tryParse(_service.text) ?? 0,
      billFooter: _footer.text.trim(),
      defaultReservationMinutes: _duration,
      openingHour: _hours.start.round(),
      closingHour: _hours.end.round(),
    );
    try {
      await ref.read(businessRepositoryProvider).updateBusiness(updated);
      ref.read(sessionControllerProvider.notifier).replaceBusiness(updated);
      if (mounted) context.showSnack('Restaurant profile saved');
    } catch (e) {
      if (mounted) context.showError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String? _percent(String? v) {
    final value = double.tryParse(v ?? '');
    if (value == null || value < 0 || value > 100) return '0 – 100';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final canEdit = ref.watch(hasPermissionProvider(Permission.manageBusiness));
    if (_initial == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!canEdit) {
      return Scaffold(
        appBar: AppBar(title: const Text('Restaurant profile')),
        body: const EmptyState(
          icon: Icons.lock_outline_rounded,
          title: 'Restricted',
          message: 'Only owners and managers can edit the restaurant profile.',
        ),
      );
    }

    const gap = SizedBox(height: AppSpacing.md);
    final decimal = [FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(\.\d{0,2})?'))];

    final profile = SectionCard(
      title: 'Restaurant',
      subtitle: 'Shown on receipts and the lock screen',
      icon: Icons.storefront_rounded,
      child: Column(
        children: [
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          gap,
          TextFormField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          gap,
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          gap,
          TextFormField(
            controller: _address,
            minLines: 1,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Address'),
          ),
        ],
      ),
    );

    final billing = SectionCard(
      title: 'Billing',
      subtitle: 'Currency, VAT and service charge',
      icon: Icons.payments_rounded,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _currencyCode,
                  decoration: const InputDecoration(labelText: 'Currency code'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: TextFormField(
                  controller: _currencySymbol,
                  decoration: const InputDecoration(labelText: 'Symbol'),
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
                  inputFormatters: decimal,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'VAT / Tax %'),
                  validator: _percent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: TextFormField(
                  controller: _service,
                  inputFormatters: decimal,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Service charge %'),
                  validator: _percent,
                ),
              ),
            ],
          ),
          gap,
          TextFormField(
            controller: _footer,
            minLines: 1,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Receipt footer'),
          ),
        ],
      ),
    );

    final reservations = SectionCard(
      title: 'Reservations',
      subtitle: 'Defaults for new bookings',
      icon: Icons.event_available_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Default duration', style: context.text.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final m in const [60, 90, 120, 150, 180])
                ChoiceChip(
                  label: Text('${m ~/ 60}h${m % 60 == 0 ? '' : ' ${m % 60}m'}'),
                  selected: _duration == m,
                  onSelected: (_) => setState(() => _duration = m),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Opening hours: ${_hours.start.round()}:00 – ${_hours.end.round()}:00',
            style: context.text.titleSmall,
          ),
          RangeSlider(
            values: _hours,
            min: 0,
            max: 24,
            divisions: 24,
            labels: RangeLabels('${_hours.start.round()}:00', '${_hours.end.round()}:00'),
            onChanged: (v) {
              if (v.end - v.start >= 1) setState(() => _hours = v);
            },
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: LoadingButton(
              label: 'Save',
              icon: Icons.check_rounded,
              loading: _saving,
              onPressed: _save,
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: context.pagePadding,
          child: MaxWidthBox(
            maxWidth: 1100,
            child: context.isCompact
                ? Column(
                    children: [
                      profile,
                      gap,
                      billing,
                      gap,
                      reservations,
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: profile),
                      const SizedBox(width: AppSpacing.lg),
                      Expanded(
                        child: Column(children: [billing, gap, reservations]),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
