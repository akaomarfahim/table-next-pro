import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/data/firestore_guard.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/firebase_providers.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../domain/entities/menu_entities.dart';
import '../../domain/repositories/menu_repository.dart';
import '../models/menu_models.dart';

part 'menu_repository_impl.g.dart';

/// Menus are small (tens to a few hundred items), so the whole menu is
/// streamed once and cached offline by Firestore.
class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl(this._db, this._businessId);

  final FirebaseFirestore _db;
  final String _businessId;

  CollectionReference<Map<String, dynamic>> get _categories =>
      _db.collection(FirestorePaths.menuCategories(_businessId));
  CollectionReference<Map<String, dynamic>> get _items =>
      _db.collection(FirestorePaths.menuItems(_businessId));

  @override
  Stream<List<MenuCategory>> watchCategories() => FirestoreGuard.stream(
        _categories.orderBy(FirestoreFields.sortOrder).snapshots().map(
              (s) => s.docs
                  .map((d) => MenuCategoryModel.fromJson(FirestoreGuard.withId(d)).toEntity())
                  .toList(),
            ),
      );

  @override
  Stream<List<MenuProduct>> watchItems() => FirestoreGuard.stream(
        _items.orderBy(FirestoreFields.sortOrder).snapshots().map(
              (s) => s.docs
                  .map((d) => MenuProductModel.fromJson(FirestoreGuard.withId(d)).toEntity())
                  .toList(),
            ),
      );

  @override
  Future<void> saveCategory(MenuCategory category) {
    if (category.name.trim().isEmpty) {
      throw const ValidationException('Category name is required.');
    }
    final model = MenuCategoryModel.fromEntity(category);
    if (category.id.isEmpty) {
      return FirestoreGuard.write(
        () => _categories.doc().set(FirestoreGuard.forCreate(model.toJson())),
      );
    }
    return FirestoreGuard.write(
      () => _categories.doc(category.id).update(FirestoreGuard.forUpdate(model.toJson())),
    );
  }

  @override
  Future<void> deleteCategory(String id) => FirestoreGuard.write(() async {
        final items = await _items.where('categoryId', isEqualTo: id).limit(1).get();
        if (items.docs.isNotEmpty) {
          throw const ConflictException(
            'Move or delete the items in this category first.',
          );
        }
        await _categories.doc(id).delete();
      });

  @override
  Future<void> saveItem(MenuProduct item) {
    if (item.name.trim().isEmpty) throw const ValidationException('Item name is required.');
    if (item.price < 0) throw const ValidationException('Price cannot be negative.');
    final model = MenuProductModel.fromEntity(item);
    if (item.id.isEmpty) {
      return FirestoreGuard.write(
        () => _items.doc().set(FirestoreGuard.forCreate(model.toJson())),
      );
    }
    return FirestoreGuard.write(
      () => _items.doc(item.id).update(FirestoreGuard.forUpdate(model.toJson())),
    );
  }

  @override
  Future<void> deleteItem(String id) =>
      FirestoreGuard.write(() => _items.doc(id).delete());

  @override
  Future<void> setAvailability(String itemId, {required bool available}) =>
      FirestoreGuard.write(
        () => _items.doc(itemId).update({
          'available': available,
          FirestoreFields.updatedAt: FieldValue.serverTimestamp(),
        }),
      );
}

@Riverpod(keepAlive: true)
MenuRepository menuRepository(Ref ref) => MenuRepositoryImpl(
      ref.watch(firestoreProvider),
      ref.watch(requireBusinessIdProvider),
    );
