import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/traits/presentation/edit_race_screen.dart';

import '../../../../../common_widgets/action_menu.dart';
import '../../../../../utilities/async_value_extension.dart';
import '../../../../group_management/application/group_notifier.dart';
import '../../../application/controller/races_controller.dart';
import '../../../application/notifier/races_state_notifier.dart';
import '../../../domain/race.dart';
import '../../../domain/suggestion_state.dart';
import '../list_item.dart';
import '../searchable_list.dart';

class RacesTab extends ConsumerStatefulWidget {
  const RacesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => RacesTabState();
}

class RacesTabState extends ConsumerState<RacesTab> {
  String? queryString;
  bool isSearchEnabled = true;

  Future _onRefresh() async {
    final value = await ref.read(racesControllerProvider).filter(queryString);
    setState(() => isSearchEnabled = !value.hasError);

    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _editRace(Race item) {
    ref.read(racesControllerProvider).getById(item.id);
    GoRouter.of(context).goNamed(EditRaceScreen.name, queryParams: {"id": item.id});
  }

  Future<void> _deleteRace(Race item) async {
    final value = await ref.read(racesControllerProvider).delete(item.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  Future _showActionDialog(Race item) async {
    final actions =
        _isCreatorOrAdminOrNew(item) ? [DialogAction.edit, DialogAction.delete, DialogAction.cancel] : [DialogAction.edit, DialogAction.cancel];
    final action = await showActionsModal(context, actions: actions);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _editRace(item);
        break;
      case DialogAction.delete:
        await _deleteRace(item);
        break;
      default:
        break;
    }
  }

  bool _isCreatorOrAdminOrNew(Race? item) {
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
    final state = ref.watch(racesStateNotifierProvider);

    return SearchableList(
      state,
      onRefresh: _onRefresh,
      isSearchEnabled: isSearchEnabled,
      itemBuilder: (context, index) => ListItem(
        state![index],
        onPress: _editRace,
        onLongPress: _showActionDialog,
      ),
      onSearchChanged: (query) {
        setState(() => queryString = query);
        _onRefresh();
      },
    );
  }
}
