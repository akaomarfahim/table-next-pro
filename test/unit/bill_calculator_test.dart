import 'package:flutter_test/flutter_test.dart';
import 'package:table_next_pro/features/billing/domain/entities/bill.dart';
import 'package:table_next_pro/features/billing/domain/services/bill_calculator.dart';
import 'package:table_next_pro/features/billing/domain/services/bill_editing.dart';

void main() {
  const items = [
    BillItem(lineId: 'a', menuItemId: 'm1', name: 'Kacchi', unitPrice: 450, quantity: 2),
    BillItem(lineId: 'b', menuItemId: 'm2', name: 'Borhani', unitPrice: 100, quantity: 1),
  ];

  group('BillCalculator', () {
    test('computes subtotal, service charge and VAT in the right order', () {
      final t = BillCalculator.compute(
        items: items,
        discountType: DiscountType.none,
        discountValue: 0,
        serviceChargeRate: 10,
        taxRate: 5,
      );
      expect(t.subtotal, 1000);
      expect(t.serviceCharge, 100);
      expect(t.tax, 55); // 5% of (1000 + 100)
      expect(t.total, 1155);
    });

    test('percent discount is applied before service and tax', () {
      final t = BillCalculator.compute(
        items: items,
        discountType: DiscountType.percent,
        discountValue: 10,
        serviceChargeRate: 0,
        taxRate: 5,
      );
      expect(t.discount, 100);
      expect(t.tax, 45);
      expect(t.total, 945);
    });

    test('amount discount is capped at the subtotal', () {
      final t = BillCalculator.compute(
        items: items,
        discountType: DiscountType.amount,
        discountValue: 5000,
        serviceChargeRate: 10,
        taxRate: 5,
      );
      expect(t.discount, 1000);
      expect(t.total, 0);
    });
  });

  group('BillEditing', () {
    const bill = Bill(id: 'x', taxRate: 5);

    test('adding the same product twice increases quantity', () {
      var b = BillEditing.addItem(bill, menuItemId: 'm1', name: 'Tea', unitPrice: 20);
      b = BillEditing.addItem(b, menuItemId: 'm1', name: 'Tea', unitPrice: 20);
      expect(b.items, hasLength(1));
      expect(b.items.single.quantity, 2);
      expect(b.totals.subtotal, 40);
      expect(b.totals.total, 42);
    });

    test('setting quantity to zero removes the line', () {
      var b = BillEditing.addItem(bill, menuItemId: 'm1', name: 'Tea', unitPrice: 20);
      b = BillEditing.setQuantity(b, b.items.single.lineId, 0);
      expect(b.items, isEmpty);
      expect(b.totals.total, 0);
    });
  });
}
