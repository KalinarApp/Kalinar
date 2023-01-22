import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTab;

  const AdminMenuItem({required this.icon, required this.title, required this.onTab, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: ListTile(
        leading: FaIcon(icon),
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
