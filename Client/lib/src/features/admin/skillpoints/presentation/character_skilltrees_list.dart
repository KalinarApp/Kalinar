import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';

import '../../../characters/domain/character_overview.dart';
import 'skillpoint_selector.dart';

class CharacterSkilltreesList extends StatelessWidget {
  final CharacterOverview character;
  final ScrollController? controller;

  const CharacterSkilltreesList({required this.character, this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final items = [...character.skilltrees]..sortBy((element) => removeDiacritics(element.name.toLowerCase()));

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 24.0, bottom: 12.0),
        child: ListView.separated(
          controller: controller,
          shrinkWrap: true,
          itemBuilder: (context, index) => SkillpointSelector(items[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemCount: items.length,
        ),
      ),
    );
  }
}
