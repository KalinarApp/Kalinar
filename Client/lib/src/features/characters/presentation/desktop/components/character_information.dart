import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/character.dart';
import '../../shared/details/information_row.dart';

class CharacterInformation extends StatelessWidget {
  final Character character;
  final double? maxHeight;

  const CharacterInformation({required this.character, this.maxHeight, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Card(
          elevation: 26,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 100, maxWidth: constraints.maxWidth, maxHeight: maxHeight ?? double.infinity),
                child: null == character.iconUrl ? null : CachedNetworkImage(imageUrl: character.iconUrl!, fit: BoxFit.fitWidth),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InformationRow(title: AppLocalizations.of(context)!.race, value: character.race.name),
                    const SizedBox(height: 6),
                    InformationRow(title: AppLocalizations.of(context)!.characterAge, value: character.age?.toString()),
                    const SizedBox(height: 6),
                    InformationRow(title: AppLocalizations.of(context)!.characterRelationship, value: character.relationship),
                    const SizedBox(height: 6),
                    InformationRow(title: AppLocalizations.of(context)!.characterProfession, value: character.profession),
                    const SizedBox(height: 6),
                    InformationRow(title: AppLocalizations.of(context)!.characterReligion, value: character.religion),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
