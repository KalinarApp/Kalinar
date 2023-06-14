import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/layout/responsive_layout.dart';
import '../application/controllers/character_controller.dart';
import '../application/notifier/character_state_notifier.dart';
import 'desktop/character_screen.dart' as desktop;
import 'mobile/character_screen.dart' as mobile;

class CharacterDetailScreen extends HookConsumerWidget {
  static const String name = "CharacterDetail";
  static const String route = ":id";

  final String id;

  const CharacterDetailScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(characterControllerProvider).get(id);
      return;
    });

    final item = ref.watch(characterStateProvider);

    return ResponsiveLayout(
      mobile: mobile.CharacterScreen(item),
      desktop: desktop.CharacterScreen(item),
    );
  }
}
