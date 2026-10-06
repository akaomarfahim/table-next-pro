import '../../../../core/utils/id_generator.dart';
import '../entities/bill.dart';
import 'bill_calculator.dart';

/// Pure, immutable bill transformations. Every function returns a new
/// [Bill] with totals recalculated, so the UI can apply changes
/// optimistically before they are persisted.
abstract final class BillEditing {
  static Bill addItem(
    Bill bill, {
    required String menuItemId,
    required String name,
    required double unitPrice,
    int quantity = 1,
  }) {
    final items = [...bill.items];
    final index = items.indexWhere(
      (i) => i.menuItemId == menuItemId && i.note.isEmpty && !i.sent,
    );
    if (index >= 0) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + quantity);
    } else {
      items.add(
        BillItem(
          lineId: IdGenerator.short(),
          menuItemId: menuItemId,
          name: name,
          unitPrice: unitPrice,
          quantity: quantity,
        ),
      );
    }
    return BillCalculator.recalculate(bill.copyWith(items: items));
  }

  static Bill setQuantity(Bill bill, String lineId, int quantity) {
    final items = quantity <= 0
        ? bill.items.where((i) => i.lineId != lineId).toList()
        : [
            for (final i in bill.items)
              if (i.lineId == lineId) i.copyWith(quantity: quantity) else i,
          ];
    return BillCalculator.recalculate(bill.copyWith(items: items));
  }

  static Bill setNote(Bill bill, String lineId, String note) => bill.copyWith(
        items: [
          for (final i in bill.items)
            if (i.lineId == lineId) i.copyWith(note: note.trim()) else i,
        ],
      );

  static Bill setDiscount(Bill bill, DiscountType type, double value) =>
      BillCalculator.recalculate(
        bill.copyWith(
          discountType: type,
          discountValue: type == DiscountType.none ? 0 : value,
        ),
      );

  static Bill setServiceRate(Bill bill, double rate) =>
      BillCalculator.recalculate(bill.copyWith(serviceChargeRate: rate));

  static Bill setGuests(Bill bill, int guests) =>
      bill.copyWith(guests: guests < 1 ? 1 : guests);

  static Bill setCustomer(
    Bill bill, {
    String? id,
    String name = '',
    String phone = '',
  }) =>
      bill.copyWith(customerId: id, customerName: name, customerPhone: phone);

  static Bill markSent(Bill bill) => bill.copyWith(
        items: [for (final i in bill.items) i.copyWith(sent: true)],
      );
}
