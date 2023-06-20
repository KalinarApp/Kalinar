import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../admin/skilltrees/domain/node.dart';
import 'node_lock.dart';
import 'node_tooltip.dart';

class LockedNodeWidget extends StatefulWidget {
  final Node item;
  final Function(Node item)? onLongPress;

  const LockedNodeWidget(this.item, {this.onLongPress, super.key});

  @override
  State<LockedNodeWidget> createState() => _LockedNodeWidgetState();
}

class _LockedNodeWidgetState extends State<LockedNodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.item.xPos,
      top: widget.item.yPos,
      child: NodeTooltip(
        widget.item,
        child: Transform.rotate(
          angle: pi / 4,
          child: GestureDetector(
            onLongPress: null != widget.onLongPress ? () => widget.onLongPress!(widget.item) : null,
            child: Card(
              clipBehavior: Clip.hardEdge,
              color: Color(int.parse(widget.item.color)),
              child: Stack(
                children: [
                  Positioned.fill(child: Container(color: Colors.black54)),
                  Transform.rotate(
                    angle: -pi / 4,
                    child: Stack(
                      children: [
                        Positioned.fill(child: NodeLock(widget.item.cost)),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: null != widget.item.skill.iconUrl
                              ? Ink.image(image: CachedNetworkImageProvider(widget.item.skill.iconUrl!), fit: BoxFit.fill, width: 32, height: 32)
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
