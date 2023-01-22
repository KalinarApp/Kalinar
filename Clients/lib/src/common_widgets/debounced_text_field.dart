import 'dart:async';

import 'package:flutter/material.dart';

class DebouncedTextField extends StatefulWidget {
  final FutureOr<void> Function(String? currentText) onChanged;
  final String title;
  final String? initialValue;
  final Duration duration;
  final Widget? icon;

  const DebouncedTextField({
    required this.onChanged,
    this.icon,
    this.duration = const Duration(milliseconds: 400),
    this.initialValue,
    required this.title,
    super.key,
  });

  @override
  State<DebouncedTextField> createState() => _DebouncedTextFieldState();
}

class _DebouncedTextFieldState extends State<DebouncedTextField> {
  late final TextEditingController controller;
  Timer? _timer;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      onChanged: (value) {
        if (_timer?.isActive ?? false) _timer!.cancel();
        _timer = Timer(widget.duration, () => widget.onChanged(controller.text));
      },
      decoration: InputDecoration(hintText: widget.title, prefixIcon: widget.icon),
    );
  }
}
