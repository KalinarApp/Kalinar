import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../../kalinar_icons.dart';
import '../../../../domain/skilltree_overview.dart';

class SkilltreeItem extends StatelessWidget {
  final SkilltreeOverview item;
  final Function(SkilltreeOverview item)? onLongPress;
  final Function(SkilltreeOverview item)? onPress;
  final Function(SkilltreeOverview item, bool state)? onChangeActiveState;

  const SkilltreeItem(this.item, {this.onLongPress, this.onPress, this.onChangeActiveState, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: null != onPress ? () => onPress!(item) : null,
        onLongPress: null != onLongPress ? () => onLongPress!(item) : null,
        title: Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  const FaIcon(Kalinar.skill, size: 18),
                  const SizedBox(width: 8),
                  Text("${item.leftPoints} / ${item.points}"),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Transform.rotate(angle: pi / 4, child: FaIcon(FontAwesomeIcons.square, color: Theme.of(context).colorScheme.secondary, size: 18)),
                  const SizedBox(width: 8),
                  Text("${item.unlockedNodeCount} / ${item.nodeCount}")
                ],
              ),
            ),
          ]),
        ),
        trailing: null != item.character
            ? InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: null == onChangeActiveState ? null : () => onChangeActiveState!(item, !item.isActiveTree),
                child: Icon(
                  item.isActiveTree ? Icons.check_circle_outline_outlined : Icons.circle_outlined,
                  size: 32,
                ),
              )
            : null,
      ),
    );
  }
}
