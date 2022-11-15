import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hero/src/common_widgets/node_tile.dart';

import '../../../domain/node.dart';

class EditableNode extends StatelessWidget {
  final Node item;
  final Function(Node node) onTap;

  const EditableNode(this.item, {required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: SizedBox(
        width: 42,
        height: 42,
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Color(int.parse(item.color)),
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () => onTap(item),
            child: Transform.rotate(
              angle: -pi / 4,
              child: null != item.skill.iconUrl
                  ? Padding(
                      padding: const EdgeInsets.all(2),
                      child: Ink.image(
                        image: NetworkImage(item.skill.iconUrl!),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
