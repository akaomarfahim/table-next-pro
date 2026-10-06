import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'app/app.dart';
import 'core/services/local_storage_service.dart';
import 'core/services/logger_service.dart';
import 'firebase_options.dart';

/// Initializes infrastructure and starts the app.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init(settings: TalkerSettings(maxHistoryItems: 500, useConsoleLogs: true));

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack, 'FlutterError');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Uncaught platform error');
    return true;
  };

  GoogleFonts.config.allowRuntimeFetching = true;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Offline-first: unlimited local cache so the app keeps working (and
  // reads stay cheap) on unstable restaurant networks.
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  final storage = await LocalStorageService.init();

  talker.info('Bootstrap complete');

  runApp(
    ProviderScope(
      overrides: [talkerProvider.overrideWithValue(talker), localStorageServiceProvider.overrideWithValue(storage)],
      observers: [TalkerRiverpodObserver(talker: talker)],
      // Firestore errors (permission / missing data) should surface
      // immediately instead of being retried automatically.
      retry: (retryCount, error) => null,
      child: const TableNextApp(),
    ),
  );
}
