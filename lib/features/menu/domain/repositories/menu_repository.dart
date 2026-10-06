import '../entities/menu_entities.dart';

abstract interface class MenuRepository {
  Stream<List<MenuCategory>> watchCategories();
  Stream<List<MenuProduct>> watchItems();

  Future<void> saveCategory(MenuCategory category);
  Future<void> deleteCategory(String id);

  Future<void> saveItem(MenuProduct item);
  Future<void> deleteItem(String id);
  Future<void> setAvailability(String itemId, {required bool available});
}
