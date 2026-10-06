import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/domain/page_result.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/firebase_providers.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_maintenance_data_source.dart';
import '../datasources/customer_remote_data_source.dart';
import '../models/customer_model.dart';

part 'customer_repository_impl.g.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  CustomerRepositoryImpl(this._remote);

  final CustomerRemoteDataSource _remote;

  @override
  Future<PageResult<Customer>> fetchPage({required int limit, Object? cursor}) async {
    final page = await _remote.fetchPage(limit: limit, cursor: cursor);
    return PageResult(
      items: page.items.map((m) => m.toEntity()).toList(),
      cursor: page.cursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<List<Customer>> search(
    String query, {
    int limit = AppConfig.searchResultLimit,
  }) async {
    final q = query.trim();
    if (q.isEmpty) return const [];
    final List<CustomerModel> results;
    if (PhoneUtils.looksLikePhone(q)) {
      final digits = PhoneUtils.normalize(q);
      if (digits.isEmpty) return const [];
      results = await _remote.prefixSearch(
        field: 'phoneNormalized',
        prefix: digits,
        limit: limit,
      );
    } else {
      results = await _remote.prefixSearch(
        field: 'nameLower',
        prefix: q.toLowerCase(),
        limit: limit,
      );
    }
    return results.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Customer?> getById(String id) async => (await _remote.fetchById(id))?.toEntity();

  @override
  Stream<Customer?> watchById(String id) =>
      _remote.watchById(id).map((m) => m?.toEntity());

  @override
  Future<Customer?> findByPhone(String phone) async {
    final normalized = PhoneUtils.normalize(phone);
    if (normalized.isEmpty) return null;
    return (await _remote.findByPhone(normalized))?.toEntity();
  }

  void _validate(Customer c) {
    if (c.name.trim().isEmpty) throw const ValidationException('Customer name is required.');
    if (!PhoneUtils.isValid(c.phone)) {
      throw const ValidationException('Enter a valid phone number.');
    }
  }

  @override
  Future<Customer> create(Customer customer) async {
    _validate(customer);
    final existing = await findByPhone(customer.phone);
    if (existing != null) {
      throw ConflictException(
        'A customer with this phone already exists (${existing.name}).',
      );
    }
    final id = customer.id.isEmpty ? _remote.newId() : customer.id;
    final now = DateTime.now();
    final entity = customer.copyWith(id: id, createdAt: now, updatedAt: now);
    await _remote.create(CustomerModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<void> update(Customer customer) async {
    _validate(customer);
    final existing = await findByPhone(customer.phone);
    if (existing != null && existing.id != customer.id) {
      throw ConflictException('Phone already belongs to ${existing.name}.');
    }
    await _remote.update(CustomerModel.fromEntity(customer));
  }

  @override
  Future<void> delete(String id) => _remote.delete(id);

  @override
  Future<Customer> upsertByPhone({
    required String name,
    required String phone,
    String email = '',
  }) async {
    final existing = await findByPhone(phone);
    if (existing != null) {
      // Fill in missing details without overwriting what staff entered.
      final needsUpdate = (existing.email.isEmpty && email.trim().isNotEmpty) ||
          (existing.name.trim().isEmpty && name.trim().isNotEmpty);
      if (needsUpdate) {
        final updated = existing.copyWith(
          email: existing.email.isEmpty ? email.trim() : existing.email,
          name: existing.name.trim().isEmpty ? name.trim() : existing.name,
        );
        await update(updated);
        return updated;
      }
      return existing;
    }
    return create(Customer(id: '', name: name, phone: phone, email: email));
  }
}

@Riverpod(keepAlive: true)
CustomerRepository customerRepository(Ref ref) => CustomerRepositoryImpl(
      CustomerRemoteDataSource(
        ref.watch(firestoreProvider),
        ref.watch(requireBusinessIdProvider),
      ),
    );

@riverpod
CustomerMaintenanceDataSource customerMaintenance(Ref ref) =>
    CustomerMaintenanceDataSource(
      ref.watch(firestoreProvider),
      ref.watch(requireBusinessIdProvider),
    );
