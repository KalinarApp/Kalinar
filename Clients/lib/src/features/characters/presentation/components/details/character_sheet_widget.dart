import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/character.dart';

import 'character_attributes.dart';
import 'character_information.dart';

class CharacterSheetWidget extends ConsumerStatefulWidget {
  final Character character;

  const CharacterSheetWidget(this.character, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterSheetWidgetState();
}

class _CharacterSheetWidgetState extends ConsumerState<CharacterSheetWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CharacterInformation(widget.character),
        Padding(
          padding: const EdgeInsets.all(4),
          child: CharacterAttributes(widget.character),
        ),
      ],
    );
  }
}
