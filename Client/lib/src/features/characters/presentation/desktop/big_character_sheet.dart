import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/character.dart';
import '../shared/details/auto_saving_text_field.dart';
import '../shared/details/character_abilities.dart';
import '../shared/details/character_skilltree_list.dart';
import 'components/character_attributes.dart';
import 'components/character_information.dart';

class BigCharacterSheet extends StatelessWidget {
  final Character character;

  const BigCharacterSheet(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CharacterInformation(character: character, maxHeight: constraints.maxHeight / 2),
                  Expanded(
                    flex: 1,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 26,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      child: Expanded(child: CharacterSkilltreeList(character, fillContent: true)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 26,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      child: CharacterAttributes(character),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 26,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: AutoSavingTextField(
                                title: AppLocalizations.of(context)!.characterInventory,
                                initialValue: character.inventory,
                                minLines: null,
                                maxLines: null,
                                expands: true,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                // enabled: _isOwner(item),
                                // onSaving: (currentText) async => await _saveField("inventory", currentText),
                                onSaving: (currentText) {},
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: AutoSavingTextField(
                                title: AppLocalizations.of(context)!.characterNotes,
                                initialValue: character.notes,
                                minLines: null,
                                maxLines: null,
                                expands: true,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                // enabled: _isOwner(item),
                                // onSaving: (currentText) async => await _saveField("notes", currentText),
                                onSaving: (currentText) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: constraints.maxWidth / 3,
                child: Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 26,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  child: CharacterAbilities(character),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
