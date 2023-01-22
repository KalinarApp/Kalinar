import 'dart:math';

import 'package:flutter/material.dart';

import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:square_progress_bar/square_progress_bar.dart';

import '../../../../../common_widgets/custom_long_press.dart';
import '../../../../admin/skilltrees/domain/node.dart';

import 'node_tooltip.dart';

class UnlockableNodeWidget extends StatefulWidget {
  final Node item;
  final Function(Node item)? onUnlock;

  const UnlockableNodeWidget(this.item, {required this.onUnlock, super.key});

  @override
  State<UnlockableNodeWidget> createState() => _UnlockableNodeWidgetState();
}

class _UnlockableNodeWidgetState extends State<UnlockableNodeWidget> {
  final controller = JustTheController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.item.xPos,
      top: widget.item.yPos,
      child: NodeTooltip(
        controller: controller,
        widget.item,
        child: Transform.rotate(
          angle: pi / 4,
          child: Stack(
            children: [
              if (isLoading)
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SquareProgressBar(
                        width: 40,
                        height: 40,
                        progress: 1,
                        isAnimation: true,
                        strokeWidth: 5,
                        animationDuration: const Duration(milliseconds: 1500),
                        emptyBarColor: Colors.transparent,
                        solidBarColor: Colors.white70),
                  ),
                ),
              SizedBox(
                width: 52,
                height: 52,
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  color: Color(int.parse(widget.item.color)),
                  child: CustomLongPress(
                    onTap: () => controller.showTooltip(),
                    duration: const Duration(milliseconds: 1500),
                    onLongPress: null == widget.onUnlock ? null : () => widget.onUnlock!(widget.item),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
