import 'package:flutter/material.dart';

class CustomImageButton extends StatelessWidget {
  final Widget icon;
  final Function()? onPressed;

  const CustomImageButton({required this.icon, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
