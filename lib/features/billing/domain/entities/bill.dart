import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill.freezed.dart';

enum BillStatus {
  open('Open'),
  paid('Paid'),
  voided('Void');

  const BillStatus(this.label);
  final String label;
}

enum OrderType {
  dineIn('Dine-in'),
  takeaway('Takeaway'),
  delivery('Delivery');

  const OrderType(this.label);
  final String label;
}

enum DiscountType { none, percent, amount }

enum PaymentMethod {
  cash('Cash'),
  card('Card'),
  mobile('Mobile banking'),
  other('Other');

  const PaymentMethod(this.label);
  final String label;
}

@freezed
abstract class BillItem with _$BillItem {
  const BillItem._();

  const factory BillItem({
    required String lineId,
    required String menuItemId,
    required String name,
    required double unitPrice,
    @Default(1) int quantity,
    @Default('') String note,
    /// Sent-to-kitchen marker (KOT) for future kitchen display integration.
    @Default(false) bool sent,
  }) = _BillItem;

  double get total => unitPrice * quantity;
}

@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    required PaymentMethod method,
    required double amount,
    @Default('') String reference,
    required DateTime receivedAt,
  }) = _Payment;
}

/// Totals computed by `BillCalculator`.
@freezed
abstract class BillTotals with _$BillTotals {
  const factory BillTotals({
    @Default(0.0) double subtotal,
    @Default(0.0) double discount,
    @Default(0.0) double serviceCharge,
    @Default(0.0) double tax,
    @Default(0.0) double total,
  }) = _BillTotals;
}

@freezed
abstract class Bill with _$Bill {
  const Bill._();

  const factory Bill({
    required String id,
    @Default('') String billNumber,
    @Default(BillStatus.open) BillStatus status,
    @Default(OrderType.dineIn) OrderType orderType,
    @Default(<String>[]) List<String> tableIds,
    @Default(<String>[]) List<String> tableLabels,
    String? reservationId,
    String? customerId,
    @Default('') String customerName,
    @Default('') String customerPhone,
    @Default(1) int guests,
    @Default(<BillItem>[]) List<BillItem> items,
    @Default(DiscountType.none) DiscountType discountType,
    @Default(0.0) double discountValue,
    @Default(0.0) double taxRate,
    @Default(0.0) double serviceChargeRate,
    @Default(BillTotals()) BillTotals totals,
    @Default(<Payment>[]) List<Payment> payments,
    @Default('') String notes,
    @Default('') String openedById,
    @Default('') String openedByName,
    String? closedById,
    String? closedByName,
    @Default('') String voidReason,
    DateTime? closedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Bill;

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);

  double get paidAmount => payments.fold(0.0, (sum, p) => sum + p.amount);

  double get balance => totals.total - paidAmount;

  bool get isOpen => status == BillStatus.open;

  String get title {
    if (orderType != OrderType.dineIn) {
      return customerName.isNotEmpty ? '${orderType.label} · $customerName' : orderType.label;
    }
    return tableLabels.isEmpty ? 'Dine-in' : 'Table ${tableLabels.join(', ')}';
  }
}
