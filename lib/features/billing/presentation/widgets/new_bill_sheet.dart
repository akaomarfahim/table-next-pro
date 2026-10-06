import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../customers/domain/entities/customer.dart';
import '../../../customers/presentation/widgets/customer_autocomplete_field.dart';
import '../../../floor_plan/domain/entities/floor_element.dart';
import '../../../floor_plan/presentation/controllers/floor_providers.dart';
import '../../domain/entities/bill.dart';
import '../controllers/bill_actions.dart';
import '../controllers/billing_providers.dart';

/// Starts a new bill (dine-in with tables, takeaway or delivery).
/// Pops with the new bill id.
class NewBillSheet extends ConsumerStatefulWidget {
  const NewBillSheet({super.key});

  static Future<String?> show(BuildContext context) => showAdaptiveSheet<String>(
        context: context,
        maxWidth: 640,
        builder: (_) => const NewBillSheet(),
      );

  @override
  ConsumerState<NewBillSheet> createState() => _NewBillSheetState();
}

class _NewBillSheetState extends ConsumerState<NewBillSheet> {
  OrderType _type = OrderType.dineIn;
  final Set<String> _tableIds = {};
  int _guests = 2;
  Customer? _customer;
  final _phone = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  Future<void> _create(List<FloorElement> tables) async {
    setState(() => _saving = true);
    try {
      final bill = await ref.read(billActionsProvider).openBill(
            type: _type,
            tables: tables.where((t) => _tableIds.contains(t.id)).toList(),
            guests: _guests,
            customerId: _customer?.id,
            customerName: _customer?.name ?? '',
            customerPhone: _customer?.phone ?? _phone.text.trim(),
          );
      if (mounted) Navigator.of(context).pop(bill.id);
    } catch (e) {
      if (mounted) context.showError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tables = ref.watch(allTablesProvider).value ?? const <FloorElement>[];
    final openBills = ref.watch(openBillsProvider).value ?? const <Bill>[];
    final busy = {for (final b in openBills) ...b.tableIds};

    return SheetScaffold(
      title: 'New bill',
      actions: [
        OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        LoadingButton(
          label: 'Start bill',
          icon: Icons.point_of_sale_rounded,
          loading: _saving,
          onPressed: _type == OrderType.dineIn && _tableIds.isEmpty ? null : () => _create(tables),
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedButton<OrderType>(
            segments: const [
              ButtonSegment(value: OrderType.dineIn, icon: Icon(Icons.table_restaurant_rounded), label: Text('Dine-in')),
              ButtonSegment(value: OrderType.takeaway, icon: Icon(Icons.takeout_dining_rounded), label: Text('Takeaway')),
              ButtonSegment(value: OrderType.delivery, icon: Icon(Icons.delivery_dining_rounded), label: Text('Delivery')),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.first),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_type == OrderType.dineIn) ...[
            Text('Tables', style: context.text.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            if (tables.isEmpty)
              Text(
                'No tables configured yet — use the floor plan editor.',
                style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
              )
            else
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final t in tables)
                    FilterChip(
                      label: Text('${t.label} · ${t.seats}'),
                      selected: _tableIds.contains(t.id),
                      avatar: busy.contains(t.id)
                          ? Icon(Icons.restaurant_rounded, size: 16, color: context.palette.tableOccupied)
                          : null,
                      tooltip: busy.contains(t.id) ? 'Has an open bill' : null,
                      onSelected: busy.contains(t.id)
                          ? null
                          : (v) => setState(() => v ? _tableIds.add(t.id) : _tableIds.remove(t.id)),
                    ),
                ],
              ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Row(
            children: [
              Expanded(child: Text('Guests', style: context.text.titleSmall)),
              QuantityStepper(value: _guests, max: 200, onChanged: (v) => setState(() => _guests = v)),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          CustomerAutocompleteField(
            controller: _phone,
            label: 'Customer phone (optional)',
            onSelected: (c) => setState(() => _customer = c),
            onChanged: (_) {
              if (_customer != null) setState(() => _customer = null);
            },
          ),
          if (_customer != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Row(
                children: [
                  Icon(Icons.check_circle_rounded, size: 18, color: context.palette.success),
                  const SizedBox(width: AppSpacing.sm),
                  Text('${_customer!.name} · ${_customer!.visitCount} visits'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
