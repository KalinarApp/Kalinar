import 'package:flutter/material.dart';

import '../../../../admin/skilltrees/domain/node.dart';
import 'locked_node.dart';

class PositionedNode extends StatelessWidget {
  final Node node;

  const PositionedNode(this.node, {super.key});

  Widget _generateNode(Node node) {
    return LockedNodeWidget(node);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: node.xPos,
      top: node.yPos,
      child: _generateNode(node),
    );
  }
}
