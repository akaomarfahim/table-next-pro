import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/data/daily_stats_writer.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/firebase_providers.dart';
import '../../../auth/presentation/controllers/session_controller.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../datasources/reservation_remote_data_source.dart';
import '../models/reservation_model.dart';

part 'reservation_repository_impl.g.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  ReservationRepositoryImpl(this._remote);

  final ReservationRemoteDataSource _remote;

  List<Reservation> _toEntities(List<ReservationModel> list) =>
      list.map((m) => m.toEntity()).toList();

  @override
  Stream<List<Reservation>> watchRange(DateTime from, DateTime to) =>
      _remote.watchRange(from, to).map(_toEntities);

  @override
  Future<List<Reservation>> fetchRange(DateTime from, DateTime to) async =>
      _toEntities(await _remote.fetchRange(from, to));

  @override
  Stream<Reservation?> watchById(String id) =>
      _remote.watchById(id).map((m) => m?.toEntity());

  @override
  Future<List<Reservation>> fetchByCustomer(String customerId, {int limit = 50}) async =>
      _toEntities(await _remote.fetchByCustomer(customerId, limit));

  void _validate(Reservation r) {
    if (r.partySize < 1) throw const ValidationException('Party size must be at least 1.');
    if (r.durationMinutes < 15) throw const ValidationException('Duration is too short.');
    if (r.customerId.isEmpty) throw const ValidationException('Select a customer.');
  }

  @override
  Future<Reservation> create(Reservation reservation) async {
    _validate(reservation);
    final id = reservation.id.isEmpty ? _remote.newId() : reservation.id;
    final entity = reservation.copyWith(id: id);
    await _remote.create(ReservationModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<void> update(Reservation reservation) async {
    _validate(reservation);
    await _remote.update(ReservationModel.fromEntity(reservation));
  }

  @override
  Future<void> changeStatus(Reservation reservation, ReservationStatus status) {
    if (reservation.status == status) return Future.value();
    final now = Timestamp.now();
    final fields = <String, dynamic>{'status': status.name};
    final customer = <String, num>{};
    final stats = <String, num>{};

    switch (status) {
      case ReservationStatus.seated:
        fields['seatedAt'] = now;
      case ReservationStatus.completed:
        fields['completedAt'] = now;
      case ReservationStatus.cancelled:
        fields['cancelledAt'] = now;
        stats[DailyStatKeys.cancellations] = 1;
      case ReservationStatus.noShow:
        fields['cancelledAt'] = now;
        customer['noShowCount'] = 1;
        stats[DailyStatKeys.noShows] = 1;
      case ReservationStatus.pending:
      case ReservationStatus.confirmed:
        break;
    }
    // Undo counters when re-activating a cancelled / no-show booking.
    if (reservation.status == ReservationStatus.noShow) {
      customer['noShowCount'] = (customer['noShowCount'] ?? 0) - 1;
      stats[DailyStatKeys.noShows] = (stats[DailyStatKeys.noShows] ?? 0) - 1;
    } else if (reservation.status == ReservationStatus.cancelled) {
      stats[DailyStatKeys.cancellations] = (stats[DailyStatKeys.cancellations] ?? 0) - 1;
    }

    return _remote.changeStatus(
      model: ReservationModel.fromEntity(reservation),
      fields: fields,
      customerIncrements: customer..removeWhere((_, v) => v == 0),
      statIncrements: stats..removeWhere((_, v) => v == 0),
    );
  }

  @override
  Future<void> linkBill(String reservationId, String billId) =>
      _remote.patch(reservationId, {'billId': billId});
}

@Riverpod(keepAlive: true)
ReservationRepository reservationRepository(Ref ref) => ReservationRepositoryImpl(
      ReservationRemoteDataSource(
        ref.watch(firestoreProvider),
        ref.watch(requireBusinessIdProvider),
      ),
    );
