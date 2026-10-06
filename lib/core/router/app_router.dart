import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/shell/app_shell.dart';
import '../../app/splash_screen.dart';
import '../../features/auth/domain/entities/session_state.dart';
import '../../features/auth/presentation/controllers/session_controller.dart';
import '../../features/auth/presentation/screens/activation_screen.dart';
import '../../features/auth/presentation/screens/business_setup_screen.dart';
import '../../features/auth/presentation/screens/lock_screen.dart';
import '../../features/auth/presentation/screens/staff_screen.dart';
import '../../features/billing/presentation/screens/bill_screen.dart';
import '../../features/billing/presentation/screens/billing_screen.dart';
import '../../features/business/presentation/screens/business_profile_screen.dart';
import '../../features/customers/presentation/screens/customer_detail_screen.dart';
import '../../features/customers/presentation/screens/customers_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/floor_plan/presentation/screens/floor_editor_screen.dart';
import '../../features/floor_plan/presentation/screens/floor_view_screen.dart';
import '../../features/menu/presentation/screens/menu_screen.dart';
import '../../features/reservations/presentation/screens/reservation_form_screen.dart';
import '../../features/reservations/presentation/screens/reservations_screen.dart';
import '../../features/settings/presentation/screens/logs_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

/// Notifies GoRouter to re-run redirects when the session *kind* changes.
class _RouterRefresh extends ChangeNotifier {
  void refresh() => notifyListeners();
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = _RouterRefresh();
  ref.listen(
    sessionControllerProvider.select(
      (s) => (s.isLoading && !s.hasValue, s.hasError, s.value.runtimeType),
    ),
    (_, _) => refresh.refresh(),
  );

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final session = ref.read(sessionControllerProvider);
      final location = state.matchedLocation;

      if (!session.hasValue) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      final value = session.requireValue;
      switch (value) {
        case SessionNeedsActivation():
          return AppRoutes.publicRoutes.contains(location)
              ? null
              : AppRoutes.activate;
        case SessionLocked():
          if (location == AppRoutes.lock) return null;
          final from = _isAppRoute(location) ? state.uri.toString() : null;
          return Uri(
            path: AppRoutes.lock,
            queryParameters: from == null ? null : {'from': from},
          ).toString();
        case SessionUnlocked():
          if (!_isAppRoute(location)) {
            final from = state.uri.queryParameters['from'];
            return (from != null && from.startsWith('/')) ? from : AppRoutes.dashboard;
          }
          return null;
      }
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.activate,
        builder: (context, state) => const ActivationScreen(),
      ),
      GoRoute(
        path: AppRoutes.setup,
        builder: (context, state) => const BusinessSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.lock,
        pageBuilder: (context, state) => const NoTransitionPage(child: LockScreen()),
      ),
      GoRoute(
        path: AppRoutes.floorEditor,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const FloorEditorScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(location: state.uri.path, child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DashboardScreen()),
          ),
          GoRoute(
            path: AppRoutes.floor,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: FloorViewScreen()),
          ),
          GoRoute(
            path: AppRoutes.reservations,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ReservationsScreen()),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) {
                  final q = state.uri.queryParameters;
                  return ReservationFormScreen(
                    initialTableId: q['table'],
                    initialDate: DateTime.tryParse(q['date'] ?? ''),
                    initialCustomerId: q['customer'],
                  );
                },
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => ReservationFormScreen(
                  reservationId: state.pathParameters['id'],
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.customers,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CustomersScreen()),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) => CustomerDetailScreen(
                  customerId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.billing,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: BillingScreen()),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) =>
                    BillScreen(billId: state.pathParameters['id']!),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.menu,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MenuScreen()),
          ),
          GoRoute(
            path: AppRoutes.settings,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SettingsScreen()),
            routes: [
              GoRoute(
                path: 'business',
                builder: (context, state) => const BusinessProfileScreen(),
              ),
              GoRoute(
                path: 'staff',
                builder: (context, state) => const StaffScreen(),
              ),
              GoRoute(
                path: 'logs',
                parentNavigatorKey: rootNavigatorKey,
                builder: (context, state) => const LogsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
}

bool _isAppRoute(String location) =>
    location != AppRoutes.splash &&
    location != AppRoutes.lock &&
    !AppRoutes.publicRoutes.contains(location);
