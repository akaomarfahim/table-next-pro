import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/json_converters.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../domain/entities/customer.dart';

part 'customer_model.freezed.dart';
part 'customer_model.g.dart';

@freezed
abstract class CustomerModel with _$CustomerModel {
  const CustomerModel._();

  const factory CustomerModel({
    @JsonKey(includeToJson: false) @Default('') String id,
    required String name,
    required String phone,
    /// Digits-only phone, used for uniqueness and prefix search.
    @Default('') String phoneNormalized,
    /// Lower-cased name, used for prefix search.
    @Default('') String nameLower,
    @Default('') String email,
    @Default('') String notes,
    @Default(<String>[]) List<String> tags,
    @Default(false) bool isVip,
    @NullableTimestampConverter() DateTime? birthday,
    @Default(0) int visitCount,
    @Default(0) int reservationCount,
    @Default(0) int noShowCount,
    @Default(0.0) double totalSpent,
    @NullableTimestampConverter() DateTime? lastVisitAt,
    @NullableTimestampConverter() DateTime? createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _CustomerModel;

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  factory CustomerModel.fromEntity(Customer e) => CustomerModel(
        id: e.id,
        name: e.name.trim(),
        phone: e.phone.trim(),
        phoneNormalized: PhoneUtils.normalize(e.phone),
        nameLower: e.name.trim().toLowerCase(),
        email: e.email.trim(),
        notes: e.notes,
        tags: e.tags,
        isVip: e.isVip,
        birthday: e.birthday,
        visitCount: e.visitCount,
        reservationCount: e.reservationCount,
        noShowCount: e.noShowCount,
        totalSpent: e.totalSpent,
        lastVisitAt: e.lastVisitAt,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  Customer toEntity() => Customer(
        id: id,
        name: name,
        phone: phone,
        email: email,
        notes: notes,
        tags: tags,
        isVip: isVip,
        birthday: birthday,
        visitCount: visitCount,
        reservationCount: reservationCount,
        noShowCount: noShowCount,
        totalSpent: totalSpent,
        lastVisitAt: lastVisitAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Profile fields only — counters are maintained with atomic increments
  /// by reservations / billing and must not be overwritten by edits.
  Map<String, dynamic> toProfileJson() {
    final json = toJson();
    for (final key in const [
      'visitCount',
      'reservationCount',
      'noShowCount',
      'totalSpent',
      'lastVisitAt',
    ]) {
      json.remove(key);
    }
    return json;
  }
}
