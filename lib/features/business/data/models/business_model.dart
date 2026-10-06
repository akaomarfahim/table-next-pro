import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/json_converters.dart';
import '../../domain/entities/business.dart';

part 'business_model.freezed.dart';
part 'business_model.g.dart';

@freezed
abstract class BusinessModel with _$BusinessModel {
  const BusinessModel._();

  const factory BusinessModel({
    @JsonKey(includeToJson: false) @Default('') String id,
    required String name,
    @Default('') String phone,
    @Default('') String email,
    @Default('') String address,
    @Default('BDT') String currencyCode,
    @Default('৳') String currencySymbol,
    @Default(0.0) double taxRate,
    @Default(0.0) double serviceChargeRate,
    @Default(90) int defaultReservationMinutes,
    @Default(10) int openingHour,
    @Default(23) int closingHour,
    @Default('Thank you for dining with us!') String billFooter,
    @Default(true) bool active,
    @NullableTimestampConverter() DateTime? createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _BusinessModel;

  factory BusinessModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessModelFromJson(json);

  factory BusinessModel.fromEntity(Business e) => BusinessModel(
        id: e.id,
        name: e.name,
        phone: e.phone,
        email: e.email,
        address: e.address,
        currencyCode: e.currencyCode,
        currencySymbol: e.currencySymbol,
        taxRate: e.taxRate,
        serviceChargeRate: e.serviceChargeRate,
        defaultReservationMinutes: e.defaultReservationMinutes,
        openingHour: e.openingHour,
        closingHour: e.closingHour,
        billFooter: e.billFooter,
        active: e.active,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );

  Business toEntity() => Business(
        id: id,
        name: name,
        phone: phone,
        email: email,
        address: address,
        currencyCode: currencyCode,
        currencySymbol: currencySymbol,
        taxRate: taxRate,
        serviceChargeRate: serviceChargeRate,
        defaultReservationMinutes: defaultReservationMinutes,
        openingHour: openingHour,
        closingHour: closingHour,
        billFooter: billFooter,
        active: active,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// JSON safe for Hive (no Firestore Timestamp objects).
  Map<String, dynamic> toCacheJson() => <String, dynamic>{
        ...toJson(),
        'id': id,
      }
        ..remove('createdAt')
        ..remove('updatedAt');
}
