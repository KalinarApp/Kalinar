import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:hero/models/skilltree/dummy_tree.dart';

import '../../models/skilltree/skill_tree.dart';

class SkillTreeView extends StatefulWidget {
  int availablePoints;

  SkillTreeView(this.availablePoints, {super.key});

  @override
  State<SkillTreeView> createState() => _SkillTreeViewState();
}

class _SkillTreeViewState extends State<SkillTreeView> {
  final Graph graph = Graph()..isTree = true;

  SugiyamaConfiguration builder = SugiyamaConfiguration();

  @override
  void initState() {
    var edges = DummyTree.tree2.edges;
    edges.forEach((element) => graph.addEdge(Node.Id(element.from), Node.Id(element.to)));

    builder
      ..nodeSeparation = (25)
      ..levelSeparation = (25)
      ..orientation = (SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM);

    super.initState();
  }

  Widget _buildRectangleNode(Skill skill) {
    return InkWell(
      onTap: () => print("clicked"),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: skill.color,
        ),
        child: Text(skill.label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Image.asset(
          "assets/skilltree_background.png",
          fit: BoxFit.fitHeight,
          height: double.infinity,
          width: double.infinity,
        ),
        Expanded(
            child: InteractiveViewer(
          constrained: false,
          boundaryMargin: const EdgeInsets.all(10),
          minScale: 0.01,
          maxScale: 5.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GraphView(
              graph: graph,
              algorithm: SugiyamaAlgorithm(builder),
              paint: Paint()
                ..color = Colors.green
                ..strokeWidth = 1
                ..style = PaintingStyle.stroke,
              builder: (Node node) {
                final id = node.key!.value as int?;
                final nodes = DummyTree.tree2.nodes;
                final skill = nodes.firstWhere((element) => element.id == id);
                return _buildRectangleNode(skill);
              },
            ),
          ),
        ))
      ],
    );
  }
}
