// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'connectivity_service.g.dart';

// /// Emits `true` while the device has a network interface available.
// ///
// /// Firestore keeps working offline (reads from cache, queues writes), so
// /// this is used only to inform the user via the offline banner.
// @Riverpod(keepAlive: true)
// Stream<bool> isOnline(Ref ref) async* {
//   final connectivity = Connectivity();
//   bool online(List<ConnectivityResult> results) =>
//       results.any((r) => r != ConnectivityResult.none);

//   yield online(await connectivity.checkConnectivity());
//   yield* connectivity.onConnectivityChanged.map(online).distinct();
// }
