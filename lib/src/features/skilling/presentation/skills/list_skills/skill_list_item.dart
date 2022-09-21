import 'package:flutter/material.dart';

class SkillListItem extends StatelessWidget {
  const SkillListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(
          leading: CircleAvatar(),
          title: Text("Skill I"),
          subtitle: Text("This is the super awesome description for Skill I"),
        ),
        Divider(),
      ],
    );
  }
}
