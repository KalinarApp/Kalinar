import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/common_widgets/loading_indicator.dart';
import 'package:kalinar/src/features/characters/application/notifier/character_state_notifier.dart';
import 'package:kalinar/src/features/characters/presentation/components/character_list.dart';
import 'package:kalinar/src/features/characters/presentation/desktop/character_sheet.dart';

import '../../application/controllers/character_controller.dart';
import '../../application/controllers/character_overview_controller.dart';

class DesktopCharacterScreen extends ConsumerStatefulWidget {
  final String id;

  const DesktopCharacterScreen(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopCharacterScreenState();
}

class _DesktopCharacterScreenState extends ConsumerState<DesktopCharacterScreen> {
  @override
  void initState() {
    ref.read(ownedCharactersProvider).getAll();
    ref.read(foreignCharactersProvider).getAll();
    ref.read(characterControllerProvider).get(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final character = ref.watch(characterStateProvider);
    return Row(
      children: [
        CharacterList(selectedId: widget.id, onSelectionChanged: (id) {}),
        null != character ? CharacterSheet(character) : const LoadingIndicator(""),
      ],
    );
  }
}
