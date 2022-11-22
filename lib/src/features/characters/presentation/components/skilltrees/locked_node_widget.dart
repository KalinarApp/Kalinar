import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../admin/skilltrees/domain/node.dart';

class LockedNodeWidget extends StatefulWidget {
  final Node item;

  const LockedNodeWidget(this.item, {super.key});

  @override
  State<LockedNodeWidget> createState() => _LockedNodeWidgetState();
}

class _LockedNodeWidgetState extends State<LockedNodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.item.xPos,
      top: widget.item.yPos,
      child: Transform.rotate(
        angle: pi / 4,
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
                    const Positioned.fill(
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.lock,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
