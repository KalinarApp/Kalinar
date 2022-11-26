import 'package:flutter/material.dart';

import '../../../../../../common_widgets/node_tile.dart';
import '../../../domain/node.dart';

import 'editable_node.dart';

class DraggableNode extends StatelessWidget {
  final Node item;
  final Function(Node node) onTap;

  const DraggableNode(this.item, {required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: item.xPos,
      top: item.yPos,
      child: Draggable<Node>(
        data: item,
        maxSimultaneousDrags: 1,
        feedback: NodeTile(
          null != item.skill.iconUrl ? Image.network(item.skill.iconUrl!) : null,
          color: item.color,
          width: 32,
          height: 32,
          placeholderWidget: const SizedBox(height: 32, width: 32),
        ),
        child: EditableNode(item, onTap: onTap),
      ),
    );
  }
}
