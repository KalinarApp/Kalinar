import 'package:flutter/material.dart';
import 'package:kalinar/src/common_widgets/layout/responsive_layout.dart';

import 'desktop/desktop_characters_screen.dart';
import 'mobile/mobile_character_screen.dart';

class CharacterDetailScreen extends StatelessWidget {
  static const String name = "CharacterDetail";
  static const String route = ":id";

  final String id;

  const CharacterDetailScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: MobileCharacterScreen(id),
      desktop: DesktopCharacterScreen(id),
    );
  }
}
