import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../../floor_plan/domain/entities/floor_element.dart';
import '../../../reservations/data/repositories/reservation_repository_impl.dart';
import '../../../reservations/domain/entities/reservation.dart';
import '../../data/repositories/bill_repository_impl.dart';
import '../../domain/entities/bill.dart';

part 'bill_actions.g.dart';

/// Use-case style façade for bill operations triggered from the UI
/// (POS screen, live floor, reservations).
class BillActions {
  BillActions(this._ref);

  final Ref _ref;

  Future<Bill> openBill({
    OrderType type = OrderType.dineIn,
    List<FloorElement> tables = const [],
    int guests = 1,
    String? customerId,
    String customerName = '',
    String customerPhone = '',
    Reservation? reservation,
  }) async {
    final business = _ref.read(currentBusinessProvider);
    final user = _ref.read(currentUserProvider);
    if (business == null || user == null) {
      throw const AuthenticationException('Session expired. Unlock again.');
    }
    if (type == OrderType.dineIn && tables.isEmpty && reservation == null) {
      throw const ValidationException('Select at least one table for dine-in.');
    }

    final bill = await _ref.read(billRepositoryProvider).open(
          Bill(
            id: '',
            orderType: type,
            tableIds: reservation?.tableIds ?? tables.map((t) => t.id).toList(),
            tableLabels: reservation?.tableLabels ?? tables.map((t) => t.label).toList(),
            reservationId: reservation?.id,
            customerId: reservation?.customerId ?? customerId,
            customerName: reservation?.customerName ?? customerName,
            customerPhone: reservation?.customerPhone ?? customerPhone,
            guests: reservation?.partySize ?? guests,
            taxRate: business.taxRate,
            serviceChargeRate: type == OrderType.dineIn ? business.serviceChargeRate : 0,
            openedById: user.id,
            openedByName: user.name,
          ),
        );

    if (reservation != null) {
      final repo = _ref.read(reservationRepositoryProvider);
      if (reservation.status != ReservationStatus.seated) {
        await repo.changeStatus(reservation, ReservationStatus.seated);
      }
      await repo.linkBill(reservation.id, bill.id);
    }
    return bill;
  }

  /// Persists the (already transformed) bill. See `BillEditing`.
  Future<void> save(Bill bill) => _ref.read(billRepositoryProvider).save(bill);

  Future<Bill> settle(Bill bill, List<Payment> payments) {
    final user = _ref.read(currentUserProvider);
    if (user == null) throw const AuthenticationException();
    return _ref
        .read(billRepositoryProvider)
        .settle(bill, payments, userId: user.id, userName: user.name);
  }

  Future<void> voidBill(Bill bill, String reason) {
    final user = _ref.read(currentUserProvider);
    if (user == null) throw const AuthenticationException();
    return _ref
        .read(billRepositoryProvider)
        .voidBill(bill, reason: reason, userId: user.id, userName: user.name);
  }
}

@Riverpod(keepAlive: true)
BillActions billActions(Ref ref) => BillActions(ref);
