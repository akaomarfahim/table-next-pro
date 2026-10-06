/// Route paths used across the app.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String activate = '/activate';
  static const String setup = '/setup';
  static const String lock = '/lock';

  static const String dashboard = '/';
  static const String floor = '/floor';
  static const String floorEditor = '/floor-editor';
  static const String reservations = '/reservations';
  static const String newReservation = '/reservations/new';
  static const String customers = '/customers';
  static const String billing = '/billing';
  static const String menu = '/menu';
  static const String settings = '/settings';
  static const String businessProfile = '/settings/business';
  static const String staff = '/settings/staff';
  static const String logs = '/settings/logs';

  static String reservation(String id) => '$reservations/$id';
  static String customer(String id) => '$customers/$id';
  static String bill(String id) => '$billing/$id';

  static String newReservationWith({String? tableId, DateTime? date, String? customerId}) {
    final params = <String, String>{
      'table': ?tableId,
      if (date != null) 'date': date.toIso8601String(),
      'customer': ?customerId,
    };
    return Uri(path: newReservation, queryParameters: params.isEmpty ? null : params)
        .toString();
  }

  static const Set<String> publicRoutes = {activate, setup};
}
