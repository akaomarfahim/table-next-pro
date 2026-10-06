import 'package:uuid/uuid.dart';

/// Generates client-side identifiers (used for line items and new layout
/// elements before they are persisted).
abstract final class IdGenerator {
  static const Uuid _uuid = Uuid();

  static String uuid() => _uuid.v4();

  /// Short, url-safe id (12 chars) for embedded objects.
  static String short() => _uuid.v4().replaceAll('-', '').substring(0, 12);
}
