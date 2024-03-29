import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common_widgets/action_menu.dart';
import '../../../../../utilities/async_value_extension.dart';
import '../../../../group_management/application/group_notifier.dart';
import '../../../application/controller/abilities_controller.dart';
import '../../../application/notifier/abilities_state_notifier.dart';
import '../../../application/state/filter_state.dart';
import '../../../domain/ability.dart';
import '../../../domain/suggestion_state.dart';
import '../../edit_ability_screen.dart';
import '../list_item.dart';
import '../searchable_list.dart';

class AbilitiesTab extends ConsumerStatefulWidget {
  const AbilitiesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AbilitiesTabState();
}

class _AbilitiesTabState extends ConsumerState<AbilitiesTab> {
  String? queryString;
  bool isSearchEnabled = true;
  FilterState filter = const FilterState();

  Future _onRefresh() async {
    final value = await ref.read(abilitiesControllerProvider).filter(queryString, allowedStates: filter.states);
    setState(() => isSearchEnabled = !value.hasError);

    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _editAbility(Ability ability) {
    ref.read(abilitiesControllerProvider).getById(ability.id);
    GoRouter.of(context).goNamed(EditAbilityScreen.name, queryParameters: {"id": ability.id});
  }

  Future<void> _deleteAbility(Ability ability) async {
    final value = await ref.read(abilitiesControllerProvider).delete(ability.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  Future _showActionDialog(Ability item) async {
    final actions =
        _isCreatorOrAdminOrNew(item) ? [DialogAction.edit, DialogAction.delete, DialogAction.cancel] : [DialogAction.edit, DialogAction.cancel];
    final action = await showActionsModal(context, actions: actions);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _editAbility(item);
        break;
      case DialogAction.delete:
        await _deleteAbility(item);
        break;
      default:
        break;
    }
  }

  bool _isCreatorOrAdminOrNew(Ability? item) {
    return _isAdmin() ||
        (null != item?.creator && item!.creator!.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    return FirebaseAuth.instance.currentUser?.uid == ref.read(groupNotifierProvider).group?.ownerId;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, _onRefresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(abilitiesStateNotifierProvider);

    return SearchableList(
      state,
      onRefresh: _onRefresh,
      filter: filter,
      onFilterChanged: (state) => setState(() => filter = state),
      isSearchEnabled: isSearchEnabled,
      itemBuilder: (context, index) => ListItem(
        state![index],
        onPress: _editAbility,
        onLongPress: _showActionDialog,
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final tag in state[index].tags.take(3))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).colorScheme.background),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                    child: Text(tag, style: Theme.of(context).textTheme.labelMedium),
                  ),
                ),
              ),
          ],
        ),
      ),
      onSearchChanged: (query) {
        setState(() => queryString = query);
        _onRefresh();
      },
    );
  }
}
