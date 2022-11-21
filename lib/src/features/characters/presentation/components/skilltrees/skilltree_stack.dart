import 'package:flutter/material.dart';
import 'package:hero/src/features/admin/skilltrees/domain/node.dart';

import '../../../../admin/skilltrees/domain/edge.dart';
import '../../../../admin/skilltrees/presentation/components/nodes/edge_widget.dart';
import 'positioned_node.dart';

class SkilltreeStack extends StatelessWidget {
  final List<Node> nodes;
  final List<Edge> edges;

  const SkilltreeStack({required this.nodes, required this.edges, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      for (final edge in edges) EdgeWidget(edge),
      for (final node in nodes) PositionedNode(node),
    ]);
  }
}
