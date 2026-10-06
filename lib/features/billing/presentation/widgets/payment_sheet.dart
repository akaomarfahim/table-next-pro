import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../domain/entities/bill.dart';
import '../controllers/bill_actions.dart';

class _PaymentLine {
  _PaymentLine(this.method, double amount)
      : controller = TextEditingController(text: amount == 0 ? '' : amount.toStringAsFixed(2));

  PaymentMethod method;
  final TextEditingController controller;
  final TextEditingController reference = TextEditingController();

  double get amount => double.tryParse(controller.text) ?? 0;

  void dispose() {
    controller.dispose();
    reference.dispose();
  }
}

/// Collects one or more payments (split tender) and settles the bill.
/// Pops with the settled [Bill].
class PaymentSheet extends ConsumerStatefulWidget {
  const PaymentSheet({super.key, required this.bill});

  final Bill bill;

  static Future<Bill?> show(BuildContext context, Bill bill) => showAdaptiveSheet<Bill>(
        context: context,
        maxWidth: 560,
        builder: (_) => PaymentSheet(bill: bill),
      );

  @override
  ConsumerState<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends ConsumerState<PaymentSheet> {
  late final List<_PaymentLine> _lines = [_PaymentLine(PaymentMethod.cash, widget.bill.totals.total)];
  bool _saving = false;

  double get _total => widget.bill.totals.total;
  double get _paid => _lines.fold(0.0, (s, l) => s + l.amount);
  double get _remaining => (_total - _paid).clamp(0.0, double.infinity);
  double get _change => (_paid - _total).clamp(0.0, double.infinity);

  @override
  void dispose() {
    for (final l in _lines) {
      l.dispose();
    }
    super.dispose();
  }

  void _addLine() {
    setState(() => _lines.add(_PaymentLine(PaymentMethod.card, _remaining)));
  }

  List<double> _quickCash() {
    final options = <double>{_total};
    for (final step in const [50, 100, 500, 1000]) {
      final rounded = (_total / step).ceil() * step.toDouble();
      if (rounded > _total) options.add(rounded);
    }
    return options.toList()..sort();
  }

  Future<void> _settle() async {
    if (_paid + 0.009 < _total) {
      context.showSnack('Payments do not cover the total yet.', error: true);
      return;
    }
    setState(() => _saving = true);
    try {
      final payments = [
        for (final l in _lines)
          if (l.amount > 0)
            Payment(
              method: l.method,
              amount: l.amount,
              reference: l.reference.text.trim(),
              receivedAt: DateTime.now(),
            ),
      ];
      final settled = await ref.read(billActionsProvider).settle(widget.bill, payments);
      if (mounted) Navigator.of(context).pop(settled);
    } catch (e) {
      if (mounted) context.showError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final business = ref.watch(currentBusinessProvider);
    String money(num v) => business?.money(v) ?? v.toStringAsFixed(2);
    final covered = _paid + 0.009 >= _total;

    return SheetScaffold(
      title: 'Take payment',
      subtitle: 'Bill #${widget.bill.billNumber} · ${widget.bill.title}',
      actions: [
        OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        LoadingButton(
          label: covered ? 'Complete · ${money(_total)}' : 'Remaining ${money(_remaining)}',
          icon: Icons.check_circle_rounded,
          loading: _saving,
          onPressed: covered ? _settle : null,
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.08),
              borderRadius: AppRadius.lgAll,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount due', style: context.text.labelLarge?.copyWith(color: context.palette.textMuted)),
                      Text(
                        money(_total),
                        style: context.text.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                if (_change > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Change', style: context.text.labelLarge?.copyWith(color: context.palette.textMuted)),
                      Text(
                        money(_change),
                        style: context.text.titleLarge?.copyWith(
                          color: context.palette.success,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (var i = 0; i < _lines.length; i++) ...[
            _PaymentLineEditor(
              line: _lines[i],
              onChanged: () => setState(() {}),
              onRemove: _lines.length > 1
                  ? () => setState(() => _lines.removeAt(i).dispose())
                  : null,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          if (_lines.first.method == PaymentMethod.cash) ...[
            Text('Quick cash', style: context.text.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final v in _quickCash())
                  ActionChip(
                    label: Text(v == _total ? 'Exact' : money(v)),
                    onPressed: () => setState(() => _lines.first.controller.text = v.toStringAsFixed(2)),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _addLine,
              icon: const Icon(Icons.call_split_rounded),
              label: const Text('Split payment'),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentLineEditor extends StatelessWidget {
  const _PaymentLineEditor({required this.line, required this.onChanged, this.onRemove});

  final _PaymentLine line;
  final VoidCallback onChanged;
  final VoidCallback? onRemove;

  IconData _icon(PaymentMethod m) => switch (m) {
        PaymentMethod.cash => Icons.payments_rounded,
        PaymentMethod.card => Icons.credit_card_rounded,
        PaymentMethod.mobile => Icons.phone_iphone_rounded,
        PaymentMethod.other => Icons.more_horiz_rounded,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: context.palette.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final m in PaymentMethod.values)
                      ChoiceChip(
                        avatar: Icon(_icon(m), size: 16),
                        label: Text(m.label),
                        selected: line.method == m,
                        showCheckmark: false,
                        onSelected: (_) {
                          line.method = m;
                          onChanged();
                        },
                      ),
                  ],
                ),
              ),
              if (onRemove != null)
                IconButton(onPressed: onRemove, icon: const Icon(Icons.close_rounded)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: line.controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                  decoration: const InputDecoration(labelText: 'Amount', isDense: true),
                  onChanged: (_) => onChanged(),
                ),
              ),
              if (line.method != PaymentMethod.cash) ...[
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextField(
                    controller: line.reference,
                    decoration: const InputDecoration(labelText: 'Reference / TrxID', isDense: true),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
