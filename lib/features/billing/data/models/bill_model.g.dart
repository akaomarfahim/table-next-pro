// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BillItemModel _$BillItemModelFromJson(Map json) => _BillItemModel(
  lineId: json['lineId'] as String,
  menuItemId: json['menuItemId'] as String,
  name: json['name'] as String,
  unitPrice: (json['unitPrice'] as num).toDouble(),
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  note: json['note'] as String? ?? '',
  sent: json['sent'] as bool? ?? false,
);

Map<String, dynamic> _$BillItemModelToJson(_BillItemModel instance) =>
    <String, dynamic>{
      'lineId': instance.lineId,
      'menuItemId': instance.menuItemId,
      'name': instance.name,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'note': instance.note,
      'sent': instance.sent,
    };

_PaymentModel _$PaymentModelFromJson(Map json) => _PaymentModel(
  method: $enumDecode(
    _$PaymentMethodEnumMap,
    json['method'],
    unknownValue: PaymentMethod.other,
  ),
  amount: (json['amount'] as num).toDouble(),
  reference: json['reference'] as String? ?? '',
  receivedAt: const TimestampConverter().fromJson(json['receivedAt']),
);

Map<String, dynamic> _$PaymentModelToJson(_PaymentModel instance) =>
    <String, dynamic>{
      'method': _$PaymentMethodEnumMap[instance.method]!,
      'amount': instance.amount,
      'reference': instance.reference,
      'receivedAt': const TimestampConverter().toJson(instance.receivedAt),
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.card: 'card',
  PaymentMethod.mobile: 'mobile',
  PaymentMethod.other: 'other',
};

_BillModel _$BillModelFromJson(Map json) => _BillModel(
  id: json['id'] as String? ?? '',
  billNumber: json['billNumber'] as String? ?? '',
  status:
      $enumDecodeNullable(
        _$BillStatusEnumMap,
        json['status'],
        unknownValue: BillStatus.open,
      ) ??
      BillStatus.open,
  orderType:
      $enumDecodeNullable(
        _$OrderTypeEnumMap,
        json['orderType'],
        unknownValue: OrderType.dineIn,
      ) ??
      OrderType.dineIn,
  tableIds:
      (json['tableIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  tableLabels:
      (json['tableLabels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  reservationId: json['reservationId'] as String?,
  customerId: json['customerId'] as String?,
  customerName: json['customerName'] as String? ?? '',
  customerPhone: json['customerPhone'] as String? ?? '',
  guests: (json['guests'] as num?)?.toInt() ?? 1,
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => BillItemModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList() ??
      const <BillItemModel>[],
  discountType:
      $enumDecodeNullable(
        _$DiscountTypeEnumMap,
        json['discountType'],
        unknownValue: DiscountType.none,
      ) ??
      DiscountType.none,
  discountValue: (json['discountValue'] as num?)?.toDouble() ?? 0.0,
  taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0.0,
  serviceChargeRate: (json['serviceChargeRate'] as num?)?.toDouble() ?? 0.0,
  subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
  discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
  serviceCharge: (json['serviceCharge'] as num?)?.toDouble() ?? 0.0,
  tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
  total: (json['total'] as num?)?.toDouble() ?? 0.0,
  payments:
      (json['payments'] as List<dynamic>?)
          ?.map(
            (e) => PaymentModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList() ??
      const <PaymentModel>[],
  notes: json['notes'] as String? ?? '',
  openedById: json['openedById'] as String? ?? '',
  openedByName: json['openedByName'] as String? ?? '',
  closedById: json['closedById'] as String?,
  closedByName: json['closedByName'] as String?,
  voidReason: json['voidReason'] as String? ?? '',
  closedAt: const NullableTimestampConverter().fromJson(json['closedAt']),
  createdAt: const NullableTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$BillModelToJson(
  _BillModel instance,
) => <String, dynamic>{
  'billNumber': instance.billNumber,
  'status': _$BillStatusEnumMap[instance.status]!,
  'orderType': _$OrderTypeEnumMap[instance.orderType]!,
  'tableIds': instance.tableIds,
  'tableLabels': instance.tableLabels,
  'reservationId': instance.reservationId,
  'customerId': instance.customerId,
  'customerName': instance.customerName,
  'customerPhone': instance.customerPhone,
  'guests': instance.guests,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'discountType': _$DiscountTypeEnumMap[instance.discountType]!,
  'discountValue': instance.discountValue,
  'taxRate': instance.taxRate,
  'serviceChargeRate': instance.serviceChargeRate,
  'subtotal': instance.subtotal,
  'discountAmount': instance.discountAmount,
  'serviceCharge': instance.serviceCharge,
  'tax': instance.tax,
  'total': instance.total,
  'payments': instance.payments.map((e) => e.toJson()).toList(),
  'notes': instance.notes,
  'openedById': instance.openedById,
  'openedByName': instance.openedByName,
  'closedById': instance.closedById,
  'closedByName': instance.closedByName,
  'voidReason': instance.voidReason,
  'closedAt': const NullableTimestampConverter().toJson(instance.closedAt),
  'createdAt': const NullableTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};

const _$BillStatusEnumMap = {
  BillStatus.open: 'open',
  BillStatus.paid: 'paid',
  BillStatus.voided: 'voided',
};

const _$OrderTypeEnumMap = {
  OrderType.dineIn: 'dineIn',
  OrderType.takeaway: 'takeaway',
  OrderType.delivery: 'delivery',
};

const _$DiscountTypeEnumMap = {
  DiscountType.none: 'none',
  DiscountType.percent: 'percent',
  DiscountType.amount: 'amount',
};
