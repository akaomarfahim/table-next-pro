import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/firebase_providers.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/business.dart';
import '../../domain/repositories/business_repository.dart';
import '../datasources/business_remote_data_source.dart';
import '../models/business_model.dart';

part 'business_repository_impl.g.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  BusinessRepositoryImpl(this._remote, this._storage);

  final BusinessRemoteDataSource _remote;
  final LocalStorageService _storage;

  @override
  Future<Business> getBusiness(String businessId) async {
    try {
      final model = await _remote.fetch(businessId);
      await _storage.putCachedMap(StorageKeys.cachedBusiness, model.toCacheJson());
      return model.toEntity();
    } on NotFoundException {
      rethrow;
    } on AppException {
      final cached = getCachedBusiness();
      if (cached != null && cached.id == businessId) return cached;
      rethrow;
    }
  }

  @override
  Business? getCachedBusiness() {
    final map = _storage.getCachedMap(StorageKeys.cachedBusiness);
    if (map == null) return null;
    try {
      return BusinessModel.fromJson(map).toEntity();
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<Business> watchBusiness(String businessId) {
    return _remote.watch(businessId).map((model) {
      _storage.putCachedMap(StorageKeys.cachedBusiness, model.toCacheJson());
      return model.toEntity();
    });
  }

  @override
  Future<String> createBusiness(Business business) async {
    final id = business.id.isEmpty ? _remote.newId() : business.id;
    await _remote.create(id, BusinessModel.fromEntity(business.copyWith(id: id)));
    return id;
  }

  @override
  Future<void> updateBusiness(Business business) async {
    final model = BusinessModel.fromEntity(business);
    await _remote.update(model);
    await _storage.putCachedMap(StorageKeys.cachedBusiness, model.toCacheJson());
  }

  @override
  Future<void> clearCache() => _storage.removeCached(StorageKeys.cachedBusiness);
}

@Riverpod(keepAlive: true)
BusinessRepository businessRepository(Ref ref) {
  return BusinessRepositoryImpl(
    BusinessRemoteDataSource(ref.watch(firestoreProvider)),
    ref.watch(localStorageServiceProvider),
  );
}
