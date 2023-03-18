import 'package:collection/collection.dart';
import 'package:expandable_group/expandable_group_widget.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  List<String>? selectedTags = [];

  Map<String, List<Ability>> _getGroupedAbilities() {
    final map = {
      for (var element in availableTags.where((element) => null != selectedTags ? selectedTags!.contains(element) : true))
        element: List<Ability>.empty()
    };
    for (final key in map.keys) {
      map[key] = widget.character.unlockedAbilities.where((item) => item.tags.contains(key)).toList();
    }

    return map;

    // final groupedObjects = groupBy(
    //         widget.character.unlockedAbilities
    //             .expand((obj) => obj.tags.where((tag) => null == selectedTags ? true : selectedTags!.contains(tag)).map((tag) => MapEntry(tag, obj))),
    //         (entry) => entry.key)
    //     .entries
    //     .map((entry) => MapEntry(entry.key, entry.value.map((value) => value.value).toList()..sortBy((element) => element.name)));

    // return Map.fromEntries(groupedObjects.toList()..sort((x, y) => x.key.compareTo(y.key)));
  }

  List<Ability> _getAbilitiesNotInSelectedTags() {
    return widget.character.unlockedAbilities
        .where((item) => item.tags.isEmpty || !item.tags.any((tag) => selectedTags?.contains(tag) ?? false))
        .toList()
      ..sortBy((element) => element.name);
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
    if (!mounted) return;
    await FilterListDialog.display<String>(
      context,
      listData: availableTags,
      hideHeader: true,
      height: MediaQuery.of(context).size.height / .5,
      selectedListData: selectedTags ?? [],
      choiceChipLabel: (tag) => tag,
      validateSelectedItem: (list, val) => list?.contains(val) ?? false,
      useRootNavigator: false,
      themeData: FilterListThemeData(
        context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        controlButtonBarTheme: ControlButtonBarThemeData(
          context,
          backgroundColor: Theme.of(context).canvasColor,
          controlButtonTheme: ControlButtonThemeData(
            textStyle: Theme.of(context).textTheme.bodyLarge,
            primaryButtonBackgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        choiceChipTheme: ChoiceChipThemeData(
          backgroundColor: Theme.of(context).chipTheme.backgroundColor,
          selectedBackgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      onItemSearch: (tag, query) => tag.toLowerCase().contains(query.toLowerCase()),
      onApplyButtonClick: (list) {
        setState(() {
          selectedTags = List.from(list!);
        });
        _saveSelectedTags();
        Navigator.pop(context);
      },
    );
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
