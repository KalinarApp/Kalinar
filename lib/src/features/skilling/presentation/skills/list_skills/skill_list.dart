import 'package:flutter/material.dart';
import 'package:hero/src/common_widgets/navigation/app_drawer.dart';
import 'package:hero/src/features/skilling/presentation/skills/list_skills/skill_list_item.dart';

import '../edit_skill/mobile/mobile_edit_skill_screen.dart';

class SkillList extends StatelessWidget {
  static const routeName = "skill/list";

  const SkillList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(isAuthenticated: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, MobileEditSkillScreen.routeName),
        child: const Icon(Icons.add),
      ),
      body: ListView(children: const [SkillListItem(), SkillListItem(), SkillListItem()]),
    );
  }
}
