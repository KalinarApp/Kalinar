import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/features/characters/presentation/components/details/character_attributes.dart';

import '../../../domain/character.dart';

import 'character_information.dart';

class CharacterSheetWidget extends ConsumerStatefulWidget {
  final Character character;

  const CharacterSheetWidget(this.character, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterSheetWidgetState();
}

class _CharacterSheetWidgetState extends ConsumerState<CharacterSheetWidget> {
  late final notesController;
  late final inventoryController;

  @override
  void initState() {
    notesController = TextEditingController(text: widget.character.notes);
    inventoryController = TextEditingController(text: widget.character.inventory);

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
        TextField(
          controller: inventoryController,
          enabled: false,
          minLines: 1,
          maxLines: 10,
          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.characterInventory),
        ),
        TextField(
          controller: notesController,
          enabled: false,
          minLines: 1,
          maxLines: 10,
          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.characterNotes),
        ),
      ],
    );
  }
}
