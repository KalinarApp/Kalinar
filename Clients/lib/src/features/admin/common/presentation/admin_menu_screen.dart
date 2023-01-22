import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:kalinar/src/features/admin/storyline/presentation/storyline_overview_screen.dart';

import '../../../../common_widgets/user_menu.dart';
import '../../management/presentation/management_tab_screen.dart';
import '../../skilltrees/presentation/skilltree_list_screen.dart';

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
                    icon: Icons.mail,
                    title: AppLocalizations.of(context)!.manageGroup,
                    onTab: () => GoRouter.of(context).goNamed(ManageGroupScreen.name),
                  ),
                  AdminMenuItem(
                    icon: FontAwesomeIcons.bookJournalWhills,
                    title: AppLocalizations.of(context)!.manageStoryline,
                    onTab: () => GoRouter.of(context).goNamed(StorylineOverviewScreen.name),
                  ),
                  AdminMenuItem(
                    icon: FontAwesomeIcons.bookSkull,
                    title: AppLocalizations.of(context)!.manageCharacteristics,
                    onTab: () => GoRouter.of(context).goNamed(ManagementTabScreen.name),
                  ),
                  AdminMenuItem(
                    icon: FontAwesomeIcons.circleNodes,
                    title: AppLocalizations.of(context)!.manageSkilltrees,
                    onTab: () => GoRouter.of(context).pushNamed(SkilltreeListScreen.name),
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
