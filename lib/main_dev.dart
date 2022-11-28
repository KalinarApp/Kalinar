import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_size/window_size.dart';

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

  await SentryFlutter.init(
    (options) {
      options.dsn = const String.fromEnvironment("SENTRY_DSN");
      options.tracesSampleRate = 1.0;
      options.debug = true;
    },
    appRunner: () => runApp(const ProviderScope(child: Kalinar())),
  );
}
