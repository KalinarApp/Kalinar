import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_size/window_size.dart';

import 'src/common_widgets/hero_app.dart';

void main() {
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
    setWindowTitle('Hero App');
    // setWindowMaxSize(const Size(max_width, max_height));
    setWindowMinSize(const Size(500, 800));
  }

  runApp(const ProviderScope(child: HeroApp()));
}
