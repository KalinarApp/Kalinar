import 'package:flutter/material.dart';

import '../../../domain/edge.dart';
import '../../../domain/node.dart';
import 'draggable_node.dart';
import 'edge_widget.dart';
import 'gridlines.dart';
import 'menu/menu.dart';
import 'menu/menu_button.dart';

class SkilltreeStack extends StatefulWidget {
  final List<Node> nodes;
  final List<Edge> edges;
  final Function(Node node) onEditNode;
  final Function(Node node) onDeleteNode;
  final Function(Node node) onAddNodeConnection;

  final Function(Edge edge) onDeleteEdge;
  final Function(Edge edge) onSwagEdgeDirection;

  const SkilltreeStack(
    this.nodes,
    this.edges, {
    required this.onEditNode,
    required this.onDeleteNode,
    required this.onAddNodeConnection,
    required this.onDeleteEdge,
    required this.onSwagEdgeDirection,
    super.key,
  });

  @override
  State<SkilltreeStack> createState() => _SkilltreeStackState();
}

class _SkilltreeStackState extends State<SkilltreeStack> {
  Node? selectedNode;
  Edge? selectedEdge;

  void _executeAndReset(Function() action) {
    action();
    setState(() => selectedEdge = selectedNode = null);
  }

  Widget _drawNodeMenu(Node node) {
    return Menu(
      position: Offset(node.xpos + 1, node.ypos - 18),
      actions: [
        MenuButton(Icons.edit, onTap: () => _executeAndReset(() => widget.onEditNode(node))),
        MenuButton(
          Icons.delete,
          isEnabled: node.successors.isEmpty && node.precessors.isEmpty,
          onTap: () => _executeAndReset(() => widget.onDeleteNode(node)),
        ),
        MenuButton(Icons.add, onTap: () => _executeAndReset(() => widget.onAddNodeConnection(node))),
      ],
    );
  }

  Widget _drawEdgeMenu(Edge edge) {
    return Menu(
      position: Offset((edge.start.xpos + edge.end.xpos) / 2 - 4, (edge.start.ypos + edge.end.ypos) / 2 - 12),
      actions: [
        MenuButton(Icons.delete, onTap: () => _executeAndReset(() => widget.onDeleteEdge(edge))),
        MenuButton(Icons.swap_horiz, onTap: () => _executeAndReset(() => widget.onSwagEdgeDirection(edge))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Gridlines(color: Theme.of(context).backgroundColor.withOpacity(.1)),
      for (final edge in widget.edges) EdgeWidget(edge, onTap: (edge) => setState(() => selectedEdge = edge == selectedEdge ? null : edge)),
      for (final node in widget.nodes) DraggableNode(node, onTap: (node) => setState(() => selectedNode = node == selectedNode ? null : node)),
      if (null != selectedNode) _drawNodeMenu(selectedNode!),
      if (null != selectedEdge) _drawEdgeMenu(selectedEdge!),
    ]);
  }
}
