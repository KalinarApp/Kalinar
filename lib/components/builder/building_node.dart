import 'package:flutter/material.dart';
import 'package:hero/components/builder/building_add_button.dart';

class BuildingNode extends StatefulWidget {
  final Function(BuildingNode, int) addNode;
  final Function(BuildingNode, int) addEdge;
  final Offset position;

  const BuildingNode(this.position, this.addNode, this.addEdge, {super.key});

  @override
  State<BuildingNode> createState() => _BuildingNodeState();
}

class _BuildingNodeState extends State<BuildingNode> {
  bool showAddButtons = true;

  addNode(int direction) {
    widget.addNode(widget, direction);
    setState(() {
      showAddButtons = false;
    });
  }

  addEdge(int direction) {
    widget.addEdge(widget, direction);
    setState(() {
      showAddButtons = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx,
      top: widget.position.dy,
      child: SizedBox(
        width: 42,
        height: 42,
        child: Stack(children: [
          Align(
            child: InkWell(
              onTap: () => setState(() => showAddButtons = !showAddButtons),
              child: Container(
                width: 32,
                height: 32,
                color: Colors.blue,
              ),
            ),
          ),
          if (showAddButtons) Align(alignment: Alignment.centerLeft, child: BuildingAddButton(addNode: () => addNode(1), addEdge: () => addEdge(1))),
          if (showAddButtons) Align(alignment: Alignment.topCenter, child: BuildingAddButton(addNode: () => addNode(2), addEdge: () => addEdge(2))),
          if (showAddButtons) Align(alignment: Alignment.centerRight, child: BuildingAddButton(addNode: () => addNode(3), addEdge: () => addEdge(3))),
          if (showAddButtons)
            Align(alignment: Alignment.bottomCenter, child: BuildingAddButton(addNode: () => addNode(4), addEdge: () => addEdge(4))),
        ]),
      ),
    );
  }
}
