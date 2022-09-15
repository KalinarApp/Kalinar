import 'package:flutter/material.dart';
import 'package:hero/components/builder/building_node.dart';

class SkillTreeBuilderScreen extends StatefulWidget {
  static const routeName = "skilltree-builder";
  final int size = 101;

  const SkillTreeBuilderScreen({super.key});

  @override
  State<SkillTreeBuilderScreen> createState() => _SkillTreeBuilderScreenState();
}

class _SkillTreeBuilderScreenState extends State<SkillTreeBuilderScreen> {
  final int distanceBetween = 64;
  final Offset initialPosition = const Offset(100, 100);
  List<Widget> nodes = [];

  addNode(BuildingNode parent, int direction) {
    Offset offset;
    if (1 == direction) {
      offset = Offset(parent.position.dx - distanceBetween, parent.position.dy);
    } else if (2 == direction) {
      offset = Offset(parent.position.dx, parent.position.dy - distanceBetween);
    } else if (3 == direction) {
      offset = Offset(parent.position.dx + distanceBetween, parent.position.dy);
    } else {
      offset = Offset(parent.position.dx, parent.position.dy + distanceBetween);
    }

    setState(() {
      nodes.add(BuildingNode(offset, addNode, addEdge));
    });
  }

  addEdge(BuildingNode parent, int direction) {}

  @override
  void initState() {
    nodes.add(BuildingNode(initialPosition, addNode, addEdge));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              children: nodes,
            ),
          ),
        ),
      ),
    );
  }
}
