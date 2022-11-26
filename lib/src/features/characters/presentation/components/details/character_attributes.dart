import 'package:flutter/material.dart';

import 'package:kalinar/src/features/characters/domain/character.dart';
import 'package:kalinar/src/features/characters/presentation/components/attribute_value_widget.dart';

class CharacterAttributes extends StatelessWidget {
  final Character character;

  const CharacterAttributes(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4,
      spacing: 12,
      children: [
        for (final attribute in character.attributes) AttributeValueWidget(attribute),
      ],
    );
  }
}
