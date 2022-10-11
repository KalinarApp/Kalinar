import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/common_widgets/async_value_list.dart';
import 'package:hero/src/utilities/async_value_extension.dart';

import '../../../domain/ability.dart';
import '../../components/abilities/ability_list_item.dart';
import '../../controllers/abilities_controller.dart';
import 'create_ability_screen.dart';

class ListAbilitiesScreen extends ConsumerStatefulWidget {
  static const String name = "ListAbilities";
  static const String route = "abilities";

  const ListAbilitiesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListAbilitiesScreenState();
}

class _ListAbilitiesScreenState extends ConsumerState<ListAbilitiesScreen> {
  late AbilitiesController controller;

  Future<void> _refreshAbilities() async {
    await controller.getAllAbilities();
  }

  Future<void> _deleteAbility(Ability ability) async {
    await controller.deleteAbility(ability.name);
  }

  void _editAbility(Ability ability, BuildContext ctx) {
    // Navigator.pushNamed(ctx, EditAbilityScreen.routeName, arguments: ability).then((value) => _refreshAbilities());
  }

  void _createAbility(BuildContext ctx) {
    GoRouter.of(context).pushNamed(CreateAbilityScreen.name); //.then((value) => setState(() => _refreshAbilities()));
  }

  @override
  void initState() {
    controller = ref.read(abilitiesControllerProvider.notifier);
    Future.delayed(const Duration(microseconds: 100), _refreshAbilities);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(abilitiesControllerProvider, (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(abilitiesControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: state.hasError ? null : () => _createAbility(context),
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
