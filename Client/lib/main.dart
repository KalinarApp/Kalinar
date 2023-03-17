import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_size/window_size.dart';

import 'firebase_options.dart';
import 'src/common_widgets/kalinar.dart';

void main() async {
  await runZonedGuarded(() async {
    FlavorConfig(
      variables: {
        "baseUrl": "api.kalinar.app",
      },
    );

    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('Hero App');
      setWindowMinSize(const Size(500, 800));
    }

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      await FirebasePerformance.instance.setPerformanceCollectionEnabled(false);
    }

    FirebaseUIAuth.configureProviders([GoogleProvider(clientId: "718959006853-ena00d420kfimet6gj1dsf72f026jui6.apps.googleusercontent.com")]);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    ErrorWidget.builder = (FlutterErrorDetails error) {
      Zone.current.handleUncaughtError(error.exception, error.stack!);
      return ErrorWidget(error.exception);
    };

    runApp(const ProviderScope(child: Kalinar()));
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
