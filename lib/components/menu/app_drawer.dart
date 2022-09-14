import 'package:flutter/material.dart';
import 'package:hero/components/menu/hero_selector.dart';

import '../screens/skill_tree_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    "Hero",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                const Spacer(),
                const HeroSelector()
              ],
            ),
          ),
          ListTile(
            title: const Text("Charakterbogen"),
            leading: const CircleAvatar(
              child: Icon(Icons.accessibility),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text("Skill Baum"),
            leading: const CircleAvatar(child: Icon(Icons.share)),
            onTap: () => Navigator.pushNamed(context, SkillTreeScreen.routeName),
          ),
        ],
      ),
    );
  }
}
