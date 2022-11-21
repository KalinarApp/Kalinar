import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:hero/src/features/characters/domain/character.dart';
import 'package:hero/src/features/characters/presentation/components/details/character_portrait.dart';
import 'package:hero/src/features/characters/presentation/components/details/information_row.dart';

class CharacterInformation extends StatelessWidget {
  final Character item;

  const CharacterInformation(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterPortrait(item.iconUrl),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.name, style: Theme.of(context).textTheme.titleLarge),
            if (null != item.description) Text(item.description!, style: Theme.of(context).textTheme.caption),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width - 184,
              child: Wrap(
                spacing: 24,
                runSpacing: 12,
                children: [
                  InformationRow(title: AppLocalizations.of(context)!.race, value: item.race.name),
                  InformationRow(title: AppLocalizations.of(context)!.characterAge, value: item.age?.toString()),
                  InformationRow(title: AppLocalizations.of(context)!.characterRelationship, value: item.relationship),
                  InformationRow(title: AppLocalizations.of(context)!.characterProfession, value: item.profession),
                  InformationRow(title: AppLocalizations.of(context)!.characterReligion, value: item.religion),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
