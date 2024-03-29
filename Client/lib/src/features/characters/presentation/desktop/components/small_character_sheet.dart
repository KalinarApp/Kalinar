import 'package:flutter/material.dart';

import '../../../domain/character.dart';
import '../../shared/details/character_abilities.dart';
import '../../shared/details/character_skilltree_list.dart';
import '../../shared/details/inventory_text_field.dart';
import '../../shared/details/notes_text_field.dart';
import 'character_attributes.dart';
import 'character_information.dart';
import 'custom_card.dart';

class SmallCharacterSheet extends StatelessWidget {
  final Character character;
  final bool Function() isOwner;
  final bool Function() isOwnerOrAdmin;

  const SmallCharacterSheet(this.character, {required this.isOwner, required this.isOwnerOrAdmin, super.key});

  Widget _buildSkilltrees() {
    return isOwnerOrAdmin() || (character.shareSkilltree ?? false)
        ? Expanded(flex: 1, child: CustomCard(child: CharacterSkilltreeList(character, fillContent: true)))
        : Container();
  }

  Widget _buildAttributes() {
    return isOwnerOrAdmin() || (character.shareAttributes ?? false)
        ? SizedBox(height: 250, child: CustomCard(child: CharacterAttributes(character)))
        : Container();
  }

  Widget _buildInventory() {
    return isOwnerOrAdmin() || (character.shareInventory ?? false) ? Expanded(child: InventoryTextField(character)) : Container();
  }

  Widget _buildNotes() {
    return isOwnerOrAdmin() || (character.shareNotes ?? false) ? Expanded(child: NotesTextField(character)) : Container();
  }

  Widget _buildAbilities(BoxConstraints constraints) {
    return isOwnerOrAdmin() || (character.shareAbilities ?? false)
        ? Expanded(
            flex: 1,
            child: SizedBox(
              width: constraints.maxWidth / 3,
              child: CustomCard(child: CharacterAbilities(character)),
            ))
        : Container();
  }

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
                  _buildAbilities(constraints),
                ],
              ),
            ),
            if (isOwnerOrAdmin() ||
                ((character.shareAttributes ?? false) ||
                    (character.shareSkilltree ?? false) ||
                    ((character.shareInventory ?? false) || (character.shareNotes ?? false))))
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildAttributes(),
                    if (isOwnerOrAdmin() ||
                        ((character.shareSkilltree ?? false) || ((character.shareInventory ?? false) || (character.shareNotes ?? false))))
                      Expanded(
                        child: Column(
                          children: [
                            if (isOwnerOrAdmin() || ((character.shareInventory ?? false) || (character.shareNotes ?? false)))
                              Expanded(
                                child: CustomCard(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        _buildInventory(),
                                        const SizedBox(width: 20),
                                        _buildNotes(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            _buildSkilltrees(),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}
