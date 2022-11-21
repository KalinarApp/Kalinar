import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        TextField(
          controller: notesController,
          minLines: 1,
          maxLines: 10,
          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.characterNotes),
        ),
        TextField(
          controller: inventoryController,
          minLines: 1,
          maxLines: 10,
          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.characterInventory),
        ),
      ],
    );
  }
}
