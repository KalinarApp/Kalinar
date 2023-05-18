import 'package:flutter/material.dart';

import '../../domain/character.dart';
import '../components/details/character_information.dart';

class MediumCharacterSheet extends StatelessWidget {
  final Character character;

  const MediumCharacterSheet(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            SizedBox(height: 300, width: 300, child: CharacterInformation(character)),
          ],
        )
      ],
    );
  }
}
