import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/skilling/presentation/abilities/ability_list_controller.dart';
import '../../../../utilities/async_value_extension.dart';
import '../../../../common_widgets/navigation/app_drawer.dart';
import 'edit_ability/edit_ability_screen.dart';

import 'ability_list_item.dart';

class AbilityList extends ConsumerStatefulWidget {
  static const String routeName = "abilities/list";

  const AbilityList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AbilityListState();
}

class _AbilityListState extends ConsumerState<AbilityList> {
  Future<void> _refreshAbilities() async {
    await ref.read(abilityListControllerProvider.notifier).getAllAbilities();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, _refreshAbilities);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(abilityListControllerProvider, (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(abilityListControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: state.hasError ? null : () => Navigator.pushNamed(context, EditAbilityScreen.routeName),
        child: const Icon(Icons.add),
      ),
      body: state.when(
        data: (data) => RefreshIndicator(
          onRefresh: _refreshAbilities,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) => AbilityListItem(data[index]),
          ),
        ),
        error: (error, stackTrace) => const Center(child: Text("An error occured while fetching the data")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
