import 'dart:math';

import 'package:flutter/material.dart';

import '../../../domain/node.dart';

class NodeWidget extends StatelessWidget {
  final Node item;
  const NodeWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: Color(int.parse(item.color)),
        child: Transform.rotate(
          angle: -pi / 4,
          child: null != item.skill.iconUrl
              ? Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Ink.image(
                    image: NetworkImage(item.skill.iconUrl!),
                    fit: BoxFit.fill,
                    width: 32,
                    height: 32,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
