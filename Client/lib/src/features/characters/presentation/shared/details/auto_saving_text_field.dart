import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AutoSavingTextField extends HookWidget {
  final FutureOr<void> Function(String? currentText) onSaving;
  final String title;
  final String? initialValue;
  final Duration duration;
  final int? minLines;
  final int? maxLines;
  final bool enabled;
  final bool expands;
  final InputBorder? border;

  const AutoSavingTextField({
    required this.onSaving,
    this.duration = const Duration(milliseconds: 400),
    this.initialValue,
    this.minLines = 1,
    this.maxLines = 10,
    required this.title,
    this.enabled = true,
    this.expands = false,
    this.border,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue, keys: [initialValue]);
    final isLoading = useState(false);
    final ValueNotifier<Timer?> timer = useState(null);

    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      enabled: enabled,
      expands: expands,
      textAlignVertical: TextAlignVertical.top,
      onChanged: (value) {
        if (timer.value?.isActive ?? false) timer.value!.cancel();
        timer.value = Timer(duration, () async {
          isLoading.value = true;
          await onSaving(controller.text);
          isLoading.value = false;
        });
      },
      decoration: InputDecoration(
        border: border,
        alignLabelWithHint: true,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(width: 4),
            if (isLoading.value)
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
