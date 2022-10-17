import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/async_value_list.dart';
import '../../../../utilities/async_value_extension.dart';
import '../../application/ability_controller.dart';
import '../../application/ability_list_controller.dart';
import '../../domain/ability.dart';
import 'ability_list_item.dart';
import 'create_ability_screen.dart';
import 'edit_ability_screen.dart';

class ListAbilitiesScreen extends ConsumerStatefulWidget {
  static const String name = "ListAbilities";
  static const String route = "abilities";

  const ListAbilitiesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListAbilitiesScreenState();
}

class _ListAbilitiesScreenState extends ConsumerState<ListAbilitiesScreen> {
  late final AbilityListController listController;
  late final AbilityController abilityController;

  Future<void> _refreshAbilities() async {
    await listController.getAllAbilities();
  }

  Future<void> _deleteAbility(Ability ability) async {
    final value = await abilityController.deleteAbility(ability.name);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _editAbility(Ability ability, BuildContext ctx) {
    GoRouter.of(ctx).goNamed(EditAbilityScreen.name, queryParams: {"name": ability.name});
  }

  void _createAbility() {
    GoRouter.of(context).goNamed(CreateAbilityScreen.name);
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

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: state.hasError ? null : _createAbility,
        child: const Icon(Icons.add),
      ),
      body: AsyncValueList(
        state,
        builder: (item) => AbilityListItem(item, onDelete: _deleteAbility, onTab: _editAbility),
        refreshList: _refreshAbilities,
      ),
    );
  }
}
