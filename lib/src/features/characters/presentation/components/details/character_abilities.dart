import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/features/characters/presentation/components/details/abilities_item.dart';

import '../../../domain/character.dart';

class CharacterAbilities extends ConsumerStatefulWidget {
  final Character character;
  const CharacterAbilities(this.character, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterAbilitiesState();
}

class _CharacterAbilitiesState extends ConsumerState<CharacterAbilities> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.character.unlockedAbilities.length,
      itemBuilder: (context, index) => AbilitiesItem(widget.character.unlockedAbilities[index]),
    );
  }
}
