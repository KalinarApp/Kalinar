import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero/src/common_widgets/hero_app.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('My App');
    // setWindowMaxSize(const Size(max_width, max_height));
    setWindowMinSize(const Size(800, 600));
  }

  runApp(const HeroApp());
}
