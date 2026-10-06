import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/menu_repository_impl.dart';
import '../../domain/entities/menu_entities.dart';

part 'menu_providers.g.dart';

@Riverpod(keepAlive: true)
Stream<List<MenuCategory>> menuCategories(Ref ref) =>
    ref.watch(menuRepositoryProvider).watchCategories();

@Riverpod(keepAlive: true)
Stream<List<MenuProduct>> menuItems(Ref ref) =>
    ref.watch(menuRepositoryProvider).watchItems();
