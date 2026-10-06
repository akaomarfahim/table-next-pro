import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/reservation.dart';

extension ReservationStatusStyle on ReservationStatus {
  Color color(BuildContext context) => switch (this) {
        ReservationStatus.pending => context.palette.warning,
        ReservationStatus.confirmed => context.palette.info,
        ReservationStatus.seated => context.colors.primary,
        ReservationStatus.completed => context.palette.success,
        ReservationStatus.cancelled => context.palette.textMuted,
        ReservationStatus.noShow => context.palette.danger,
      };

  IconData get icon => switch (this) {
        ReservationStatus.pending => Icons.hourglass_top_rounded,
        ReservationStatus.confirmed => Icons.event_available_rounded,
        ReservationStatus.seated => Icons.event_seat_rounded,
        ReservationStatus.completed => Icons.check_circle_rounded,
        ReservationStatus.cancelled => Icons.cancel_rounded,
        ReservationStatus.noShow => Icons.person_off_rounded,
      };
}
