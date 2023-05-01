import 'package:flutter/material.dart';
import 'package:kalinar/src/features/characters/domain/character.dart';
import 'package:kalinar/src/features/characters/presentation/desktop/big_character_sheet.dart';
import 'package:kalinar/src/features/characters/presentation/desktop/medium_character_sheet.dart';
import 'package:kalinar/src/features/characters/presentation/desktop/small_character_sheet.dart';

import '../../../../common_widgets/layout/responsive_layout.dart';

class CharacterSheet extends StatelessWidget {
  final Character character;

  const CharacterSheet(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: SmallCharacterSheet(character),
      tablet: MediumCharacterSheet(character),
      desktop: BigCharacterSheet(character),
    );
  }
}
