import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../admin/skilltrees/domain/node.dart';

class NodeTooltip extends StatelessWidget {
  final Widget child;
  final Node node;
  final JustTheController? controller;

  const NodeTooltip(this.node, {required this.child, this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      controller: controller,
      isModal: true,
      triggerMode: TooltipTriggerMode.tap,
      elevation: 4,
      offset: 5,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(node.skill.name, style: Theme.of(context).textTheme.titleLarge),
                if (!node.isUnlocked) const SizedBox(width: 4),
                if (!node.isUnlocked) Text("(${node.cost})")
              ],
            ),
            if (null != node.skill.description && node.skill.description!.isNotEmpty) Text(node.skill.description!),
          ],
        ),
      ),
      child: child,
    );
  }
}
