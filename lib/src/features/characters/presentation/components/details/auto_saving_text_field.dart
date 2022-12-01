import 'dart:async';

import 'package:flutter/material.dart';

class AutoSavingTextField extends StatefulWidget {
  final FutureOr<void> Function(String? currentText) onSaving;
  final String title;
  final String? initialValue;
  final Duration duration;
  final int minLines;
  final int maxLines;

  const AutoSavingTextField({
    required this.onSaving,
    this.duration = const Duration(milliseconds: 400),
    this.initialValue,
    this.minLines = 1,
    this.maxLines = 10,
    required this.title,
    super.key,
  });

  @override
  State<AutoSavingTextField> createState() => _AutoSavingTextFieldState();
}

class _AutoSavingTextFieldState extends State<AutoSavingTextField> {
  late final TextEditingController controller;
  Timer? _timer;
  bool isLoading = false;

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
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      onChanged: (value) {
        if (_timer?.isActive ?? false) _timer!.cancel();
        _timer = Timer(widget.duration, () async {
          setState(() => isLoading = true);
          await widget.onSaving(controller.text);
          setState(() => isLoading = false);
        });
      },
      decoration: InputDecoration(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title),
            const SizedBox(width: 4),
            if (isLoading)
              const Center(
                child: SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
