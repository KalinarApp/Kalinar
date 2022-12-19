import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_size/window_size.dart';

import 'firebase_options.dart';
import 'src/common_widgets/kalinar.dart';

void main() async {
  FlavorConfig(
    name: "DEV",
    color: Colors.red,
    location: BannerLocation.topEnd,
    variables: {
      "baseUrl": Platform.isAndroid ? "10.0.2.2" : "localhost",
    },
  );

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Kalinar');
    setWindowMinSize(const Size(500, 800));
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    GoogleProvider(clientId: "718959006853-ena00d420kfimet6gj1dsf72f026jui6.apps.googleusercontent.com"),
  ]);

  await SentryFlutter.init(
    (options) {
      options.dsn = const String.fromEnvironment("SENTRY_DSN");
      options.tracesSampleRate = 1.0;
      options.debug = true;
    },
    appRunner: () => runApp(const ProviderScope(child: Kalinar())),
  );
}
