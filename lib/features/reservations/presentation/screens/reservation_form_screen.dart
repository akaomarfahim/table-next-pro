import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../../customers/data/repositories/customer_repository_impl.dart';
import '../../../customers/domain/entities/customer.dart';
import '../../../customers/presentation/widgets/customer_autocomplete_field.dart';
import '../../../floor_plan/domain/entities/floor_element.dart';
import '../../../floor_plan/presentation/controllers/floor_providers.dart';
import '../../data/repositories/reservation_repository_impl.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/services/table_availability.dart';
import '../controllers/reservation_actions.dart';
import '../controllers/reservation_providers.dart';
import '../widgets/customer_insight_card.dart';
import '../widgets/reservation_status_style.dart';
import '../widgets/table_picker_dialog.dart';

/// Create or edit a reservation.
///
/// * Customer lookup by phone or name with auto-fill.
/// * Returning guests show their stats and previous reservations.
/// * Table selection on the floor plan with live conflict detection.
class ReservationFormScreen extends ConsumerStatefulWidget {
  const ReservationFormScreen({
    super.key,
    this.reservationId,
    this.initialTableId,
    this.initialDate,
    this.initialCustomerId,
  });

  final String? reservationId;
  final String? initialTableId;
  final DateTime? initialDate;
  final String? initialCustomerId;

  @override
  ConsumerState<ReservationFormScreen> createState() => _ReservationFormScreenState();
}

