import 'package:flutter/material.dart';

import '../../domain/entities/floor_enums.dart';

/// Visual style (icon + colour) of each [StructureType].
extension StructureStyle on StructureType {
  IconData get icon => switch (this) {
        StructureType.kitchen => Icons.soup_kitchen_rounded,
        StructureType.bar => Icons.local_bar_rounded,
        StructureType.register => Icons.point_of_sale_rounded,
        StructureType.hostStand => Icons.room_service_rounded,
        StructureType.entrance => Icons.door_front_door_rounded,
        StructureType.restroom => Icons.wc_rounded,
        StructureType.stage => Icons.mic_external_on_rounded,
        StructureType.buffet => Icons.brunch_dining_rounded,
        StructureType.storage => Icons.inventory_2_rounded,
        StructureType.stairs => Icons.stairs_rounded,
        StructureType.wall => Icons.horizontal_rule_rounded,
        StructureType.window => Icons.window_rounded,
        StructureType.pillar => Icons.circle,
        StructureType.plant => Icons.local_florist_rounded,
        StructureType.zone => Icons.crop_free_rounded,
      };

  Color get color => switch (this) {
        StructureType.kitchen => const Color(0xFFF79009),
        StructureType.bar => const Color(0xFF7A5AF8),
        StructureType.register => const Color(0xFF14A38B),
        StructureType.hostStand => const Color(0xFF2E90FA),
        StructureType.entrance => const Color(0xFF12B76A),
        StructureType.restroom => const Color(0xFF0BA5EC),
        StructureType.stage => const Color(0xFFDD2590),
        StructureType.buffet => const Color(0xFFEF6820),
        StructureType.storage => const Color(0xFF8B6E4E),
        StructureType.stairs => const Color(0xFF667085),
        StructureType.wall => const Color(0xFF475467),
        StructureType.window => const Color(0xFF53B1FD),
        StructureType.pillar => const Color(0xFF667085),
        StructureType.plant => const Color(0xFF16B364),
        StructureType.zone => const Color(0xFF6172F3),
      };
}
