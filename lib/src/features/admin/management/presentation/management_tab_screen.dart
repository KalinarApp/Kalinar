import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/features/admin/management/presentation/components/abilities/edit_ability_screen.dart';
import 'package:hero/src/features/admin/management/presentation/components/attributes/attributes_tab.dart';
import 'package:hero/src/features/admin/management/presentation/components/attributes/edit_attribute_screen.dart';
import 'package:hero/src/features/admin/management/presentation/components/skills/edit_skill_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      length: 3,
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
              label: AppLocalizations.of(context)!.attribute,
              child: const FaIcon(FontAwesomeIcons.tag),
              onTap: () => GoRouter.of(context).pushNamed(EditAttributeScreen.name),
            ),
            SpeedDialChild(
              label: AppLocalizations.of(context)!.ability,
              child: const FaIcon(FontAwesomeIcons.award),
              onTap: () => GoRouter.of(context).pushNamed(EditAbilityScreen.name),
            ),
            SpeedDialChild(
              label: AppLocalizations.of(context)!.skill,
              child: const FaIcon(FontAwesomeIcons.lightbulb),
              onTap: () => GoRouter.of(context).pushNamed(EditSkillScreen.name),
            ),
          ],
        ),
        appBar: AppBar(
          actions: const [
            Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu()),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: const FaIcon(FontAwesomeIcons.tag), text: AppLocalizations.of(context)!.attributes),
              Tab(icon: const FaIcon(FontAwesomeIcons.award), text: AppLocalizations.of(context)!.abilities),
              Tab(icon: const FaIcon(FontAwesomeIcons.lightbulb), text: AppLocalizations.of(context)!.skills),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(12.0),
          child: TabBarView(
            children: [
              AttributesTab(),
              AbilitiesTab(),
              SkillsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