class _ReservationFormScreenState extends ConsumerState<ReservationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _notes = TextEditingController();

  Reservation? _existing;
  Customer? _customer;
  int _partySize = 2;
  late DateTime _date;
  late TimeOfDay _time;
  int _duration = 90;
  Set<String> _tableIds = {};
  ReservationStatus _status = ReservationStatus.confirmed;
  ReservationSource _source = ReservationSource.phone;
  ReservationOccasion _occasion = ReservationOccasion.none;
  bool _loading = true;
  bool _saving = false;
  Object? _loadError;

  bool get _isEdit => widget.reservationId != null;

  DateTime get _start => DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
  DateTime get _end => _start.add(Duration(minutes: _duration));

  @override
  void initState() {
    super.initState();
    final business = ref.read(currentBusinessProvider);
    _duration = business?.defaultReservationMinutes ?? 90;
    final now = DateTime.now();
    final initial = widget.initialDate;
    final base = initial ?? now;
    _date = DateUtilsX.startOfDay(base);
    final hasTime = initial != null && (initial.hour != 0 || initial.minute != 0);
    final rounded = DateUtilsX.roundUp(
      hasTime ? initial! : (DateUtilsX.isSameDay(base, now) ? now : DateTime(base.year, base.month, base.day, 19)),
    );
    _time = TimeOfDay(hour: rounded.hour, minute: rounded.minute);
    if (widget.initialTableId != null) _tableIds = {widget.initialTableId!};
    _load();
  }

  Future<void> _load() async {
    try {
      if (_isEdit) {
        final r = await ref.read(reservationRepositoryProvider).watchById(widget.reservationId!).first;
        if (r == null) throw StateError('Reservation not found');
        _existing = r;
        _partySize = r.partySize;
        _date = DateUtilsX.startOfDay(r.startAt);
        _time = TimeOfDay.fromDateTime(r.startAt);
        _duration = r.durationMinutes;
        _tableIds = r.tableIds.toSet();
        _status = r.status;
        _source = r.source;
        _occasion = r.occasion;
        _notes.text = r.notes;
        _phone.text = r.customerPhone;
        _name.text = r.customerName;
        _customer = await ref.read(customerRepositoryProvider).getById(r.customerId);
        _email.text = _customer?.email ?? '';
      } else if (widget.initialCustomerId != null) {
        final c = await ref.read(customerRepositoryProvider).getById(widget.initialCustomerId!);
        if (c != null) _applyCustomer(c, notify: false);
      }
    } catch (e) {
      _loadError = e;
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _phone.dispose();
    _name.dispose();
    _email.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _applyCustomer(Customer c, {bool notify = true}) {
    _customer = c;
    _phone.text = c.phone;
    _name.text = c.name;
    _email.text = c.email;
    if (notify) setState(() {});
  }

  void _onContactEdited(String _) {
    final c = _customer;
    if (c == null) return;
    if (PhoneUtils.normalize(_phone.text) != PhoneUtils.normalize(c.phone)) {
      setState(() => _customer = null);
    }
  }

  Map<String, Reservation> _conflicts(List<Reservation> window) => TableAvailability.conflicts(
        reservations: window,
        start: _start,
        end: _end,
        excludeReservationId: _existing?.id,
      );

  Future<void> _pickTables(Map<String, Reservation> conflicts) async {
    final result = await TablePickerDialog.show(
      context,
      partySize: _partySize,
      conflicts: conflicts,
      initialSelection: _tableIds,
      windowLabel: '${Formatters.dayShort(_date)} · ${Formatters.timeRange(_start, _end)}',
    );
    if (result != null) setState(() => _tableIds = result);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _save(Map<String, Reservation> conflicts, List<FloorElement> tables) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final clashing = _tableIds.where(conflicts.containsKey).toList();
    if (clashing.isNotEmpty) {
      final labels = tables.where((t) => clashing.contains(t.id)).map((t) => t.label).join(', ');
      final ok = await showConfirmDialog(
        context,
        title: 'Double booking',
        message: 'Table $labels is already booked in this time window. Save anyway?',
        confirmLabel: 'Save anyway',
        destructive: true,
      );
      if (!ok) return;
    }
    if (_tableIds.isEmpty && mounted) {
      final ok = await showConfirmDialog(
        context,
        title: 'No table assigned',
        message: 'Save this reservation without a table? You can assign one later.',
        confirmLabel: 'Save',
      );
      if (!ok) return;
    }

    setState(() => _saving = true);
    try {
      final user = ref.read(currentUserProvider);
      final customers = ref.read(customerRepositoryProvider);
      final customer = _customer ??
          await customers.upsertByPhone(
            name: _name.text.trim(),
            phone: _phone.text.trim(),
            email: _email.text.trim(),
          );
      final selectedTables = tables.where((t) => _tableIds.contains(t.id)).toList()
        ..sort((a, b) => naturalCompare(a.label, b.label));

      final draft = (_existing ??
              Reservation(
                id: '',
                customerId: customer.id,
                customerName: customer.name,
                customerPhone: customer.phone,
                partySize: _partySize,
                startAt: _start,
                durationMinutes: _duration,
                createdById: user?.id ?? '',
                createdByName: user?.name ?? '',
              ))
          .copyWith(
        customerId: customer.id,
        customerName: _name.text.trim().isEmpty ? customer.name : _name.text.trim(),
        customerPhone: customer.phone,
        partySize: _partySize,
        startAt: _start,
        durationMinutes: _duration,
        tableIds: selectedTables.map((t) => t.id).toList(),
        tableLabels: selectedTables.map((t) => t.label).toList(),
        status: _status,
        source: _source,
        occasion: _occasion,
        notes: _notes.text.trim(),
      );

      final repo = ref.read(reservationRepositoryProvider);
      if (_isEdit) {
        await repo.update(draft);
      } else {
        await repo.create(draft);
      }
      ref.invalidate(customerReservationsProvider(customer.id));
      ref.read(selectedReservationDateProvider.notifier).set(_date);
      if (!mounted) return;
      context.showSnack(_isEdit ? 'Reservation updated' : 'Reservation booked for ${customer.name}');
      context.go(AppRoutes.reservations);
    } catch (e) {
      if (mounted) context.showError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_loadError != null) {
      return Scaffold(
        appBar: AppBar(),
        body: ErrorState(error: _loadError!, onRetry: () {
          setState(() {
            _loading = true;
            _loadError = null;
          });
          _load();
        }),
      );
    }

    final window = ref.watch(reservationsWindowProvider(_date)).value ?? const <Reservation>[];
    final tables = ref.watch(allTablesProvider).value ?? const <FloorElement>[];
    final conflicts = _conflicts(window);
    final business = ref.watch(currentBusinessProvider);
    final selectedTables = tables.where((t) => _tableIds.contains(t.id)).toList();
    final seats = selectedTables.fold<int>(0, (s, t) => s + t.seats);
    final clashing = selectedTables.where((t) => conflicts.containsKey(t.id)).toList();
    final wide = context.screenSize.width >= Breakpoints.twoPane;

    final guestSection = SectionCard(
      title: 'Guest',
      subtitle: 'Search by phone or name — details fill in automatically',
      icon: Icons.person_search_rounded,
      child: Column(
        children: [
          CustomerAutocompleteField(
            controller: _phone,
            label: 'Phone *',
            phoneMode: true,
            autofocus: !_isEdit && _customer == null,
            onSelected: _applyCustomer,
            onChanged: _onContactEdited,
            textInputAction: TextInputAction.next,
            validator: (v) => PhoneUtils.isValid(v ?? '') ? null : 'Enter a valid phone number',
          ),
          const SizedBox(height: AppSpacing.md),
          CustomerAutocompleteField(
            controller: _name,
            label: 'Guest name *',
            icon: Icons.person_outline_rounded,
            phoneMode: false,
            onSelected: _applyCustomer,
            textInputAction: TextInputAction.next,
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email (optional)',
              prefixIcon: Icon(Icons.mail_outline_rounded),
            ),
          ),
          if (_customer == null && PhoneUtils.isValid(_phone.text)) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Icon(Icons.person_add_alt_rounded, size: 18, color: context.palette.info),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'A new customer profile will be created (or matched by phone) on save.',
                    style: context.text.bodySmall?.copyWith(color: context.palette.info),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );

    final timeSlots = <TimeOfDay>[
      for (var h = business?.openingHour ?? 10; h < (business?.closingHour ?? 23); h++)
        for (final m in const [0, 30]) TimeOfDay(hour: h, minute: m),
    ];

    final bookingSection = SectionCard(
      title: 'Booking',
      icon: Icons.event_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('Party size', style: context.text.titleSmall)),
              QuantityStepper(
                value: _partySize,
                max: 200,
                onChanged: (v) => setState(() => _partySize = v),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final today = DateUtilsX.startOfDay(DateTime.now());
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: today.subtract(const Duration(days: 30)),
                      lastDate: today.add(const Duration(days: 365)),
                    );
                    if (picked != null) setState(() => _date = DateUtilsX.startOfDay(picked));
                  },
                  icon: const Icon(Icons.calendar_month_rounded),
                  label: Text(Formatters.dayShort(_date)),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.schedule_rounded),
                  label: Text(_time.format(context)),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: timeSlots.length,
              separatorBuilder: (_, _) => const SizedBox(width: 6),
              itemBuilder: (context, i) {
                final slot = timeSlots[i];
                return ChoiceChip(
                  label: Text(slot.format(context)),
                  selected: slot == _time,
                  onSelected: (_) => setState(() => _time = slot),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Duration', style: context.text.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final m in const [60, 90, 120, 150, 180, 240])
                ChoiceChip(
                  label: Text(Formatters.duration(Duration(minutes: m))),
                  selected: _duration == m,
                  onSelected: (_) => setState(() => _duration = m),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            Formatters.timeRange(_start, _end),
            style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
          ),
        ],
      ),
    );

    final tableSection = SectionCard(
      title: 'Tables',
      subtitle: 'Availability checked for the selected time',
      icon: Icons.table_restaurant_rounded,
      trailing: TextButton.icon(
        onPressed: () {
          final suggestion = TableAvailability.suggest(
            tables: tables,
            unavailableIds: conflicts.keys.toSet(),
            partySize: _partySize,
          );
          if (suggestion.isEmpty) {
            context.showSnack('No free table fits $_partySize guests at this time.', error: true);
          } else {
            setState(() => _tableIds = suggestion.map((t) => t.id).toSet());
          }
        },
        icon: const Icon(Icons.auto_awesome_rounded, size: 18),
        label: const Text('Auto'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (selectedTables.isEmpty)
            Text(
              'No table selected',
              style: context.text.bodyMedium?.copyWith(color: context.palette.textMuted),
            )
          else
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final t in selectedTables)
                  InputChip(
                    avatar: Icon(
                      conflicts.containsKey(t.id) ? Icons.warning_amber_rounded : Icons.table_restaurant_rounded,
                      size: 18,
                      color: conflicts.containsKey(t.id) ? context.palette.danger : null,
                    ),
                    label: Text('${t.label} · ${t.seats}'),
                    onDeleted: () => setState(() => _tableIds = _tableIds.toSet()..remove(t.id)),
                  ),
              ],
            ),
          const SizedBox(height: AppSpacing.md),
          if (selectedTables.isNotEmpty)
            Text(
              '$seats seats for $_partySize guests',
              style: context.text.bodySmall?.copyWith(
                color: seats >= _partySize ? context.palette.success : context.palette.warning,
                fontWeight: FontWeight.w700,
              ),
            ),
          if (clashing.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Text(
                '${clashing.map((t) => t.label).join(', ')} already booked at '
                '${Formatters.time(conflicts[clashing.first.id]!.startAt)} '
                '(${conflicts[clashing.first.id]!.customerName}).',
                style: context.text.bodySmall?.copyWith(color: context.palette.danger),
              ),
            ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: () => _pickTables(conflicts),
            icon: const Icon(Icons.map_rounded),
            label: const Text('Choose on floor plan'),
          ),
        ],
      ),
    );

    final detailsSection = SectionCard(
      title: 'Details',
      icon: Icons.tune_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status', style: context.text.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          if ((_isEdit && _status.isFinal) || _status == ReservationStatus.seated)
            StatusBadge(label: _status.label, color: _status.color(context))
          else
            SegmentedButton<ReservationStatus>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: ReservationStatus.pending, label: Text('Pending')),
                ButtonSegment(value: ReservationStatus.confirmed, label: Text('Confirmed')),
              ],
              selected: {_status},
              onSelectionChanged: (s) => setState(() => _status = s.first),
            ),
          const SizedBox(height: AppSpacing.lg),
          Text('Source', style: context.text.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final s in ReservationSource.values)
                ChoiceChip(
                  label: Text(s.label),
                  selected: _source == s,
                  onSelected: (_) => setState(() => _source = s),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Occasion', style: context.text.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final o in ReservationOccasion.values)
                ChoiceChip(
                  label: Text(o.label),
                  selected: _occasion == o,
                  onSelected: (_) => setState(() => _occasion = o),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          TextFormField(
            controller: _notes,
            minLines: 2,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Notes / special requests',
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );

    final insight = _customer == null
        ? AppCard(
            child: Row(
              children: [
                Icon(Icons.person_search_rounded, color: context.palette.textMuted),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    'Select a returning guest to see their visits and previous reservations.',
                    style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                  ),
                ),
              ],
            ),
          )
        : CustomerInsightCard(customer: _customer!, excludeReservationId: _existing?.id);

    const gap = SizedBox(height: AppSpacing.lg);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit reservation' : 'New reservation'),
        actions: [
          if (_existing != null)
            PopupMenuButton<ReservationStatus>(
              tooltip: 'Change status',
              icon: const Icon(Icons.more_vert_rounded),
              onSelected: (s) => applyReservationStatus(context, ref, _existing!, s),
              itemBuilder: (_) => [
                for (final s in nextStatuses(_existing!.status))
                  PopupMenuItem(
                    value: s,
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(s.icon, color: s.color(context)),
                      title: Text('Mark ${s.label.toLowerCase()}'),
                    ),
                  ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: LoadingButton(
              label: _isEdit ? 'Save' : 'Book',
              icon: Icons.check_rounded,
              loading: _saving,
              onPressed: () => _save(conflicts, tables),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: context.pagePadding,
          child: MaxWidthBox(
            maxWidth: 1200,
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [guestSection, gap, bookingSection, gap, detailsSection],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      Expanded(
                        flex: 2,
                        child: Column(children: [insight, gap, tableSection]),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      guestSection,
                      gap,
                      if (_customer != null) ...[insight, gap],
                      bookingSection,
                      gap,
                      tableSection,
                      gap,
                      detailsSection,
                      const SizedBox(height: 80),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
