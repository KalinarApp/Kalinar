import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/features/admin/management/presentation/edit_ability_screen.dart';
import 'package:hero/src/features/admin/management/presentation/edit_skill_screen.dart';

import '../../../../common_widgets/user_menu.dart';
import 'components/abilities/abilities_tab.dart';
import 'components/skills/skills_tab.dart';

class ManagementTabScreen extends StatelessWidget {
  static const String name = "ListSkills";
  static const String route = "management";

  const ManagementTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButton: SpeedDial(
          closeDialOnPop: true,
          icon: Icons.add,
          activeIcon: Icons.close,
          renderOverlay: false,
          spacing: 3,
          spaceBetweenChildren: 4,
          children: [
            SpeedDialChild(
              label: "Talent",
              child: const FaIcon(FontAwesomeIcons.award),
              onTap: () => GoRouter.of(context).pushNamed(EditAbilityScreen.name),
            ),
            SpeedDialChild(
              label: "Skill",
              child: const FaIcon(FontAwesomeIcons.lightbulb),
              onTap: () => GoRouter.of(context).pushNamed(EditSkillScreen.name),
            ),
          ],
        ),
        appBar: AppBar(
          actions: const [
            Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu()),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: FaIcon(FontAwesomeIcons.award), text: "Talente"),
              Tab(icon: FaIcon(FontAwesomeIcons.lightbulb), text: "Skills"),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(12.0),
          child: TabBarView(
            children: [
              AbilitiesTab(),
              SkillsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
