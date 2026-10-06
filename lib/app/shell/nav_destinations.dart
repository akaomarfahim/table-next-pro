import 'package:flutter/material.dart';

import '../../core/router/app_routes.dart';

/// Primary navigation destinations (order is significant: the first
/// [primaryOnPhone] entries appear in the phone bottom bar).
class NavDestination {
  const NavDestination({
    required this.label,
    required this.path,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final String path;
  final IconData icon;
  final IconData selectedIcon;

  static const int primaryOnPhone = 4;

  static const List<NavDestination> all = [
    NavDestination(
      label: 'Dashboard',
      path: AppRoutes.dashboard,
      icon: Icons.space_dashboard_outlined,
      selectedIcon: Icons.space_dashboard_rounded,
    ),
    NavDestination(
      label: 'Floor',
      path: AppRoutes.floor,
      icon: Icons.table_restaurant_outlined,
      selectedIcon: Icons.table_restaurant_rounded,
    ),
    NavDestination(
      label: 'Reservations',
      path: AppRoutes.reservations,
      icon: Icons.event_note_outlined,
      selectedIcon: Icons.event_note_rounded,
    ),
    NavDestination(
      label: 'Billing',
      path: AppRoutes.billing,
      icon: Icons.receipt_long_outlined,
      selectedIcon: Icons.receipt_long_rounded,
    ),
    NavDestination(
      label: 'Customers',
      path: AppRoutes.customers,
      icon: Icons.people_alt_outlined,
      selectedIcon: Icons.people_alt_rounded,
    ),
    NavDestination(
      label: 'Menu',
      path: AppRoutes.menu,
      icon: Icons.restaurant_menu_outlined,
      selectedIcon: Icons.restaurant_menu_rounded,
    ),
    NavDestination(
      label: 'Settings',
      path: AppRoutes.settings,
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
    ),
  ];

  /// Index of the destination matching [location] (longest prefix match).
  static int indexOf(String location) {
    var best = 0;
    var bestLength = -1;
    for (var i = 0; i < all.length; i++) {
      final path = all[i].path;
      final matches = path == '/'
          ? location == '/'
          : location == path || location.startsWith('$path/');
      if (matches && path.length > bestLength) {
        best = i;
        bestLength = path.length;
      }
    }
    return best;
  }
}
