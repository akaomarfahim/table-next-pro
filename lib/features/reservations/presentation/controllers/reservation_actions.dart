import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../billing/presentation/controllers/bill_actions.dart';
import '../../data/repositories/reservation_repository_impl.dart';
import '../../domain/entities/reservation.dart';

/// Status transitions available from a given status.
List<ReservationStatus> nextStatuses(ReservationStatus s) => switch (s) {
      ReservationStatus.pending => [
          ReservationStatus.confirmed,
          ReservationStatus.seated,
          ReservationStatus.cancelled,
          ReservationStatus.noShow,
        ],
      ReservationStatus.confirmed => [
          ReservationStatus.seated,
          ReservationStatus.cancelled,
          ReservationStatus.noShow,
        ],
      ReservationStatus.seated => [ReservationStatus.completed],
      ReservationStatus.completed => const [],
      ReservationStatus.cancelled || ReservationStatus.noShow => [ReservationStatus.confirmed],
    };

/// Applies a status change with confirmations and side effects.
/// Seating a guest opens a bill for the reserved tables.
Future<void> applyReservationStatus(
  BuildContext context,
  WidgetRef ref,
  Reservation reservation,
  ReservationStatus status,
) async {
  if (status == ReservationStatus.cancelled || status == ReservationStatus.noShow) {
    final ok = await showConfirmDialog(
      context,
      title: status == ReservationStatus.cancelled ? 'Cancel reservation?' : 'Mark as no-show?',
      message: '${reservation.customerName} · ${reservation.partySize} guests. '
          'The tables will be released.',
      confirmLabel: status == ReservationStatus.cancelled ? 'Cancel booking' : 'Mark no-show',
      cancelLabel: 'Keep',
      destructive: true,
    );
    if (!ok) return;
  }
  try {
    if (status == ReservationStatus.seated) {
      if (reservation.tableIds.isEmpty) {
        await ref.read(reservationRepositoryProvider).changeStatus(reservation, status);
        if (context.mounted) context.showSnack('Guest seated');
        return;
      }
      final bill = await ref.read(billActionsProvider).openBill(reservation: reservation);
      if (context.mounted) {
        context.showSnack('Seated ${reservation.customerName} · bill opened');
        context.go(AppRoutes.bill(bill.id));
      }
      return;
    }
    await ref.read(reservationRepositoryProvider).changeStatus(reservation, status);
    if (context.mounted) context.showSnack('Marked as ${status.label.toLowerCase()}');
  } catch (e) {
    if (context.mounted) context.showError(e);
  }
}
