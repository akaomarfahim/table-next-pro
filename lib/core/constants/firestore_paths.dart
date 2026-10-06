/// Centralised Firestore collection / document paths.
///
/// Data layout (multi-tenant by `businessId`):
///
/// ```
/// users/{userId}                               ← global, holds businessId
/// businesses/{businessId}
///   ├── customers/{customerId}
///   ├── reservations/{reservationId}
///   ├── floors/{floorId}
///   ├── floor_elements/{elementId}
///   ├── menu_categories/{categoryId}
///   ├── menu_items/{itemId}
///   ├── bills/{billId}
///   ├── daily_stats/{yyyy-MM-dd}
///   └── counters/{counterId}
/// ```
abstract final class FirestorePaths {
  static const String users = 'users';
  static const String businesses = 'businesses';

  static String business(String businessId) => '$businesses/$businessId';

  static String customers(String businessId) =>
      '${business(businessId)}/customers';
  static String reservations(String businessId) =>
      '${business(businessId)}/reservations';
  static String floors(String businessId) => '${business(businessId)}/floors';
  static String floorElements(String businessId) =>
      '${business(businessId)}/floor_elements';
  static String menuCategories(String businessId) =>
      '${business(businessId)}/menu_categories';
  static String menuItems(String businessId) =>
      '${business(businessId)}/menu_items';
  static String bills(String businessId) => '${business(businessId)}/bills';
  static String dailyStats(String businessId) =>
      '${business(businessId)}/daily_stats';
  static String counters(String businessId) =>
      '${business(businessId)}/counters';

  static String billCounter(String businessId) => '${counters(businessId)}/bills';
}

/// Common field names reused across data sources.
abstract final class FirestoreFields {
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String businessId = 'businessId';
  static const String sortOrder = 'sortOrder';
}
