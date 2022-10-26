import 'package:flutter/material.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/edge_menu_button.dart';

import '../../../domain/edge.dart';

class EdgeMenu extends StatelessWidget {
  final Edge edge;

  final Function() onDelete;
  final Function() onSwapDirection;

  const EdgeMenu(this.edge, {required this.onDelete, required this.onSwapDirection, super.key});

  @override
  Widget build(BuildContext context) {
    final position = Offset((edge.start.xpos + edge.end.xpos) / 2 - 8, (edge.start.ypos + edge.end.ypos) / 2 - 20);
    return Positioned(
      top: position.dy,
      left: position.dx,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            EdgeMenuButton(Icons.delete, onTap: () => onDelete()),
            EdgeMenuButton(Icons.swap_horiz, onTap: () => onSwapDirection()),
          ],
        ),
      ),
    );
  }
}
