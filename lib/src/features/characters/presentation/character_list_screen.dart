import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'character_detail_screen.dart';

import '../../../common_widgets/action_menu.dart';
import '../../../common_widgets/async_value_grid.dart';
import '../../../common_widgets/loading_indicator.dart';
import '../../../common_widgets/user_menu.dart';
import '../../../utilities/async_value_extension.dart';
import '../application/character_controller.dart';
import '../application/character_list_controller.dart';
import '../domain/character_overview.dart';
import 'components/character_list_item.dart';
import 'character_editor_screen.dart';

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
      case DialogAction.saveAsBlueprint:
        break;
    }
  }

  Future<void> _deleteCharacter(CharacterOverview item) async {
    final value = await ref.read(characterControllerProvider).delete(item.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, _onRefresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterListControllerProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).pushNamed(CharacterEditorScreen.name),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu()),
        ],
      ),
      body: AsyncValueGrid(
        state,
        refreshList: _onRefresh,
        builder: (item) => CharacterListItem(
          item,
          onLongPress: _showActionDialog,
          onTap: (item) => GoRouter.of(context).pushNamed(CharacterDetailScreen.name, params: {"id": item.id}),
        ),
        loading: LoadingIndicator(AppLocalizations.of(context)!.fetchCharacters),
        error: Text(AppLocalizations.of(context)!.fetchCharactersFailed),
      ),
    );
  }
}
