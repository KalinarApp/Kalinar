import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hero/src/common_widgets/custom_long_press.dart';

import '../../../../admin/skilltrees/domain/node.dart';

class UnlockableNodeWidget extends StatefulWidget {
  final Node item;
  final Function(Node item) onUnlock;

  const UnlockableNodeWidget(this.item, {required this.onUnlock, super.key});

  @override
  State<UnlockableNodeWidget> createState() => _UnlockableNodeWidgetState();
}

class _UnlockableNodeWidgetState extends State<UnlockableNodeWidget> {
  bool isLoading = false;

  Widget _buildLoadingAnimation() {
    return Positioned.fill(
        child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(seconds: 2),
        builder: (context, value, _) => CircularProgressIndicator(value: value, color: Colors.white),
      ),
    ));
  }

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
          child: CustomLongPress(
            duration: const Duration(seconds: 2),
            onLongPress: () => widget.onUnlock(widget.item),
            onStateChanged: (state) => setState(() => isLoading = state),
            child: Stack(
              children: [
                Positioned.fill(child: Container(color: Colors.black54)),
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
                      if (isLoading) _buildLoadingAnimation(),
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
