/// Fine grained capabilities checked by the UI and controllers.
enum Permission {
  manageBusiness,
  manageStaff,
  editFloorPlan,
  manageReservations,
  manageCustomers,
  deleteCustomers,
  manageMenu,
  takeOrders,
  settleBills,
  voidBills,
  viewReports,
  viewLogs,
}

/// Staff roles. Each role maps to a fixed set of [Permission]s.
enum UserRole {
  owner('Owner'),
  manager('Manager'),
  host('Host'),
  cashier('Cashier'),
  waiter('Waiter');

  const UserRole(this.label);

  final String label;

  Set<Permission> get permissions => switch (this) {
        UserRole.owner => Permission.values.toSet(),
        UserRole.manager => Permission.values
            .where((p) => p != Permission.viewLogs)
            .toSet(),
        UserRole.host => {
            Permission.manageReservations,
            Permission.manageCustomers,
            Permission.takeOrders,
          },
        UserRole.cashier => {
            Permission.manageReservations,
            Permission.manageCustomers,
            Permission.takeOrders,
            Permission.settleBills,
            Permission.viewReports,
          },
        UserRole.waiter => {
            Permission.takeOrders,
            Permission.manageReservations,
          },
      };

  bool can(Permission permission) => permissions.contains(permission);

  String get description => switch (this) {
        UserRole.owner => 'Full access including staff, settings and logs',
        UserRole.manager => 'Everything except diagnostics',
        UserRole.host => 'Reservations, customers and opening tables',
        UserRole.cashier => 'Billing, payments, reservations and reports',
        UserRole.waiter => 'Taking orders and reservations',
      };
}
