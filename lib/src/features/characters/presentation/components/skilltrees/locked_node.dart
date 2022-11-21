import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../admin/skilltrees/domain/node.dart';

class LockedNodeWidget extends StatelessWidget {
  final Node item;
  const LockedNodeWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: Color(int.parse(item.color)),
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: Colors.black54)),
            Transform.rotate(
              angle: -pi / 4,
              child: Stack(
                children: [
                  const Positioned.fill(child: Center(child: FaIcon(FontAwesomeIcons.lock, size: 18))),
                  if (null != item.skill.iconUrl)
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Ink.image(
                        image: NetworkImage(item.skill.iconUrl!),
                        fit: BoxFit.fill,
                        width: 32,
                        height: 32,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
