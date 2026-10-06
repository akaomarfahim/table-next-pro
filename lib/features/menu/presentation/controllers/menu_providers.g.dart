// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(menuCategories)
const menuCategoriesProvider = MenuCategoriesProvider._();

final class MenuCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MenuCategory>>,
          List<MenuCategory>,
          Stream<List<MenuCategory>>
        >
    with
        $FutureModifier<List<MenuCategory>>,
        $StreamProvider<List<MenuCategory>> {
  const MenuCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuCategoriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuCategoriesHash();

  @$internal
  @override
  $StreamProviderElement<List<MenuCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MenuCategory>> create(Ref ref) {
    return menuCategories(ref);
  }
}

String _$menuCategoriesHash() => r'8fe10ed6c3c7e91c49aa5dca5eb4b2ddd887dd7a';

@ProviderFor(menuItems)
const menuItemsProvider = MenuItemsProvider._();

final class MenuItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MenuProduct>>,
          List<MenuProduct>,
          Stream<List<MenuProduct>>
        >
    with
        $FutureModifier<List<MenuProduct>>,
        $StreamProvider<List<MenuProduct>> {
  const MenuItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuItemsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuItemsHash();

  @$internal
  @override
  $StreamProviderElement<List<MenuProduct>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MenuProduct>> create(Ref ref) {
    return menuItems(ref);
  }
}

String _$menuItemsHash() => r'36d4a630ce2922f22573282d723ff98a1e9b074d';
