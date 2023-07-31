import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/features/characters/presentation/shared/loading_character_skill_item.dart';

import '../../../../traits/application/controller/abilities_controller.dart';
import '../../../../traits/presentation/edit_ability_screen.dart';
import '../../../application/controllers/character_skills_controller.dart';
import '../../shared/character_skill_item.dart';

class CharacterSkillList extends HookConsumerWidget {
  final String characterId;
  final String? ownerId;

  const CharacterSkillList(this.characterId, {this.ownerId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = characterSkillsProvider(characterId);
    final skills = ref.watch(provider);
    final query = useState("");

    useEffect(() {
      Future.delayed(Duration.zero, ref.read(provider.notifier).getAll);
      return;
    }, [characterId]);

    return skills.when(
      data: (data) {
        final queryString = query.value.toLowerCase();
        final skillsWithAbilities = data.where((element) => element.ability != null).where((element) =>
            queryString.isEmpty ||
            element.ability!.name.toLowerCase().contains(queryString) ||
            (element.ability!.description?.toLowerCase().contains(queryString) ?? false));

        final favorites = skillsWithAbilities.where((item) => item.isFavorite).toList()
          ..sortBy((element) => removeDiacritics(element.ability!.name.toLowerCase()));
        final others = skillsWithAbilities.where((item) => !item.isFavorite).toList()
          ..sortBy((element) => removeDiacritics(element.ability!.name.toLowerCase()));

        final sortedSkills = [...favorites, ...others];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                onChanged: (value) => query.value = value,
                decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: AppLocalizations.of(context)!.searchForAbility),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: sortedSkills.length,
                separatorBuilder: (_, __) => const Divider(indent: 8, endIndent: 8),
                itemBuilder: (context, index) => CharacterSkillItem(
                  sortedSkills.elementAt(index),
                  ownerId: ownerId,
                  onTagSelected: (tag) {},
                  markAsFavorite: (skill, isFavorite) => ref.read(provider.notifier).updateFavorite(skill.id, isFavorite),
                  onEditAbility: (ability) {
                    ref.read(abilitiesControllerProvider).getById(ability.id);
                    context.pushNamed(EditAbilityScreen.name, queryParameters: {"id": ability.id});
                  },
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              enabled: false,
              onChanged: (value) => query.value = value,
              decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: AppLocalizations.of(context)!.searchForAbility),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 20,
              separatorBuilder: (_, __) => const Divider(indent: 8, endIndent: 8),
              itemBuilder: (context, index) => LoadingCharacterSkillItem(delay: index * 300),
            ),
          ),
        ],
      ),
    );
  }
}
