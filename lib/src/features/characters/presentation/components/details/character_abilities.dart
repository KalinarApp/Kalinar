import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/common_widgets/debounced_text_field.dart';
import 'package:kalinar/src/features/admin/management/domain/ability.dart';
import 'package:kalinar/src/features/characters/presentation/components/details/abilities_item.dart';

import '../../../domain/character.dart';

class CharacterAbilities extends ConsumerStatefulWidget {
  final Character character;
  const CharacterAbilities(this.character, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterAbilitiesState();
}

class _CharacterAbilitiesState extends ConsumerState<CharacterAbilities> {
  List<Ability> items = [];

  void _filterAbilities(String? query) {
    setState(() => items = null == query || query.isEmpty
        ? widget.character.unlockedAbilities
        : widget.character.unlockedAbilities
            .where((ability) =>
                ability.name.toLowerCase().contains(query.toLowerCase()) ||
                (ability.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
            .toList());
  }

  @override
  void initState() {
    items = widget.character.unlockedAbilities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: DebouncedTextField(
              icon: const Icon(Icons.search),
              title: AppLocalizations.of(context)!.search,
              duration: const Duration(milliseconds: 100),
              onChanged: _filterAbilities,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => AbilitiesItem(items[index]),
          childCount: items.length,
        ))
      ],
    );
  }
}
