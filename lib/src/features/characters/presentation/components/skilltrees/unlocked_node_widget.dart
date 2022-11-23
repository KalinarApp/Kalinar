import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hero/src/features/characters/presentation/components/skilltrees/node_tooltip.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../admin/skilltrees/domain/node.dart';

class UnlockedNodeWidget extends StatefulWidget {
  final Node item;

  const UnlockedNodeWidget(this.item, {super.key});

  @override
  State<UnlockedNodeWidget> createState() => _UnlockedNodeWidgetState();
}

class _UnlockedNodeWidgetState extends State<UnlockedNodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.item.xPos,
      top: widget.item.yPos,
      child: NodeTooltip(
        widget.item,
        child: Transform.rotate(
          angle: pi / 4,
          child: Card(
            clipBehavior: Clip.hardEdge,
            color: Color(int.parse(widget.item.color)),
            child: Stack(
              children: [
                Transform.rotate(
                  angle: -pi / 4,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: null != widget.item.skill.iconUrl
                            ? Ink.image(
                                image: NetworkImage(widget.item.skill.iconUrl!),
                                fit: BoxFit.fill,
                                width: 32,
                                height: 32,
                              )
                            : const SizedBox(width: 32, height: 32),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
