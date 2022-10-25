import 'dart:math';

import 'package:flutter/material.dart';

import '../../../domain/node.dart';

class EditableNode extends StatelessWidget {
  final Node item;
  final Function(Node node) onTap;
  final Function({Node? node}) onLongPress;

  const EditableNode(this.item, {required this.onTap, required this.onLongPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: Color(int.parse(item.color)),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () => onTap(item),
          onLongPress: () => onLongPress(node: item),
          child: Transform.rotate(
            angle: -pi / 4,
            child: null != item.skill.iconUrl ? Ink.image(image: NetworkImage(item.skill.iconUrl!), fit: BoxFit.fill, width: 32, height: 32) : null,
          ),
        ),
      ),
    );
  }
}
