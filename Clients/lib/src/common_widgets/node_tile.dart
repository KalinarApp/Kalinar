import 'dart:math';

import 'package:flutter/material.dart';

class NodeTile extends StatelessWidget {
  final Image? icon;
  final Widget? placeholderWidget;
  final double? height, width;
  final String? color;
  const NodeTile(this.icon, {this.color, this.height, this.width, this.placeholderWidget, super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: null != color ? Color(int.parse(color!)) : Theme.of(context).colorScheme.background,
        child: Transform.rotate(
          angle: -pi / 4,
          child: SizedBox(
            width: width,
            height: height,
            child: null != icon ? Padding(padding: const EdgeInsets.all(6), child: icon) : placeholderWidget,
          ),
        ),
      ),
    );
  }
}
