import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;

  const CustomIconButton({required this.onTap, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          icon,
          color: onTap == null ? Theme.of(context).disabledColor : Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
