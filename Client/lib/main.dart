import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_initialization.dart';
import 'src/kalinar.dart';
import 'src/utils/local_storage/shared_preferences_helper.dart';

void _loadFlavors() {
  if (kDebugMode) {
    FlavorConfig(name: "DEV", variables: {"baseUrl": !kIsWeb && Platform.isAndroid ? "10.0.2.2" : "localhost"});
  } else {
    FlavorConfig(variables: {"baseUrl": "localhost"});
  }
}

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (!kIsWeb && Platform.isWindows) await initializeMessaging();
    await initializeFirebase();

    _loadFlavors();
    usePathUrlStrategy();
    final sharedPreferences = await SharedPreferences.getInstance();

    final container = ProviderContainer(overrides: [
      getSharedPreferencesProvider.overrideWithValue(SharedPreferencesHelper(sharedPreferences)),
    ]);

    await SentryFlutter.init(
      (options) {
        options.dsn = const String.fromEnvironment("SENTRY_DSN");
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(UncontrolledProviderScope(container: container, child: const Kalinar())),
    );
  }, (error, stack) async {
    await Sentry.captureException(error, stackTrace: stack);
  });
}
