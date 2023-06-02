import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_size/window_size.dart';

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
    FlavorConfig(name: "DEV", variables: {"baseUrl": !kIsWeb && Platform.isAndroid ? "10.0.2.2" : "localhost:7272"});
  } else {
    FlavorConfig(variables: {"baseUrl": "localhost:7272"});
  }
}

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      setWindowTitle('Hero App');
      setWindowMinSize(const Size(500, 800));
    }

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
