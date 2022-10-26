import 'package:flutter/material.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/menu/menu_button.dart';

class Menu extends StatelessWidget {
  final Offset position;
  final List<MenuButton> actions;

  const Menu({required this.position, required this.actions, super.key});

  @override
  Widget build(BuildContext context) {
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
          children: actions,
        ),
      ),
    );
  }
}
