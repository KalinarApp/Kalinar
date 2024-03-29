import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:expandable_group/expandable_group_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common_widgets/action_menu.dart';
import '../../../../traits/application/controller/abilities_controller.dart';
import '../../../../traits/domain/ability.dart';
import '../../../../traits/presentation/edit_ability_screen.dart';
import '../../../domain/character.dart';
import 'ability_filter_dialog.dart';
import 'ability_list_tile.dart';

class CharacterAbilities extends ConsumerStatefulWidget {
  final Character character;
  const CharacterAbilities(this.character, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterAbilitiesState();
}

class _CharacterAbilitiesState extends ConsumerState<CharacterAbilities> {
  final controller = ScrollController();

  bool isLoading = true;
  List<String> availableTags = [];
  List<String>? selectedTags;

  Map<String, List<Ability>> _getGroupedAbilities() {
    availableTags.sortBy((element) => removeDiacritics(element.toLowerCase()));
    final map = {
      for (var element in availableTags.where((element) => null != selectedTags ? selectedTags!.contains(element) : true))
        element: List<Ability>.empty()
    };
    for (final key in map.keys) {
      map[key] = widget.character.unlockedAbilities.where((item) => item.tags.contains(key)).toList()
        ..sortBy((element) => removeDiacritics(element.name.toLowerCase()));
    }

    return map;
  }

  List<Ability> _getAbilitiesNotInSelectedTags() {
    return widget.character.unlockedAbilities
        .where((item) => item.tags.isEmpty || !item.tags.any((tag) => selectedTags?.contains(tag) ?? true))
        .toList()
      ..sortBy((element) => removeDiacritics(element.name.toLowerCase()));
  }

  Future _onEdit(Ability item) async {
    ref.read(abilitiesControllerProvider).getById(item.id);
    GoRouter.of(context).pushNamed(EditAbilityScreen.name, queryParameters: {"id": item.id});
  }

  ListTile _getListItem(Ability item, {bool showTags = false}) {
    return AbilityListTile(
      item,
      context,
      showTags: showTags,
      contextBuilder: () => _buildContextMenuForWeb(item),
      onLongPress: () async {
        final action = await showActionsModal(context, actions: [DialogAction.edit, DialogAction.cancel]);
        if (null == action || !mounted) return;

        switch (action) {
          case DialogAction.edit:

          case DialogAction.delete:
          default:
            break;
        }
      },
    );
  }

  Widget? _buildContextMenuForWeb(Ability item) {
    return !kIsWeb
        ? null
        : PopupMenuButton<DialogAction>(itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: DialogAction.edit,
                onTap: () => _onEdit(item),
                child: ListTile(leading: DialogAction.edit.getIcon(), title: Text(DialogAction.edit.getTitle(context))),
              ),
            ];
          });
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
      isLoading = false;
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

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scrollbar(
                controller: controller,
                thumbVisibility: true,
                child: CustomScrollView(
                  controller: controller,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [IconButton(icon: const FaIcon(FontAwesomeIcons.filter), onPressed: _openFilterDialog), const SizedBox(width: 12)],
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
                            header: _getGroupTitle(AppLocalizations.of(context)!.otherAbilities, abilities.length),
                            items: abilities.map((item) => _getListItem(item, showTags: true)).toList()),
                      ),
                    if (groups.isEmpty)
                      SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) => _getListItem(abilities[index], showTags: true),
                              childCount: abilities.length))
                  ],
                ),
              ),
      ),
    );
  }
}
