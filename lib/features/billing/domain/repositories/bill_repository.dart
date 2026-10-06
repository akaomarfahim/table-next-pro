import '../entities/bill.dart';

abstract interface class BillRepository {
  Stream<List<Bill>> watchOpenBills();

  Stream<Bill?> watchById(String id);

  /// Closed (paid / voided) bills whose `closedAt` falls in [from, to).
  Stream<List<Bill>> watchClosedBills(DateTime from, DateTime to);

  Future<List<Bill>> fetchByCustomer(String customerId, {int limit});

  /// Opens a new bill (allocating a sequential bill number when online).
  Future<Bill> open(Bill bill);

  /// Persists items / discount / guests etc. Totals are recalculated.
  Future<void> save(Bill bill);

  /// Records payments, closes the bill and updates customer, reservation
  /// and daily statistics in one atomic batch.
  Future<Bill> settle(Bill bill, List<Payment> payments, {required String userId, required String userName});

  Future<void> voidBill(Bill bill, {required String reason, required String userId, required String userName});
}
