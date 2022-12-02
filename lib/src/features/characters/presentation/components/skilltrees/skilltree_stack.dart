import 'package:flutter/material.dart';

import '../../../../admin/skilltrees/domain/edge.dart';
import '../../../../admin/skilltrees/domain/node.dart';
import '../../../../admin/skilltrees/presentation/components/nodes/edge_widget.dart';

import 'locked_node_widget.dart';
import 'unlockable_node_widget.dart';
import 'unlocked_node_widget.dart';

class SkilltreeStack extends StatelessWidget {
  final List<Node> nodes;
  final List<Edge> edges;
  final Function(Node item)? onUnlockedLongPress;
  final int currentSkillpoints;
  final Function(Node node) unlockNode;

  const SkilltreeStack(
      {required this.nodes, required this.unlockNode, required this.edges, this.currentSkillpoints = 0, this.onUnlockedLongPress, super.key});

  Widget _buildNode(Node node) {
    if (node.isUnlocked) {
      return UnlockedNodeWidget(node, onLongPress: onUnlockedLongPress);
    }
    bool isUnlockable = nodes.isNodeUnlockable(node.id, currentSkillpoints);

    if (!isUnlockable) {
      return LockedNodeWidget(node);
    }

    return UnlockableNodeWidget(node, onUnlock: unlockNode);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      for (final edge in edges) EdgeWidget(edge),
      for (final node in nodes) _buildNode(node),
    ]);
  }
}
