import '../entities/reservation.dart';

abstract interface class ReservationRepository {
  /// Reservations starting within [from, to), ordered by start time.
  Stream<List<Reservation>> watchRange(DateTime from, DateTime to);

  Future<List<Reservation>> fetchRange(DateTime from, DateTime to);

  Stream<Reservation?> watchById(String id);

  /// Latest reservations of a customer (most recent first).
  Future<List<Reservation>> fetchByCustomer(String customerId, {int limit});

  /// Creates the reservation and bumps customer / daily counters atomically.
  Future<Reservation> create(Reservation reservation);

  Future<void> update(Reservation reservation);

  /// Changes status with timestamps and side effects (no-show counter...).
  Future<void> changeStatus(Reservation reservation, ReservationStatus status);

  Future<void> linkBill(String reservationId, String billId);
}
