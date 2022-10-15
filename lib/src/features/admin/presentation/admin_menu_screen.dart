import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/user_menu.dart';
import 'abilities/list_abilities_screen.dart';
import 'admin_menu_item.dart';
import 'manage_group_screen.dart';
import 'skills/list_skills_screen.dart';

class AdminMenuScreen extends StatelessWidget {
  static const String route = "/admin";

  const AdminMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: UserMenu(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(
            //   flex: 2,
            //   child: GridView(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 6, mainAxisSpacing: 6),
            //     children: const [
            //       // SelectionCard(icon: Icons.coffee, title: "home", route: "/home"),
            //       // SelectionCard(icon: Icons.coffee, title: "home", route: "/home"),
            //       // SelectionCard(icon: Icons.coffee, title: "home", route: "/home"),
            //       // SelectionCard(icon: Icons.coffee, title: "home", route: "/home"),
            //       // SelectionCard(icon: Icons.coffee, title: "home", route: "/home"),
            //       // SelectionCard(icon: Icons.coffee, title: "home", route: "/home"),
            //       // SelectionCard(icon: Icons.coffee, title: "home", route: "/home"),
            //     ],
            //   ),
            // ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  AdminMenuItem(
                    icon: Icons.mail,
                    title: "Gruppe verwalten",
                    onTab: () => GoRouter.of(context).goNamed(ManageGroupScreen.name),
                  ),
                  AdminMenuItem(
                    icon: FontAwesomeIcons.bookSkull,
                    title: "Fähigkeiten verwalten",
                    onTab: () => GoRouter.of(context).goNamed(ListAbilitiesScreen.name),
                  ),
                  AdminMenuItem(
                    icon: FontAwesomeIcons.bookSkull,
                    title: "Fertigkeiten verwalten",
                    onTab: () => GoRouter.of(context).goNamed(ListSkillsScreen.name),
                  ),
                  AdminMenuItem(
                    icon: FontAwesomeIcons.circleNodes,
                    title: "Fähigkeitenbaum verwalten",
                    onTab: () => GoRouter.of(context).push(ManageGroupScreen.route),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
