import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_size/window_size.dart';

import 'src/common_widgets/kalinar.dart';
import 'firebase_initialization.dart';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void _loadFlavors() {
  if (kDebugMode) {
    HttpOverrides.global = DevHttpOverrides();
    FlavorConfig(name: "DEV", variables: {"baseUrl": Platform.isAndroid ? "10.0.2.2" : "localhost"});
  } else {
    FlavorConfig(variables: {"baseUrl": "api.kalinar.app"});
  }
}

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('Hero App');
      setWindowMinSize(const Size(500, 800));
    }

    _loadFlavors();
    await initializeFirebase();
    await initializeMessaging();

    runApp(const ProviderScope(child: Kalinar()));
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
