import 'package:flutter/material.dart';

import '../../domain/character.dart';
import '../components/details/character_abilities.dart';
import '../components/details/character_skilltree_list.dart';
import 'character_attributes.dart';
import 'character_information.dart';

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
                  Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 26,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    child: Expanded(child: CharacterSkilltreeList(character, fillContent: true)),
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
                  )
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
