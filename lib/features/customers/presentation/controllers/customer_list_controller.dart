import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/app_config.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../domain/entities/customer.dart';

part 'customer_list_controller.freezed.dart';
part 'customer_list_controller.g.dart';

@freezed
abstract class CustomerListState with _$CustomerListState {
  const factory CustomerListState({
    @Default(<Customer>[]) List<Customer> items,
    Object? cursor,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,
    @Default('') String query,
  }) = _CustomerListState;
}

/// Current search text of the customers screen (debounced by the UI).
@riverpod
class CustomerSearchQuery extends _$CustomerSearchQuery {
  @override
  String build() => '';

  void set(String value) => state = value.trim();
}

/// Paged customer list ordered by most recently updated, or search results
/// when a query is active. Only one page (25 docs) is read at a time.
@riverpod
class CustomerList extends _$CustomerList {
  @override
  Future<CustomerListState> build() async {
    final query = ref.watch(customerSearchQueryProvider);
    final repo = ref.watch(customerRepositoryProvider);

    if (query.isNotEmpty) {
      final results = await repo.search(query, limit: 30);
      return CustomerListState(items: results, query: query);
    }
    final page = await repo.fetchPage(limit: AppConfig.customersPageSize);
    return CustomerListState(
      items: page.items,
      cursor: page.cursor,
      hasMore: page.hasMore,
    );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final page = await ref
          .read(customerRepositoryProvider)
          .fetchPage(limit: AppConfig.customersPageSize, cursor: current.cursor);
      if (!ref.mounted) return;
      final seen = current.items.map((c) => c.id).toSet();
      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...page.items.where((c) => !seen.contains(c.id))],
          cursor: page.cursor,
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      if (ref.mounted) state = AsyncData(current.copyWith(isLoadingMore: false));
      rethrow;
    }
  }

  /// Reflects a created / edited customer without refetching the page.
  void upsertLocal(Customer customer) {
    final current = state.value;
    if (current == null) return;
    final others = current.items.where((c) => c.id != customer.id);
    state = AsyncData(current.copyWith(items: [customer, ...others]));
  }

  void removeLocal(String id) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(items: current.items.where((c) => c.id != id).toList()),
    );
  }
}

/// Realtime single customer.
@riverpod
Stream<Customer?> customerById(Ref ref, String id) =>
    ref.watch(customerRepositoryProvider).watchById(id);

/// Customer currently highlighted in the master/detail layout.
@riverpod
class SelectedCustomerId extends _$SelectedCustomerId {
  @override
  String? build() => null;

  void select(String? id) => state = id;
}
