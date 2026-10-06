import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../widgets/customer_detail_view.dart';

/// Stand-alone customer profile route (phones, deep links).
class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer')),
      body: MaxWidthBox(
        maxWidth: 900,
        child: CustomerDetailView(
          customerId: customerId,
          onDeleted: () => context.pop(),
        ),
      ),
    );
  }
}
