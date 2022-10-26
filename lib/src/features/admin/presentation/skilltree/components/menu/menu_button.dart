import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final bool isEnabled;

  const MenuButton(this.icon, {this.isEnabled = true, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12,
      width: 12,
      child: IconButton(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        padding: const EdgeInsets.all(0),
        onPressed: isEnabled ? () => onTap() : null,
        icon: Icon(icon, size: 8),
      ),
    );
  }
}
