import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../common_widgets/action_menu.dart';
import '../../../../../../common_widgets/async_value_list.dart';
import '../../../../../../utilities/async_value_extension.dart';
import '../../../application/ability_controller.dart';
import '../../../application/ability_list_controller.dart';
import '../../../domain/ability.dart';
import '../../edit_ability_screen.dart';
import 'ability_list_item.dart';

class AbilitiesTab extends ConsumerStatefulWidget {
  const AbilitiesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AbilitiesTabState();
}

class _AbilitiesTabState extends ConsumerState<AbilitiesTab> {
  late final AbilityListController listController;
  late final AbilityController abilityController;

  Future<void> _refreshAbilities() async {
    await listController.getAllAbilities();
  }

  Future<void> _showActionDialog(Ability item) async {
    final action = await showActionsModal(context);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _editAbility(item);
        break;
      case DialogAction.delete:
        await _deleteAbility(item);
        break;
      case DialogAction.cancel:
        break;
    }
  }

  Future<void> _deleteAbility(Ability ability) async {
    final value = await abilityController.deleteAbility(ability.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _editAbility(Ability ability) {
    GoRouter.of(context).goNamed(EditAbilityScreen.name, queryParams: {"id": ability.id});
  }

  @override
  void initState() {
    listController = ref.read(abilityListControllerProvider.notifier);
    abilityController = ref.read(abilityControllerProvider);
    Future.delayed(const Duration(microseconds: 100), _refreshAbilities);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(abilityListControllerProvider, (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(abilityListControllerProvider);

    return AsyncValueList(
      state,
      builder: (item) => AbilityListItem(
        item,
        onLongPress: _showActionDialog,
        onPress: _editAbility,
      ),
      refreshList: _refreshAbilities,
    );
  }
}