import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Application-wide [Talker] instance (logs, errors, Riverpod events).
///
/// Overridden in `bootstrap.dart` so the same instance is used by the
/// Flutter error handlers and the Riverpod observer.
final talkerProvider = Provider<Talker>((ref) => TalkerFlutter.init());
