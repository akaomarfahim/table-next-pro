import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../auth/domain/entities/user_role.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../../business/domain/entities/business.dart';
import '../../../menu/domain/entities/menu_entities.dart';
import '../../../menu/presentation/controllers/menu_providers.dart';
import '../../data/services/invoice_pdf_service.dart';
import '../../domain/entities/bill.dart';
import '../../domain/services/bill_editing.dart';
import '../controllers/bill_actions.dart';
import '../controllers/billing_providers.dart';
import '../widgets/payment_sheet.dart';

/// Point-of-sale screen for one bill.
///
/// Edits are applied optimistically to a local copy (so rapid taps never
/// lose updates) and written through to Firestore in order.
class BillScreen extends ConsumerStatefulWidget {
  const BillScreen({super.key, required this.billId});

  final String billId;

  @override
  ConsumerState<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends ConsumerState<BillScreen> {
  Bill? _local;
  int _pending = 0;
  Future<void> _queue = Future.value();

  Bill? get _current => _local ?? ref.read(billByIdProvider(widget.billId)).value;

  void _apply(Bill Function(Bill bill) change) {
    final current = _current;
    if (current == null || !current.isOpen) return;
    final next = change(current);
    setState(() {
      _local = next;
      _pending++;
    });
    final actions = ref.read(billActionsProvider);
    _queue = _queue.then((_) => actions.save(next)).catchError((Object e) {
      if (mounted) context.showError(e);
    }).whenComplete(() {
      if (!mounted) return;
      setState(() {
        _pending--;
        if (_pending == 0) _local = null; // Fall back to the live document.
      });
    });
  }

  Future<void> _pay(Bill bill, Business business) async {
    if (bill.items.isEmpty) {
      context.showSnack('Add items before taking payment.', error: true);
      return;
    }
    await _queue; // Make sure every edit is persisted first.
    if (!mounted) return;
    final settled = await PaymentSheet.show(context, _current ?? bill);
    if (settled == null || !mounted) return;
    context.showSnack('Payment complete · ${business.money(settled.totals.total)}');
    final shouldPrint = await showConfirmDialog(
      context,
      title: 'Print receipt?',
      message: 'Bill #${settled.billNumber} has been settled.',
      confirmLabel: 'Print',
      cancelLabel: 'Not now',
    );
    if (shouldPrint) await const InvoicePdfService().printBill(settled, business);
  }

  Future<void> _discount(Bill bill, Business business) async {
    final result = await showDialog<(DiscountType, double)>(
      context: context,
      builder: (_) => _DiscountDialog(bill: bill, currencySymbol: business.currencySymbol),
    );
    if (result == null) return;
    final (t, v) = result;
    if (t == DiscountType.percent && v > 100) {
      if (mounted) context.showSnack('Discount cannot exceed 100%', error: true);
      return;
    }
    _apply((b) => BillEditing.setDiscount(b, v <= 0 ? DiscountType.none : t, v));
  }

  Future<void> _editNote(BillItem item) async {
    final note = await showTextPrompt(
      context,
      title: 'Note for ${item.name}',
      label: 'e.g. no onion, extra spicy',
      initialValue: item.note,
    );
    if (note != null) _apply((b) => BillEditing.setNote(b, item.lineId, note));
  }

  Future<void> _void(Bill bill) async {
    final reason = await showTextPrompt(
      context,
      title: 'Void bill #${bill.billNumber}?',
      label: 'Reason',
      confirmLabel: 'Void bill',
      validator: (v) => v.trim().length < 3 ? 'Please give a reason' : null,
    );
    if (reason == null) return;
    try {
      await ref.read(billActionsProvider).voidBill(bill, reason);
      if (mounted) {
        context.showSnack('Bill voided');
        context.go(AppRoutes.billing);
      }
    } catch (e) {
      if (mounted) context.showError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final remote = ref.watch(billByIdProvider(widget.billId));
    final business = ref.watch(currentBusinessProvider);
    final canVoid = ref.watch(hasPermissionProvider(Permission.voidBills));
    final canSettle = ref.watch(hasPermissionProvider(Permission.settleBills));

    if (business == null) return const Scaffold(body: SizedBox.shrink());

    return remote.when(
      skipLoadingOnReload: true,
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(appBar: AppBar(), body: ErrorState(error: e)),
      data: (live) {
        if (live == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const EmptyState(icon: Icons.receipt_long_rounded, title: 'Bill not found'),
          );
        }
        final bill = (_local != null && live.isOpen) ? _local! : live;
        const pdf = InvoicePdfService();

        final ticket = _TicketPanel(
          bill: bill,
          business: business,
          syncing: _pending > 0,
          onQuantity: (item, q) => _apply((b) => BillEditing.setQuantity(b, item.lineId, q)),
          onNote: _editNote,
          onGuests: (g) => _apply((b) => BillEditing.setGuests(b, g)),
          onDiscount: () => _discount(bill, business),
          onServiceToggle: (on) => _apply(
            (b) => BillEditing.setServiceRate(b, on ? business.serviceChargeRate : 0),
          ),
          onPay: canSettle ? () => _pay(bill, business) : null,
          onPrint: () => pdf.printBill(bill, business),
        );

        final menu = _MenuPanel(
          enabled: bill.isOpen,
          business: business,
          onAdd: (p) {
            HapticFeedback.selectionClick();
            _apply(
              (b) => BillEditing.addItem(b, menuItemId: p.id, name: p.name, unitPrice: p.price),
            );
          },
        );

        final appBar = AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bill #${bill.billNumber}'),
              Text(
                '${bill.title} · ${bill.status.label}',
                style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Print',
              onPressed: () => pdf.printBill(bill, business).catchError((Object e) {
                if (context.mounted) context.showError(e);
              }),
              icon: const Icon(Icons.print_rounded),
            ),
            IconButton(
              tooltip: 'Share PDF',
              onPressed: () => pdf.shareBill(bill, business).catchError((Object e) {
                if (context.mounted) context.showError(e);
              }),
              icon: const Icon(Icons.ios_share_rounded),
            ),
            if (bill.isOpen && canVoid)
              PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'void') _void(bill);
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'void',
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.block_rounded, color: context.palette.danger),
                      title: const Text('Void bill'),
                    ),
                  ),
                ],
              ),
            const SizedBox(width: AppSpacing.sm),
          ],
        );

        if (!bill.isOpen) {
          return Scaffold(
            appBar: appBar,
            body: MaxWidthBox(maxWidth: 520, child: ticket),
          );
        }

        if (context.screenSize.width >= Breakpoints.twoPane) {
          return Scaffold(
            appBar: appBar,
            body: Row(
              children: [
                Expanded(child: menu),
                const VerticalDivider(width: 1),
                SizedBox(width: context.screenClass.isExpanded ? 420 : 380, child: ticket),
              ],
            ),
          );
        }

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: appBar.title,
              actions: appBar.actions,
              bottom: TabBar(
                tabAlignment: TabAlignment.fill,
                tabs: [
                  const Tab(text: 'Menu'),
                  Tab(text: 'Ticket (${bill.itemCount})'),
                ],
              ),
            ),
            body: TabBarView(children: [menu, ticket]),
          ),
        );
      },
    );
  }
}

