import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:expandable_group/expandable_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalinar/src/features/characters/presentation/components/details/ability_filter_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../traits/application/controller/abilities_controller.dart';
import '../../../../traits/domain/ability.dart';
import '../../../domain/character.dart';

class CharacterAbilities extends ConsumerStatefulWidget {
  final Character character;
  const CharacterAbilities(this.character, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterAbilitiesState();
}

class _CharacterAbilitiesState extends ConsumerState<CharacterAbilities> {
  List<String> availableTags = [];
  List<String>? selectedTags;

  Map<String, List<Ability>> _getGroupedAbilities() {
    availableTags.sortBy((element) => removeDiacritics(element.toLowerCase()));
    final map = {
      for (var element in availableTags.where((element) => null != selectedTags ? selectedTags!.contains(element) : true))
        element: List<Ability>.empty()
    };
    for (final key in map.keys) {
      map[key] = widget.character.unlockedAbilities.where((item) => item.tags.contains(key)).toList();
    }

    return map;
  }

  List<Ability> _getAbilitiesNotInSelectedTags() {
    return widget.character.unlockedAbilities
        .where((item) => item.tags.isEmpty || !item.tags.any((tag) => selectedTags?.contains(tag) ?? true))
        .toList()
      ..sortBy((element) => removeDiacritics(element.name.toLowerCase()));
  }

  ListTile _getListItem(Ability item) {
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(item.name),
          const SizedBox(width: 5),
          Text(item.isPassive ? "Passiv" : "", style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      subtitle: null != item.description && item.description!.isNotEmpty ? Text(item.description!) : null,
      trailing: item.isPassive ? null : const IconButton(icon: FaIcon(FontAwesomeIcons.diceD20), onPressed: null),
    );
  }

  void _openFilterDialog() async {
    await showAbilityFilterDialog(context, availableTags, selectedTags, (selectedTags) {
      setState(() => this.selectedTags = selectedTags);
      _saveSelectedTags();
    });
  }

  void _saveSelectedTags() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("UserSelectedAbilityTags", selectedTags!);
  }

  void _loadSelectedTags() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTags = prefs.getStringList("UserSelectedAbilityTags");
    });
  }

  void _loadAllTags() async {
    final tags = await ref.read(abilitiesControllerProvider).filterTags(null)
      ..sortBy((element) => element);

    setState(() {
      availableTags = tags;
    });
  }

  Widget _getGroupTitle(String name, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        Text(AppLocalizations.of(context)!.abilitesCountInTag(count), style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  @override
  void initState() {
    _loadAllTags();
    _loadSelectedTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final groups = _getGroupedAbilities();
    final abilities = _getAbilitiesNotInSelectedTags();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [IconButton(icon: const FaIcon(FontAwesomeIcons.filter), onPressed: _openFilterDialog)],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ExpandableGroup(
              header: _getGroupTitle(groups.keys.elementAt(index), groups.values.elementAt(index).length),
              items: groups.values.elementAt(index).map(_getListItem).toList(),
            ),
            childCount: groups.length,
          ),
        ),
        if (abilities.isNotEmpty && groups.isNotEmpty)
          SliverToBoxAdapter(
            child: ExpandableGroup(
                header: _getGroupTitle(AppLocalizations.of(context)!.otherAbilities, abilities.length), items: abilities.map(_getListItem).toList()),
          ),
        if (groups.isEmpty)
          SliverList(delegate: SliverChildBuilderDelegate((context, index) => _getListItem(abilities[index]), childCount: abilities.length))
      ],
    );
  }
}
