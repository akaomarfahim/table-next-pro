import '../entities/bill.dart';

/// Pure bill maths.
///
/// Order of operations (common for restaurants in Bangladesh & the region):
/// 1. subtotal       = Σ line totals
/// 2. discount       = % of subtotal or fixed amount (capped at subtotal)
/// 3. service charge = rate × (subtotal − discount)
/// 4. tax / VAT      = rate × (subtotal − discount + service charge)
/// 5. total          = subtotal − discount + service + tax
abstract final class BillCalculator {
  static double _round(double v) => (v * 100).roundToDouble() / 100;

  static BillTotals compute({
    required List<BillItem> items,
    required DiscountType discountType,
    required double discountValue,
    required double serviceChargeRate,
    required double taxRate,
  }) {
    final subtotal = _round(items.fold(0.0, (sum, i) => sum + i.total));
    final rawDiscount = switch (discountType) {
      DiscountType.none => 0.0,
      DiscountType.percent => subtotal * (discountValue.clamp(0.0, 100.0) / 100),
      DiscountType.amount => discountValue,
    };
    final discount = _round(rawDiscount.clamp(0.0, subtotal));
    final net = subtotal - discount;
    final service = _round(net * serviceChargeRate / 100);
    final tax = _round((net + service) * taxRate / 100);
    final total = _round(net + service + tax);
    return BillTotals(
      subtotal: subtotal,
      discount: discount,
      serviceCharge: service,
      tax: tax,
      total: total,
    );
  }

  static Bill recalculate(Bill bill) => bill.copyWith(
        totals: compute(
          items: bill.items,
          discountType: bill.discountType,
          discountValue: bill.discountValue,
          serviceChargeRate: bill.serviceChargeRate,
          taxRate: bill.taxRate,
        ),
      );
}
