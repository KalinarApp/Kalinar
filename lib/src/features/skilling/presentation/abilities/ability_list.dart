import 'package:flutter/material.dart';
import 'package:hero/src/common_widgets/navigation/app_drawer.dart';
import 'package:hero/src/features/skilling/presentation/abilities/edit_ability/edit_ability_screen.dart';

import 'ability_list_item.dart';

class AbilityList extends StatelessWidget {
  static const routeName = "ability/list";

  const AbilityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, EditAbilityScreen.routeName),
        child: const Icon(Icons.add),
      ),
      body: ListView(children: const [AbilityListItem(), AbilityListItem(), AbilityListItem()]),
    );
  }
}
