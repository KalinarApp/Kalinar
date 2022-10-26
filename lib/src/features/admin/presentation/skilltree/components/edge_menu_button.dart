import 'package:flutter/material.dart';

class EdgeMenuButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  const EdgeMenuButton(this.icon, {required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: IconButton(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        padding: const EdgeInsets.all(0),
        onPressed: () => onTap(),
        icon: Icon(icon, size: 16),
      ),
    );
  }
}
