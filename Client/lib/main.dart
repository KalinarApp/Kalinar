import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'firebase_initialization.dart';
import 'src/common_widgets/kalinar.dart';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void _loadFlavors() {
  if (kDebugMode) {
    HttpOverrides.global = DevHttpOverrides();
    FlavorConfig(name: "DEV", variables: {"baseUrl": !kIsWeb && Platform.isAndroid ? "10.0.2.2" : "localhost"});
  } else {
    FlavorConfig(variables: {"baseUrl": "api.kalinar.app"});
  }
}

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    _loadFlavors();
    await initializeFirebase();
    if (!kIsWeb && Platform.isWindows) await initializeMessaging();

    await SentryFlutter.init(
      (options) {
        options.dsn = const String.fromEnvironment("SENTRY_DSN");
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(const ProviderScope(child: Kalinar())),
    );
  }, (error, stack) async {
    await Sentry.captureException(error, stackTrace: stack);
  });
}
