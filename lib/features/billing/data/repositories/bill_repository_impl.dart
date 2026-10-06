import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/data/daily_stats_writer.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/firebase_providers.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../domain/entities/bill.dart';
import '../../domain/repositories/bill_repository.dart';
import '../../domain/services/bill_calculator.dart';
import '../datasources/bill_remote_data_source.dart';
import '../models/bill_model.dart';

part 'bill_repository_impl.g.dart';

class BillRepositoryImpl implements BillRepository {
  BillRepositoryImpl(this._remote);

  final BillRemoteDataSource _remote;

  @override
  Stream<List<Bill>> watchOpenBills() =>
      _remote.watchOpen().map((l) => l.map((m) => m.toEntity()).toList());

  @override
  Stream<Bill?> watchById(String id) => _remote.watchById(id).map((m) => m?.toEntity());

  @override
  Stream<List<Bill>> watchClosedBills(DateTime from, DateTime to) =>
      _remote.watchClosed(from, to).map((l) => l.map((m) => m.toEntity()).toList());

  @override
  Future<List<Bill>> fetchByCustomer(String customerId, {int limit = 30}) async =>
      (await _remote.fetchByCustomer(customerId, limit)).map((m) => m.toEntity()).toList();

  @override
  Future<Bill> open(Bill bill) async {
    final id = bill.id.isEmpty ? _remote.newId() : bill.id;
    final number = await _remote.nextBillNumber();
    final entity = BillCalculator.recalculate(
      bill.copyWith(id: id, billNumber: number, status: BillStatus.open, createdAt: DateTime.now()),
    );
    await _remote.create(BillModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<void> save(Bill bill) async {
    if (!bill.isOpen) throw const ValidationException('This bill is already closed.');
    await _remote.update(BillModel.fromEntity(BillCalculator.recalculate(bill)));
  }

  @override
  Future<Bill> settle(
    Bill bill,
    List<Payment> payments, {
    required String userId,
    required String userName,
  }) async {
    if (!bill.isOpen) throw const ValidationException('This bill is already closed.');
    if (bill.items.isEmpty) throw const ValidationException('Add at least one item.');
    final calculated = BillCalculator.recalculate(bill);
    final paid = payments.fold(0.0, (s, p) => s + p.amount);
    if (paid + 0.009 < calculated.totals.total) {
      throw const ValidationException('Payments do not cover the bill total.');
    }

    // Change returned to the customer is deducted from the cash portion so
    // revenue figures reflect the bill total exactly.
    var change = paid - calculated.totals.total;
    final normalized = <Payment>[];
    for (final p in payments.reversed) {
      if (change > 0 && p.method == PaymentMethod.cash) {
        final keep = (p.amount - change).clamp(0.0, p.amount);
        change -= p.amount - keep;
        if (keep > 0) normalized.insert(0, p.copyWith(amount: keep));
      } else {
        normalized.insert(0, p);
      }
    }

    final now = DateTime.now();
    final closed = calculated.copyWith(
      status: BillStatus.paid,
      payments: normalized,
      closedAt: now,
      closedById: userId,
      closedByName: userName,
    );

    double sumOf(PaymentMethod m) =>
        normalized.where((p) => p.method == m).fold(0.0, (s, p) => s + p.amount);

    await _remote.settle(
      model: BillModel.fromEntity(closed),
      closedAt: now,
      statIncrements: {
        DailyStatKeys.revenue: closed.totals.total,
        DailyStatKeys.bills: 1,
        DailyStatKeys.guests: closed.guests,
        DailyStatKeys.discounts: closed.totals.discount,
        DailyStatKeys.tax: closed.totals.tax,
        DailyStatKeys.cash: sumOf(PaymentMethod.cash),
        DailyStatKeys.card: sumOf(PaymentMethod.card),
        DailyStatKeys.mobile: sumOf(PaymentMethod.mobile),
        DailyStatKeys.otherPayments: sumOf(PaymentMethod.other),
      },
    );
    return closed;
  }

  @override
  Future<void> voidBill(
    Bill bill, {
    required String reason,
    required String userId,
    required String userName,
  }) async {
    if (!bill.isOpen) throw const ValidationException('Only open bills can be voided.');
    final now = DateTime.now();
    await _remote.voidBill(
      model: BillModel.fromEntity(
        bill.copyWith(
          status: BillStatus.voided,
          voidReason: reason,
          closedAt: now,
          closedById: userId,
          closedByName: userName,
        ),
      ),
      closedAt: now,
    );
  }
}

@Riverpod(keepAlive: true)
BillRepository billRepository(Ref ref) => BillRepositoryImpl(
      BillRemoteDataSource(
        ref.watch(firestoreProvider),
        ref.watch(requireBusinessIdProvider),
      ),
    );
