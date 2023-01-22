import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../common_widgets/action_menu.dart';
import '../../../../../../common_widgets/async_value_list.dart';
import '../../../../../../utilities/async_value_extension.dart';
import '../../../application/race_controller.dart';
import '../../../application/race_list_controller.dart';
import '../../../domain/race.dart';

import 'edit_race_screen.dart';
import 'race_list_item.dart';

class RacesTab extends ConsumerStatefulWidget {
  const RacesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RacesTabState();
}

class _RacesTabState extends ConsumerState<RacesTab> {
  late final RaceListController listController;
  late final RaceController raceController;

  Future<void> _refresh() async {
    await listController.getAll();
  }

  Future<void> _showActionDialog(Race item) async {
    final action = await showActionsModal(context, actions: [DialogAction.edit, DialogAction.delete, DialogAction.cancel]);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _edit(item);
        break;
      case DialogAction.delete:
        await _delete(item);
        break;
      default:
        break;
    }
  }

  Future<void> _delete(Race item) async {
    final value = await raceController.delete(item.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _edit(Race item) {
    GoRouter.of(context).goNamed(EditRaceScreen.name, queryParams: {"id": item.id});
  }

  List<Race> _filter(List<Race> items, String? query) {
    return items = null == query || query.isEmpty
        ? items
        : items
            .where((race) =>
                race.name.toLowerCase().contains(query.toLowerCase()) || (race.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
            .toList();
  }

  @override
  void initState() {
    listController = ref.read(raceListControllerProvider.notifier);
    raceController = ref.read(raceControllerProvider);
    Future.delayed(Duration.zero, _refresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(raceListControllerProvider, (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(raceListControllerProvider);

    return AsyncValueList(
      state,
      isSearchable: true,
      queryFn: _filter,
      builder: (item) => RaceListItem(item, onTab: _edit, onLongPress: _showActionDialog),
      refreshList: _refresh,
    );
  }
}
