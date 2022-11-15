import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BoolField extends StatelessWidget {
  final String name;
  final String label;
  final bool? initialValue;

  const BoolField({required this.name, required this.label, this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      name: name,
      decoration: const InputDecoration(border: UnderlineInputBorder()),
      activeColor: Theme.of(context).colorScheme.primary,
      title: Text(label, style: Theme.of(context).textTheme.titleMedium),
      initialValue: initialValue,
    );
  }
}
