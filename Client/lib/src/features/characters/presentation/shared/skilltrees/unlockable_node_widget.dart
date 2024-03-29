import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:square_progress_bar/square_progress_bar.dart';

import '../../../../../common_widgets/custom_long_press.dart';
import '../../../../admin/skilltrees/domain/node.dart';
import 'node_tooltip.dart';

class UnlockableNodeWidget extends StatefulWidget {
  final Node item;
  final Function(Node item)? onUnlock;
  final Function(Node item)? onLongPress;

  const UnlockableNodeWidget(this.item, {required this.onUnlock, this.onLongPress, super.key});

  @override
  State<UnlockableNodeWidget> createState() => _UnlockableNodeWidgetState();
}

class _UnlockableNodeWidgetState extends State<UnlockableNodeWidget> {
  final controller = JustTheController();
  bool isLoading = false;

  Widget _buildNote() {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: Colors.black54)),
        Transform.rotate(
          angle: -pi / 4,
          child: Stack(
            children: [
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
    );
  }

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
                        solidBarColor: Theme.of(context).colorScheme.background),
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
                      onLongPress: null != widget.onUnlock ? () => widget.onUnlock!(widget.item) : null,
                      onStateChanged: (state) => setState(() => isLoading = state),
                      child: _buildNote(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
