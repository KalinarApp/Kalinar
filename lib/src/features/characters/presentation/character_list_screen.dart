import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/action_menu.dart';
import '../../../common_widgets/async_value_grid.dart';
import '../../../common_widgets/loading_indicator.dart';
import '../../../common_widgets/user_menu.dart';
import '../../../utilities/async_value_extension.dart';
import '../../../utilities/router/routes.dart';
import '../application/character_controller.dart';
import '../application/character_list_controller.dart';
import '../domain/character_overview.dart';

import 'character_detail_screen.dart';
import 'character_editor_screen.dart';
import 'components/character_list_item.dart';
import 'components/details/character_tab.dart';

class CharacterListScreen extends ConsumerStatefulWidget {
  static const String name = "CharacterList";
  static const String route = "/characters";

  const CharacterListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CharacterListScreenState();
}

class CharacterListScreenState extends ConsumerState<CharacterListScreen> {
  Future<void> _onRefresh() async {
    await ref.read(characterListControllerProvider.notifier).getAll();
  }

  Future<void> _showActionDialog(CharacterOverview item) async {
    final action = await showActionsModal(context, actions: [DialogAction.delete, DialogAction.cancel]);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.delete:
        await _deleteCharacter(item);
        break;
      case DialogAction.edit:
      case DialogAction.cancel:
      case DialogAction.loadAsNewSkilltree:
      case DialogAction.reset:
      case DialogAction.resetDisabled:
      case DialogAction.saveAsBlueprint:
        break;
    }
  }

  Future<void> _deleteCharacter(CharacterOverview item) async {
    final value = await ref.read(characterControllerProvider.notifier).delete(item.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  Widget _buildTab(AsyncValue<List<CharacterOverview>> items, List<CharacterOverview> Function(List<CharacterOverview>) filter) {
    return AsyncValueGrid(
      items,
      filter: filter,
      delegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, crossAxisSpacing: 10, mainAxisSpacing: 10),
      refreshList: _onRefresh,
      builder: (item) => CharacterListItem(
        item,
        onLongPress: _showActionDialog,
        onTap: (item) => GoRouter.of(context).pushNamed(CharacterDetailScreen.name, params: {"id": item.id}),
      ),
      loading: LoadingIndicator(AppLocalizations.of(context)!.fetchCharacters),
      error: Text(AppLocalizations.of(context)!.fetchCharactersFailed),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, _onRefresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userChangedProvider);
    final state = ref.watch(characterListControllerProvider);

    final tabs = [
      if (state.hasValue && null != user?.id && state.value!.any((element) => element.userId == user!.id))
        CharacterTab(
          text: AppLocalizations.of(context)!.ownCharacters,
          tab: _buildTab(state, (list) => list.where((element) => element.userId == user?.id).toList()),
        ),
      if (state.hasValue && null != user?.id && state.value!.any((element) => element.userId != user!.id))
        CharacterTab(
          text: AppLocalizations.of(context)!.otherCharacters,
          tab: _buildTab(state, (list) => list.where((element) => element.userId != user?.id).toList()),
        ),
      if (state.isLoading) CharacterTab(text: "", tab: _buildTab(state, (p0) => [])),
      if (state.hasValue && state.value!.isEmpty) CharacterTab(text: "", tab: _buildTab(state, (p0) => [])),
      if (state.hasError) CharacterTab(text: "", tab: _buildTab(state, (p0) => []))
    ];

    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButton: !state.hasError
            ? FloatingActionButton(
                onPressed: () => GoRouter.of(context).pushNamed(CharacterEditorScreen.name),
                child: const Icon(Icons.add),
              )
            : null,
        appBar: AppBar(
          actions: const [
            Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu()),
          ],
          bottom: 1 < tabs.length ? TabBar(tabs: tabs) : null,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: 1 < tabs.length ? TabBarView(children: [...tabs.map((e) => e.tab)]) : tabs.first.tab,
        ),
      ),
    );
  }
}
