import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/app_user.dart';
import 'session_controller.dart';

part 'staff_providers.g.dart';

/// Realtime list of staff for the current business.
@riverpod
Stream<List<AppUser>> staffUsers(Ref ref) {
  final businessId = ref.watch(requireBusinessIdProvider);
  return ref.watch(userRepositoryProvider).watchUsers(businessId);
}
