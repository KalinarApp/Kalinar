import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/layout/responsive_layout.dart';
import '../application/notifier/character_state_notifier.dart';
import 'desktop/desktop_characters_screen.dart';
import 'mobile/mobile_character_screen.dart';

class CharacterDetailScreen extends ConsumerWidget {
  static const String name = "CharacterDetail";
  static const String route = ":id";

  final String id;

  const CharacterDetailScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(characterStateProvider);

    return ResponsiveLayout(
      mobile: MobileCharacterScreen(item),
      desktop: DesktopCharacterScreen(item),
    );
  }
}
