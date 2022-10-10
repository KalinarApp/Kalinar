import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/utilities/async_value_extension.dart';

import '../../../../admin/domain/ability.dart';
import '../controllers/ability_list_controller.dart';
import '../screens/create_ability_screen.dart';
import '../screens/edit_ability_screen.dart';
import '../../../../admin/presentation/components/abilities/ability_list_item.dart';

class AbilityList extends ConsumerStatefulWidget {
  static const String routeName = "abilities/list";

  const AbilityList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AbilityListState();
}

class _AbilityListState extends ConsumerState<AbilityList> {
  late AbilityListController controller;

  Future<void> _refreshAbilities() async {
    await controller.getAllAbilities();
  }

  Future<void> _deleteAbility(Ability ability) async {
    await controller.deleteAbility(ability.name);
  }

  void _editAbility(Ability ability, BuildContext ctx) {
    Navigator.pushNamed(ctx, EditAbilityScreen.routeName, arguments: ability).then((value) => _refreshAbilities());
  }

  @override
  void initState() {
    controller = ref.read(abilityListControllerProvider.notifier);
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
        onPressed: state.hasError
            ? null
            : () => Navigator.pushNamed(context, CreateAbilityScreen.routeName).then((value) => setState(() {
                  _refreshAbilities();
                })),
        child: const Icon(Icons.add),
      ),
      body: state.when(
        data: (data) => RefreshIndicator(
          onRefresh: _refreshAbilities,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) => AbilityListItem(
              data[index],
              onDelete: _deleteAbility,
              onTab: _editAbility,
            ),
          ),
        ),
        error: (error, stackTrace) => const Center(child: Text("An error occured while fetching the data")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
