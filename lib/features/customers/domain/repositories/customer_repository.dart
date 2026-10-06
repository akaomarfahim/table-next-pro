import '../../../../core/domain/page_result.dart';
import '../entities/customer.dart';

/// Customer directory.
///
/// Designed for large directories (17k+ records) on the free Spark plan:
/// the list is paged by `updatedAt` and search uses indexed prefix queries,
/// so a screen never reads more than one page of documents.
abstract interface class CustomerRepository {
  Future<PageResult<Customer>> fetchPage({required int limit, Object? cursor});

  /// Prefix search by phone (when the query is numeric) or by name.
  Future<List<Customer>> search(String query, {int limit});

  Future<Customer?> getById(String id);

  Stream<Customer?> watchById(String id);

  Future<Customer?> findByPhone(String phone);

  /// Creates a customer. Throws `ConflictException` if the phone exists.
  Future<Customer> create(Customer customer);

  Future<void> update(Customer customer);

  Future<void> delete(String id);

  /// Returns the existing customer for [phone] or creates a new one.
  Future<Customer> upsertByPhone({
    required String name,
    required String phone,
    String email,
  });
}
