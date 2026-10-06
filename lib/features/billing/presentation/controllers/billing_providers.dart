import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/formatters.dart';
import '../../data/repositories/bill_repository_impl.dart';
import '../../domain/entities/bill.dart';

part 'billing_providers.g.dart';

/// All open bills (kept alive: used by billing, dashboard and live floor).
@Riverpod(keepAlive: true)
Stream<List<Bill>> openBills(Ref ref) =>
    ref.watch(billRepositoryProvider).watchOpenBills();

@riverpod
Stream<Bill?> billById(Ref ref, String id) =>
    ref.watch(billRepositoryProvider).watchById(id);

@riverpod
class BillHistoryDate extends _$BillHistoryDate {
  @override
  DateTime build() => DateUtilsX.startOfDay(DateTime.now());

  void set(DateTime day) => state = DateUtilsX.startOfDay(day);
}

@riverpod
Stream<List<Bill>> closedBillsForDay(Ref ref, DateTime day) {
  final start = DateUtilsX.startOfDay(day);
  return ref
      .watch(billRepositoryProvider)
      .watchClosedBills(start, DateUtilsX.endOfDay(start));
}

@riverpod
Future<List<Bill>> customerBills(Ref ref, String customerId) =>
    ref.watch(billRepositoryProvider).fetchByCustomer(customerId);
