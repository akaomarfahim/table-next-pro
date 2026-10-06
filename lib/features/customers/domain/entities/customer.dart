import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';

/// A guest of the restaurant. `phone` is the unique business key.
@freezed
abstract class Customer with _$Customer {
  const Customer._();

  const factory Customer({
    required String id,
    required String name,
    required String phone,
    @Default('') String email,
    @Default('') String notes,
    @Default(<String>[]) List<String> tags,
    @Default(false) bool isVip,
    DateTime? birthday,
    @Default(0) int visitCount,
    @Default(0) int reservationCount,
    @Default(0) int noShowCount,
    @Default(0.0) double totalSpent,
    DateTime? lastVisitAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Customer;

  double get averageSpend => visitCount == 0 ? 0 : totalSpent / visitCount;

  /// Simple reliability indicator shown to hosts.
  bool get frequentNoShow =>
      reservationCount >= 3 && noShowCount / reservationCount >= 0.3;
}
