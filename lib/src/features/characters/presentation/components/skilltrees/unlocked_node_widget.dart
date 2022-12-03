import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../admin/skilltrees/domain/node.dart';

import 'node_tooltip.dart';

class UnlockedNodeWidget extends StatefulWidget {
  final Node item;
  final Function(Node item)? onLongPress;

  const UnlockedNodeWidget(this.item, {this.onLongPress, super.key});

  @override
  State<UnlockedNodeWidget> createState() => _UnlockedNodeWidgetState();
}

class _UnlockedNodeWidgetState extends State<UnlockedNodeWidget> {
  final controller = JustTheController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.item.xPos,
      top: widget.item.yPos,
      child: NodeTooltip(
        widget.item,
        controller: controller,
        child: Transform.rotate(
          angle: pi / 4,
          child: Card(
            clipBehavior: Clip.hardEdge,
            color: Color(int.parse(widget.item.color)),
            child: InkWell(
              onLongPress: null != widget.onLongPress ? () => widget.onLongPress!(widget.item) : null,
              onTap: () => controller.showTooltip(),
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
      ),
    );
  }
}
