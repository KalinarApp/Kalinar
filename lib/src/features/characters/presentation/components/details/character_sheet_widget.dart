import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/features/characters/application/character_controller.dart';
import 'package:kalinar/src/features/characters/presentation/components/details/auto_saving_text_field.dart';
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
        AutoSavingTextField(
          title: AppLocalizations.of(context)!.characterInventory,
          initialValue: widget.character.inventory,
          onSaving: (currentText) async {
            await ref.read(characterControllerProvider).update(widget.character.id, {"inventory": currentText});
          },
        ),
        AutoSavingTextField(
          title: AppLocalizations.of(context)!.characterNotes,
          initialValue: widget.character.notes,
          onSaving: (currentText) async => await ref.read(characterControllerProvider).update(widget.character.id, {"notes": currentText}),
        ),
      ],
    );
  }
}
