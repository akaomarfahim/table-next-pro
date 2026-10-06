import 'package:freezed_annotation/freezed_annotation.dart';

part 'business.freezed.dart';

/// A restaurant (tenant). Every piece of operational data lives under
/// `businesses/{id}` in Firestore.
@freezed
abstract class Business with _$Business {
  const Business._();

  const factory Business({
    required String id,
    required String name,
    @Default('') String phone,
    @Default('') String email,
    @Default('') String address,
    @Default('BDT') String currencyCode,
    @Default('৳') String currencySymbol,
    /// VAT / tax percentage applied to bills (e.g. 5 = 5%).
    @Default(0.0) double taxRate,
    /// Service charge percentage applied to bills.
    @Default(0.0) double serviceChargeRate,
    /// Default reservation length in minutes.
    @Default(90) int defaultReservationMinutes,
    /// Opening / closing hour (0-24) used to build time slots.
    @Default(10) int openingHour,
    @Default(23) int closingHour,
    @Default('Thank you for dining with us!') String billFooter,
    @Default(true) bool active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Business;

  String money(num value) {
    final fixed = value.toStringAsFixed(2);
    final parts = fixed.split('.');
    final whole = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return '$currencySymbol$whole.${parts[1]}';
  }
}
