import 'package:flutter/material.dart';

import '../../../domain/node.dart';

import 'editable_node.dart';
import 'node_widget.dart';

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
        feedback: NodeWidget(item),
        child: EditableNode(item, onTap: onTap),
      ),
    );
  }
}
