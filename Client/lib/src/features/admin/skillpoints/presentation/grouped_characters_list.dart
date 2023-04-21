import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/sliver_grouped_list.dart';

import '../../../characters/domain/character_overview.dart';
import 'character_skilltrees_list.dart';

class GroupedCharactersList extends StatelessWidget {
  final List<CharacterOverview> characters;
  final ScrollController? scrollController;

  const GroupedCharactersList({required this.characters, this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    characters.sortBy((element) => removeDiacritics(element.name.toLowerCase()));

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            sliver: SliverGroupedListView(
              elements: characters,
              groupBy: (element) => element.name,
              groupSeparatorBuilder: (String value) => Text(value, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
              itemBuilder: (context, element) =>
                  Padding(padding: const EdgeInsets.all(12.0), child: CharacterSkilltreesList(character: element, controller: scrollController)),
            ),
          ),
        ],
      ),
    );
  }
}
