import 'package:flutter/material.dart';
import 'package:hero/components/builder/building_edge.dart';
import 'package:hero/components/builder/building_node.dart';
import 'package:provider/provider.dart';

import '../../models/skilltree/node.dart';
import '../../models/skilltree/nodes.dart';

class SkillTreeBuilderScreen extends StatefulWidget {
  static const routeName = "skilltree-builder";
  final int size = 101;

  const SkillTreeBuilderScreen({super.key});

  @override
  State<SkillTreeBuilderScreen> createState() => _SkillTreeBuilderScreenState();
}

class _SkillTreeBuilderScreenState extends State<SkillTreeBuilderScreen> {
  Node? firstSelectedNode;

  void _connectNodes(Node selectedNode) {
    if (null == firstSelectedNode) {
      setState(() {
        firstSelectedNode = selectedNode;
      });
    } else if (firstSelectedNode == selectedNode) {
      setState(() {
        firstSelectedNode = null;
      });
    } else if (!firstSelectedNode!.childs.contains(selectedNode.id)) {
      firstSelectedNode!.addTargetId(selectedNode.id);
      selectedNode.addParentId(firstSelectedNode!.id);

      setState(() {
        Provider.of<Nodes>(context, listen: false).createEdge(firstSelectedNode!, selectedNode);
        firstSelectedNode = null;
      });
    }
  }

  // List<Widget> _drawEdges(List<Node> nodes) {
  //   List<Widget> edges = [];

  //   for (final node in nodes) {
  //     final targetNodes = node.targetIds.map((id) => nodes.firstWhere((element) => id == element.id)).toList();
  //     for (final targetNode in targetNodes) {
  //       edges.add(BuildingEdge(start: node.position, end: targetNode.position));
  //     }
  //   }

  //   return edges;
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Nodes>(context, listen: true);
    final nodes = provider.items.map((e) => ChangeNotifierProvider.value(value: e, child: BuildingNode(e, onTab: _connectNodes))).toList();
    final edges = provider.edges.map((e) => ChangeNotifierProvider.value(value: e, child: BuildingEdge(e))).toList();

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: provider.addNode, icon: const Icon(Icons.add))],
      ),
      body: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(10),
        minScale: 0.01,
        maxScale: 5.6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 2000,
            height: 2000,
            child: Stack(
              children: [
                ...edges,
                ...nodes,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
