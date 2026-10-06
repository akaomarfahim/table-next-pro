/// A page of results from a cursor-based query.
///
/// [cursor] is an opaque token owned by the data layer (a Firestore
/// `DocumentSnapshot`) so the domain and presentation layers stay
/// independent of Firebase types.
class PageResult<T> {
  const PageResult({
    required this.items,
    required this.cursor,
    required this.hasMore,
  });

  const PageResult.empty() : items = const [], cursor = null, hasMore = false;

  final List<T> items;
  final Object? cursor;
  final bool hasMore;
}
