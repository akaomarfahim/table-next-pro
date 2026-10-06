import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/app_config.dart';
import '../errors/app_exception.dart';

/// Helpers that make Firestore calls safe and offline-friendly.
///
/// Firestore applies writes to its local cache instantly, but the returned
/// future only completes once the server acknowledges the write. On a flaky
/// restaurant network that could freeze the UI, so writes are awaited with a
/// timeout and treated as "queued for sync" when the timeout elapses.
abstract final class FirestoreGuard {
  static Future<void> write(Future<void> Function() operation) async {
    try {
      await operation().timeout(
        AppConfig.writeAckTimeout,
        onTimeout: () {
          // Write is committed locally and will be synced automatically.
        },
      );
    } on Object catch (e, st) {
      throw mapToAppException(e, st);
    }
  }

  static Future<T> read<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on Object catch (e, st) {
      throw mapToAppException(e, st);
    }
  }

  /// Maps errors of a realtime stream to [AppException]s.
  static Stream<T> stream<T>(Stream<T> source) {
    return source.handleError((Object e, StackTrace st) {
      throw mapToAppException(e, st);
    });
  }

  /// Merges the document id into the data map so models can be decoded.
  static Map<String, dynamic> withId(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};
    return <String, dynamic>{...data, 'id': doc.id};
  }

  /// Prepares a map for a create operation.
  static Map<String, dynamic> forCreate(Map<String, dynamic> json) {
    return <String, dynamic>{
      ...json,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }..remove('id');
  }

  /// Prepares a map for an update operation (keeps the original createdAt).
  static Map<String, dynamic> forUpdate(Map<String, dynamic> json) {
    return <String, dynamic>{
      ...json,
      'updatedAt': FieldValue.serverTimestamp(),
    }
      ..remove('id')
      ..remove('createdAt');
  }
}
