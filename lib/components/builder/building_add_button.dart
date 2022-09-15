import 'package:flutter/material.dart';

class BuildingAddButton extends StatelessWidget {
  final Function()? addNode;
  final Function()? addEdge;

  const BuildingAddButton({this.addNode, this.addEdge, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 6,
      child: InkWell(
        onTap: addNode,
        onLongPress: addEdge,
        child: const Icon(Icons.add, size: 12),
      ),
    );
  }
}
