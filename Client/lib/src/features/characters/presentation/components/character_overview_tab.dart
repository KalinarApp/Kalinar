import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/action_menu.dart';
import '../../../../utilities/async_value_extension.dart';
import '../../application/controllers/character_controller.dart';
import '../../application/controllers/character_overview_controller.dart';
import '../../domain/character_overview.dart';
import '../character_detail_screen.dart';
import 'character_list_item.dart';

class CharacterOverviewTab extends ConsumerStatefulWidget {
  final CharacterOverviewController controller;
  final List<CharacterOverview>? items;
  final bool canInteract;

  const CharacterOverviewTab({required this.controller, this.items, this.canInteract = false, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterOverviewTabState();
}

class _CharacterOverviewTabState extends ConsumerState<CharacterOverviewTab> {
  Future _onRefresh() async {
    final value = await widget.controller.getAll();
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  Future _deleteCharacter(CharacterOverview item) async {
    final value = await widget.controller.delete(item.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _openCharacterSheet(CharacterOverview item) async {
    final value = await ref.read(characterControllerProvider).get(item.id);
    if (!mounted) return;

    value.showSnackbarOnError(context);
    GoRouter.of(context).pushNamed(CharacterDetailScreen.name, params: {"id": item.id});
  }

  Future _showActionDialog(CharacterOverview item) async {
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

  @override
  void initState() {
    Future.delayed(Duration.zero, _onRefresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: widget.items?.length ?? 0,
        itemBuilder: (context, index) => CharacterListItem(
          widget.items![index],
          onTap: _openCharacterSheet,
          onLongPress: widget.canInteract ? _showActionDialog : null,
        ),
      ),
    );
  }
}
