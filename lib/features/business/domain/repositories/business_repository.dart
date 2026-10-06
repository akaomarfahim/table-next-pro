import '../entities/business.dart';

abstract interface class BusinessRepository {
  /// Fetches a business from the server, falling back to the local cache.
  Future<Business> getBusiness(String businessId);

  /// Last cached copy of the business (for instant/offline start-up).
  Business? getCachedBusiness();

  Stream<Business> watchBusiness(String businessId);

  /// Creates a business and returns its id.
  Future<String> createBusiness(Business business);

  Future<void> updateBusiness(Business business);

  Future<void> clearCache();
}
