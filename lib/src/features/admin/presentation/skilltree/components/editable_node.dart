import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/application/skill_controller.dart';
import 'package:hero/src/features/admin/application/skilltree_controller.dart';

import '../../../domain/node.dart';

class EditableNode extends ConsumerWidget {
  final Node item;
  final Function() onLongPress;

  const EditableNode(this.item, {required this.onLongPress, super.key});

  Widget _buildNode() {
    return Transform.rotate(
      angle: pi / 4,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: Color(int.parse(item.color)),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onLongPress: onLongPress,
          child: Transform.rotate(
            angle: -pi / 4,
            child: null != item.skill.iconUrl
                ? Ink.image(
                    image: NetworkImage(item.skill.iconUrl!),
                    fit: BoxFit.fill,
                    width: 32,
                    height: 32,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      left: item.xpos,
      top: item.ypos,
      child: Draggable(
        maxSimultaneousDrags: 1,
        feedback: _buildNode(),
        child: _buildNode(),
        onDragEnd: (details) => ref.read(skilltreeControllerProvider.notifier).updateNodePosition(item, details.offset),
      ),
    );
  }
}
