import 'dart:async';

import 'package:flutter/material.dart';

class CustomLongPress extends StatefulWidget {
  final Widget? child;
  final Duration duration;
  final Function()? onTap;
  final Function() onLongPress;
  final Function(bool state)? onStateChanged;

  const CustomLongPress(
      {this.child, required this.onLongPress, this.duration = const Duration(microseconds: 500), this.onTap, this.onStateChanged, super.key});

  @override
  State<CustomLongPress> createState() => _CustomLongPressState();
}

class _CustomLongPressState extends State<CustomLongPress> {
  Timer? _timer;

  void _startOperation() {
    _timer = Timer(widget.duration, widget.onLongPress);
    if (null != widget.onStateChanged) widget.onStateChanged!(true);
  }

  void _endOperation() {
    _timer?.cancel();
    if (null != widget.onStateChanged) widget.onStateChanged!(false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _startOperation(),
      onTapCancel: () => _endOperation(),
      onTapUp: (_) => _endOperation(),
      child: widget.child,
    );
  }
}
