import 'package:flutter/material.dart';
import 'package:kalinar/src/features/characters/domain/character.dart';

class CharacterSheet extends StatelessWidget {
  final Character character;

  const CharacterSheet(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(character.name));
  }
}
