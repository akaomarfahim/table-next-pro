import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// Converts Firestore [Timestamp]s (and a few legacy formats) to [DateTime].
class TimestampConverter implements JsonConverter<DateTime, Object?> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object? json) =>
      _parse(json) ?? DateTime.fromMillisecondsSinceEpoch(0);

  @override
  Object? toJson(DateTime object) => Timestamp.fromDate(object);
}

/// Nullable variant of [TimestampConverter].
///
/// Server timestamps are `null` in local snapshots until the server confirms
/// the write, so audit fields (`createdAt`, `updatedAt`) use this converter.
class NullableTimestampConverter implements JsonConverter<DateTime?, Object?> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(Object? json) => _parse(json);

  @override
  Object? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

DateTime? _parse(Object? json) {
  return switch (json) {
    null => null,
    Timestamp() => json.toDate(),
    DateTime() => json,
    int() => DateTime.fromMillisecondsSinceEpoch(json),
    String() => DateTime.tryParse(json),
    _ => null,
  };
}
