import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/layout/responsive_layout.dart';
import '../application/notifier/character_state_notifier.dart';
import 'desktop/character_screen.dart' as desktop;
import 'mobile/character_screen.dart' as mobile;

class CharacterDetailScreen extends ConsumerWidget {
  static const String name = "CharacterDetail";
  static const String route = ":id";

  final String id;

  const CharacterDetailScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(characterStateProvider);

    return ResponsiveLayout(
      mobile: mobile.CharacterScreen(item),
      desktop: desktop.CharacterScreen(item),
    );
  }
}
