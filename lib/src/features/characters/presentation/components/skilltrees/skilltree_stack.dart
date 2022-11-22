import 'package:flutter/material.dart';
import 'package:hero/src/features/admin/skilltrees/domain/node.dart';
import 'package:hero/src/features/characters/presentation/components/skilltrees/locked_node_widget.dart';
import 'package:hero/src/features/characters/presentation/components/skilltrees/unlockable_node_widget.dart';

import '../../../../admin/skilltrees/domain/edge.dart';
import '../../../../admin/skilltrees/presentation/components/nodes/edge_widget.dart';
import 'unlocked_node_widget.dart';

class SkilltreeStack extends StatelessWidget {
  final List<Node> nodes;
  final List<Edge> edges;
  final Function(Node node) unlockNode;

  const SkilltreeStack({required this.nodes, required this.unlockNode, required this.edges, super.key});

  Widget _buildNode(Node node) {
    if (!nodes.isNodeUnlockable(node.id) && !node.isUnlocked) {
      return LockedNodeWidget(node);
    } else if (!node.isUnlocked) {
      return UnlockableNodeWidget(node, onUnlock: unlockNode);
    }
    return UnlockedNodeWidget(node);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      for (final edge in edges) EdgeWidget(edge),
      for (final node in nodes) _buildNode(node),
    ]);
  }
}
