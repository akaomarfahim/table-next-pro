import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/services/logger_service.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../auth/domain/entities/user_role.dart';
import '../../../auth/presentation/controllers/session_controller.dart';

/// In-app log viewer (Talker) for diagnosing issues on site.
class LogsScreen extends ConsumerWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(hasPermissionProvider(Permission.viewLogs))) {
      return Scaffold(
        appBar: AppBar(title: const Text('Diagnostics')),
        body: const EmptyState(
          icon: Icons.lock_outline_rounded,
          title: 'Restricted',
          message: 'Only owners can view diagnostics.',
        ),
      );
    }
    return TalkerScreen(talker: ref.watch(talkerProvider), appBarTitle: 'Diagnostics');
  }
}
