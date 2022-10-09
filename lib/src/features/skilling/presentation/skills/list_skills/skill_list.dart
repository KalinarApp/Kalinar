import 'package:flutter/material.dart';

import '../edit_skill/mobile/mobile_edit_skill_screen.dart';
import 'skill_list_item.dart';

class SkillList extends StatelessWidget {
  static const routeName = "skill/list";

  const SkillList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, MobileEditSkillScreen.routeName),
        child: const Icon(Icons.add),
      ),
      body: ListView(children: const [SkillListItem(), SkillListItem(), SkillListItem()]),
    );
  }
}
