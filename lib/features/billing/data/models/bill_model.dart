import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/json_converters.dart';
import '../../domain/entities/bill.dart';

part 'bill_model.freezed.dart';
part 'bill_model.g.dart';

@freezed
abstract class BillItemModel with _$BillItemModel {
  const BillItemModel._();

  const factory BillItemModel({
    required String lineId,
    required String menuItemId,
    required String name,
    required double unitPrice,
    @Default(1) int quantity,
    @Default('') String note,
    @Default(false) bool sent,
  }) = _BillItemModel;

  factory BillItemModel.fromJson(Map<String, dynamic> json) =>
      _$BillItemModelFromJson(json);

  factory BillItemModel.fromEntity(BillItem e) => BillItemModel(
        lineId: e.lineId,
        menuItemId: e.menuItemId,
        name: e.name,
        unitPrice: e.unitPrice,
        quantity: e.quantity,
        note: e.note,
        sent: e.sent,
      );

  BillItem toEntity() => BillItem(
        lineId: lineId,
        menuItemId: menuItemId,
        name: name,
        unitPrice: unitPrice,
        quantity: quantity,
        note: note,
        sent: sent,
      );
}

@freezed
abstract class PaymentModel with _$PaymentModel {
  const PaymentModel._();

  const factory PaymentModel({
    @JsonKey(unknownEnumValue: PaymentMethod.other) required PaymentMethod method,
    required double amount,
    @Default('') String reference,
    @TimestampConverter() required DateTime receivedAt,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  factory PaymentModel.fromEntity(Payment e) => PaymentModel(
        method: e.method,
        amount: e.amount,
        reference: e.reference,
        receivedAt: e.receivedAt,
      );

  Payment toEntity() => Payment(
        method: method,
        amount: amount,
        reference: reference,
        receivedAt: receivedAt,
      );
}

@freezed
abstract class BillModel with _$BillModel {
  const BillModel._();

  const factory BillModel({
    @JsonKey(includeToJson: false) @Default('') String id,
    @Default('') String billNumber,
    @JsonKey(unknownEnumValue: BillStatus.open) @Default(BillStatus.open) BillStatus status,
    @JsonKey(unknownEnumValue: OrderType.dineIn) @Default(OrderType.dineIn) OrderType orderType,
    @Default(<String>[]) List<String> tableIds,
    @Default(<String>[]) List<String> tableLabels,
    String? reservationId,
    String? customerId,
    @Default('') String customerName,
    @Default('') String customerPhone,
    @Default(1) int guests,
    @Default(<BillItemModel>[]) List<BillItemModel> items,
    @JsonKey(unknownEnumValue: DiscountType.none) @Default(DiscountType.none) DiscountType discountType,
    @Default(0.0) double discountValue,
    @Default(0.0) double taxRate,
    @Default(0.0) double serviceChargeRate,
    @Default(0.0) double subtotal,
    @Default(0.0) double discountAmount,
    @Default(0.0) double serviceCharge,
    @Default(0.0) double tax,
    @Default(0.0) double total,
    @Default(<PaymentModel>[]) List<PaymentModel> payments,
    @Default('') String notes,
    @Default('') String openedById,
    @Default('') String openedByName,
    String? closedById,
    String? closedByName,
    @Default('') String voidReason,
    @NullableTimestampConverter() DateTime? closedAt,
    @NullableTimestampConverter() DateTime? createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _BillModel;

  factory BillModel.fromJson(Map<String, dynamic> json) => _$BillModelFromJson(json);

  factory BillModel.fromEntity(Bill e) => BillModel(
        id: e.id,
        billNumber: e.billNumber,
        status: e.status,
        orderType: e.orderType,
        tableIds: e.tableIds,
        tableLabels: e.tableLabels,
        reservationId: e.reservationId,
        customerId: e.customerId,
        customerName: e.customerName,
        customerPhone: e.customerPhone,
        guests: e.guests,
        items: e.items.map(BillItemModel.fromEntity).toList(),
        discountType: e.discountType,
        discountValue: e.discountValue,
        taxRate: e.taxRate,
        serviceChargeRate: e.serviceChargeRate,
        subtotal: e.totals.subtotal,
        discountAmount: e.totals.discount,
        serviceCharge: e.totals.serviceCharge,
        tax: e.totals.tax,
        total: e.totals.total,
        payments: e.payments.map(PaymentModel.fromEntity).toList(),
        notes: e.notes,
        openedById: e.openedById,
        openedByName: e.openedByName,
        closedById: e.closedById,
        closedByName: e.closedByName,
        voidReason: e.voidReason,
        closedAt: e.closedAt,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  Bill toEntity() => Bill(
        id: id,
        billNumber: billNumber,
        status: status,
        orderType: orderType,
        tableIds: tableIds,
        tableLabels: tableLabels,
        reservationId: reservationId,
        customerId: customerId,
        customerName: customerName,
        customerPhone: customerPhone,
        guests: guests,
        items: items.map((i) => i.toEntity()).toList(),
        discountType: discountType,
        discountValue: discountValue,
        taxRate: taxRate,
        serviceChargeRate: serviceChargeRate,
        totals: BillTotals(
          subtotal: subtotal,
          discount: discountAmount,
          serviceCharge: serviceCharge,
          tax: tax,
          total: total,
        ),
        payments: payments.map((p) => p.toEntity()).toList(),
        notes: notes,
        openedById: openedById,
        openedByName: openedByName,
        closedById: closedById,
        closedByName: closedByName,
        voidReason: voidReason,
        closedAt: closedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
