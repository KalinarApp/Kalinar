import 'package:flutter/material.dart';
import 'package:hero/src/features/admin/domain/skill.dart';

class SkillListItem extends StatelessWidget {
  final Skill item;

  const SkillListItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: null != item.iconUrl ? CircleAvatar(backgroundImage: NetworkImage(item.iconUrl!)) : null,
          title: Text(item.name),
          subtitle: Text(item.description),
        ),
        const Divider(),
      ],
    );
  }
}
