import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../kalinar_icons.dart';
import '../../../../common_widgets/user_menu.dart';
import '../../skillpoints/presentation/skillpoints_screen.dart';
import '../../skilltrees/presentation/skilltree_list_screen.dart';
import '../../storyline/presentation/storyline_overview_screen.dart';
import 'admin_menu_item.dart';
import 'manage_group_screen.dart';

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
                    icon: Kalinar.group,
                    title: AppLocalizations.of(context)!.manageGroup,
                    onTab: () => GoRouter.of(context).goNamed(ManageGroupScreen.name),
                  ),
                  AdminMenuItem(
                    icon: Kalinar.timeline,
                    title: AppLocalizations.of(context)!.manageStoryline,
                    onTab: () => GoRouter.of(context).goNamed(StorylineOverviewScreen.name),
                  ),
                  AdminMenuItem(
                    icon: Kalinar.node,
                    title: AppLocalizations.of(context)!.manageSkilltrees,
                    onTab: () => GoRouter.of(context).pushNamed(SkilltreeListScreen.name),
                  ),
                  AdminMenuItem(
                    icon: Kalinar.skill,
                    title: AppLocalizations.of(context)!.distributeSkillpoints,
                    onTab: () => GoRouter.of(context).pushNamed(SkillpointsScreen.name),
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
