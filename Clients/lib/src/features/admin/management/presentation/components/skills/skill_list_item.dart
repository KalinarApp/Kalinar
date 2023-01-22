import 'package:flutter/material.dart';

import '../../../../../../common_widgets/node_tile.dart';
import '../../../domain/skill.dart';

class SkillListItem extends StatelessWidget {
  final Skill item;
  final Function(Skill item)? onLongPress;
  final Function(Skill item)? onPress;

  const SkillListItem(this.item, {this.onLongPress, this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: null != onPress ? () => onPress!(item) : null,
        onLongPress: null != onLongPress ? () => onLongPress!(item) : null,
        leading: SizedBox(width: 40, height: 40, child: null != item.iconUrl ? NodeTile(Image.network(item.iconUrl!)) : null),
        title: Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: null != item.description && item.description!.isNotEmpty
            ? Padding(padding: const EdgeInsets.only(top: 8.0), child: Text(item.description!))
            : null,
      ),
    );
  }
}
