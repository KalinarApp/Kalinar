import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/navigation/navigation_item.dart';
import 'package:hero/src/features/authentication/presentation/auth_button.dart';
import 'package:hero/src/features/skilling/presentation/abilities/ability_list.dart';

import '../../features/skilling/presentation/skills/list_skills/skill_list.dart';

class AppDrawer extends ConsumerWidget {
  final bool isAuthenticated;
  const AppDrawer({required this.isAuthenticated, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    AppLocalizations.of(context)!.applicationTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                const Spacer(),
                DropdownButton(
                  onChanged: (value) {},
                  value: "Gwynbleidd",
                  alignment: Alignment.centerRight,
                  items: const [
                    DropdownMenuItem(value: "Vind", child: Text("Vind")),
                    DropdownMenuItem(value: "Gwynbleidd", child: Text("Gwynbleidd")),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NavigationItem(title: "Character", icon: Icons.casino, route: SkillList.routeName, isVisible: isAuthenticated),
                  NavigationItem(title: "Abilities", icon: Icons.handyman, route: AbilityList.routeName, isVisible: isAuthenticated),
                  NavigationItem(title: "Skills", icon: Icons.skateboarding, route: SkillList.routeName, isVisible: isAuthenticated),
                  NavigationItem(title: "Skill tree", icon: Icons.safety_divider, route: SkillList.routeName, isVisible: isAuthenticated),
                ],
              ),
            ),
          ),
          const AuthButton(),
        ],
      ),
    );
  }
}
