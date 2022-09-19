import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/skilltree/node.dart';
import '../../models/skilltree/nodes.dart';

class BuildingNode extends StatefulWidget {
  final Node node;
  final Function(Node)? onTab;

  const BuildingNode(this.node, {this.onTab, super.key});

  @override
  State<BuildingNode> createState() => _BuildingNodeState();
}

class _BuildingNodeState extends State<BuildingNode> {
  int _getNearestSnap(int value, int gridSize) {
    int diff = gridSize - (value % gridSize);
    if (diff > gridSize / 2) return value + diff;
    return value - (value % gridSize);
  }

  Offset _getSnappedPosition(Offset newPosition, int gridSize) {
    Offset snappedValue = 
        Offset(_getNearestSnap(newPosition.dx.round(), gridSize).toDouble(), _getNearestSnap(newPosition.dy.round(), gridSize).toDouble());

    return snappedValue;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Nodes>(context);
    return Consumer<Node>(
        builder: (context, value, child) => Positioned(
              left: widget.node.position.dx - 16,
              top: widget.node.position.dy,
              child: Draggable(
                maxSimultaneousDrags: widget.node.childs.isEmpty && widget.node.parents.isEmpty ? 1 : 0,
                feedback: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: Colors.blue),
                ),
                childWhenDragging: Container(width: 32, height: 32, color: Colors.grey),
                onDragEnd: (details) => widget.node.updatePosition(_getSnappedPosition(details.offset, provider.gridSize)),
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: Stack(children: [
                    Align(
                      child: InkWell(
                        onTap: () {
                          if (null != widget.onTab) {
                            widget.onTab!(widget.node);
                          }
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(color: Colors.blue),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ));
  }
}