class _DiscountDialog extends StatefulWidget {
  const _DiscountDialog({required this.bill, required this.currencySymbol});

  final Bill bill;
  final String currencySymbol;

  @override
  State<_DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<_DiscountDialog> {
  late DiscountType _type = widget.bill.discountType == DiscountType.none
      ? DiscountType.percent
      : widget.bill.discountType;
  late final TextEditingController _controller = TextEditingController(
    text: widget.bill.discountValue == 0 ? '' : widget.bill.discountValue.toString(),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Discount'),
      content: SizedBox(
        width: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<DiscountType>(
              segments: [
                const ButtonSegment(value: DiscountType.percent, label: Text('Percent %')),
                ButtonSegment(value: DiscountType.amount, label: Text('Amount ${widget.currencySymbol}')),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _controller,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
              decoration: InputDecoration(
                labelText: _type == DiscountType.percent ? 'Percentage' : 'Amount',
                suffixText: _type == DiscountType.percent ? '%' : widget.currencySymbol,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                for (final p in const [5, 10, 15, 20])
                  ActionChip(
                    label: Text('$p%'),
                    onPressed: () => setState(() {
                      _type = DiscountType.percent;
                      _controller.text = '$p';
                    }),
                  ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop((DiscountType.none, 0.0)),
          child: const Text('Remove'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop((_type, double.tryParse(_controller.text) ?? 0.0)),
          child: const Text('Apply'),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Menu panel
// -----------------------------------------------------------------------------

class _MenuPanel extends ConsumerStatefulWidget {
  const _MenuPanel({required this.enabled, required this.business, required this.onAdd});

  final bool enabled;
  final Business business;
  final ValueChanged<MenuProduct> onAdd;

  @override
  ConsumerState<_MenuPanel> createState() => _MenuPanelState();
}

class _MenuPanelState extends ConsumerState<_MenuPanel> {
  String? _categoryId;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(menuCategoriesProvider).value ?? const <MenuCategory>[];
    final items = ref.watch(menuItemsProvider).value ?? const <MenuProduct>[];
    final selected = _categoryId;

    final visible = items.where((i) {
      if (_query.isNotEmpty) {
        return i.name.toLowerCase().contains(_query) || i.code.toLowerCase() == _query;
      }
      return selected == null || i.categoryId == selected;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
          child: AppSearchField(
            hint: 'Search menu or type code…',
            onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            children: [
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: ChoiceChip(
                  label: const Text('All'),
                  selected: selected == null,
                  onSelected: (_) => setState(() => _categoryId = null),
                ),
              ),
              for (final c in categories)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: ChoiceChip(
                    label: Text(c.name),
                    selected: selected == c.id,
                    onSelected: (_) => setState(() => _categoryId = c.id),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: visible.isEmpty
              ? const EmptyState(
                  icon: Icons.restaurant_menu_rounded,
                  title: 'No menu items',
                  message: 'Add items in the Menu section.',
                  compact: true,
                )
              : LayoutBuilder(
                  builder: (context, c) {
                    final cols = adaptiveColumns(c.maxWidth, minTileWidth: 170, maxColumns: 6);
                    return GridView.builder(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols,
                        mainAxisExtent: 104,
                        crossAxisSpacing: AppSpacing.sm,
                        mainAxisSpacing: AppSpacing.sm,
                      ),
                      itemCount: visible.length,
                      itemBuilder: (context, i) => _ProductTile(
                        product: visible[i],
                        price: widget.business.money(visible[i].price),
                        onTap: widget.enabled && visible[i].available
                            ? () => widget.onAdd(visible[i])
                            : null,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.product, required this.price, this.onTap});

  final MenuProduct product;
  final String price;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    return Opacity(
      opacity: disabled ? 0.45 : 1,
      child: Material(
        color: context.colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdAll,
          side: BorderSide(color: context.palette.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.titleSmall,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        price,
                        style: context.text.labelLarge?.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (!product.available)
                      Text('Sold out', style: context.text.labelSmall?.copyWith(color: context.palette.danger))
                    else
                      Icon(Icons.add_circle_rounded, color: context.colors.primary, size: 22),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Ticket panel
// -----------------------------------------------------------------------------

class _TicketPanel extends StatelessWidget {
  const _TicketPanel({
    required this.bill,
    required this.business,
    required this.syncing,
    required this.onQuantity,
    required this.onNote,
    required this.onGuests,
    required this.onDiscount,
    required this.onServiceToggle,
    required this.onPay,
    required this.onPrint,
  });

  final Bill bill;
  final Business business;
  final bool syncing;
  final void Function(BillItem item, int quantity) onQuantity;
  final ValueChanged<BillItem> onNote;
  final ValueChanged<int> onGuests;
  final VoidCallback onDiscount;
  final ValueChanged<bool> onServiceToggle;
  final VoidCallback? onPay;
  final VoidCallback onPrint;

  @override
  Widget build(BuildContext context) {
    final open = bill.isOpen;
    final t = bill.totals;
    String money(num v) => business.money(v);

    return Material(
      color: context.colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bill.title, style: context.text.titleMedium),
                      Text(
                        [
                          if (bill.customerName.isNotEmpty) bill.customerName,
                          if (bill.createdAt != null) 'Opened ${Formatters.time(bill.createdAt!)}',
                          if (bill.openedByName.isNotEmpty) bill.openedByName,
                        ].join(' · '),
                        style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                      ),
                    ],
                  ),
                ),
                if (syncing)
                  Tooltip(
                    message: 'Saving…',
                    child: Icon(Icons.cloud_upload_outlined, size: 18, color: context.palette.textMuted),
                  ),
                if (!open)
                  StatusBadge(
                    label: bill.status.label,
                    color: bill.status == BillStatus.paid ? context.palette.success : context.palette.danger,
                  ),
              ],
            ),
          ),
          if (open)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Icon(Icons.people_alt_rounded, size: 18, color: context.palette.textMuted),
                  const SizedBox(width: AppSpacing.sm),
                  const Expanded(child: Text('Guests')),
                  QuantityStepper(value: bill.guests, max: 200, compact: true, onChanged: onGuests),
                ],
              ),
            ),
          const Divider(height: AppSpacing.xl),
          Expanded(
            child: bill.items.isEmpty
                ? const EmptyState(
                    icon: Icons.shopping_basket_outlined,
                    title: 'No items yet',
                    message: 'Tap menu items to add them to this bill.',
                    compact: true,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    itemCount: bill.items.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final item = bill.items[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: open ? () => onNote(item) : null,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name, style: context.text.titleSmall),
                                    Text(
                                      open
                                          ? '${money(item.unitPrice)} each'
                                          : '${item.quantity} × ${money(item.unitPrice)}',
                                      style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                                    ),
                                    if (item.note.isNotEmpty)
                                      Text(
                                        '“${item.note}”',
                                        style: context.text.bodySmall?.copyWith(
                                          color: context.palette.warning,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            if (open)
                              QuantityStepper(
                                value: item.quantity,
                                min: 0,
                                compact: true,
                                onChanged: (q) => onQuantity(item, q),
                              ),
                            SizedBox(
                              width: 92,
                              child: Text(
                                money(item.total),
                                textAlign: TextAlign.end,
                                style: context.text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 150.ms);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: context.colors.surfaceContainerLow,
              border: Border(top: BorderSide(color: context.palette.border)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  KeyValueRow(label: 'Subtotal', value: money(t.subtotal)),
                  InkWell(
                    onTap: open ? onDiscount : null,
                    child: KeyValueRow(
                      label: bill.discountType == DiscountType.percent
                          ? 'Discount (${bill.discountValue.toStringAsFixed(bill.discountValue % 1 == 0 ? 0 : 1)}%)'
                          : 'Discount',
                      value: t.discount > 0 ? '-${money(t.discount)}' : (open ? 'Add' : money(0)),
                      valueColor: t.discount > 0 ? context.palette.success : context.colors.primary,
                    ),
                  ),
                  if (business.serviceChargeRate > 0 || bill.serviceChargeRate > 0)
                    Row(
                      children: [
                        Expanded(
                          child: KeyValueRow(
                            label: 'Service charge (${bill.serviceChargeRate.toStringAsFixed(0)}%)',
                            value: money(t.serviceCharge),
                          ),
                        ),
                        if (open)
                          Switch.adaptive(
                            value: bill.serviceChargeRate > 0,
                            onChanged: onServiceToggle,
                          ),
                      ],
                    ),
                  if (bill.taxRate > 0)
                    KeyValueRow(
                      label: 'VAT (${bill.taxRate.toStringAsFixed(bill.taxRate % 1 == 0 ? 0 : 1)}%)',
                      value: money(t.tax),
                    ),
                  const Divider(height: AppSpacing.lg),
                  KeyValueRow(label: 'Total', value: money(t.total), emphasize: true),
                  if (!open && bill.payments.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    for (final p in bill.payments)
                      KeyValueRow(label: 'Paid · ${p.method.label}', value: money(p.amount)),
                  ],
                  if (bill.status == BillStatus.voided && bill.voidReason.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: Text(
                        'Void reason: ${bill.voidReason}',
                        style: context.text.bodySmall?.copyWith(color: context.palette.danger),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.md),
                  if (open)
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: onDiscount,
                          icon: const Icon(Icons.percent_rounded, size: 18),
                          label: const Text('Discount'),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: bill.items.isEmpty ? null : onPay,
                            icon: const Icon(Icons.payments_rounded),
                            label: Text(onPay == null ? 'No permission to settle' : 'Pay ${money(t.total)}'),
                          ),
                        ),
                      ],
                    )
                  else
                    FilledButton.tonalIcon(
                      onPressed: onPrint,
                      icon: const Icon(Icons.print_rounded),
                      label: const Text('Print receipt'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
