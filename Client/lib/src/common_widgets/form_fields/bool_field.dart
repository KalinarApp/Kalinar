import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../shimmer_widget.dart';

class BoolField extends StatelessWidget {
  final String name;
  final String label;
  final bool? initialValue;
  final bool isLoading;
  final bool readOnly;
  final void Function(bool? value)? onChanged;

  const BoolField(
      {required this.name, required this.label, this.initialValue, this.isLoading = false, this.readOnly = false, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ShimmerWidget.rectangular(height: 36)
        : FormBuilderCheckbox(
            name: name,
            enabled: !readOnly,
            valueTransformer: (value) => value ?? false,
            decoration: const InputDecoration(border: UnderlineInputBorder()),
            activeColor: Theme.of(context).colorScheme.primary,
            title: Text(label, style: Theme.of(context).textTheme.titleMedium),
            initialValue: initialValue,
            onChanged: onChanged,
          );
  }
}
