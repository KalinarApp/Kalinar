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
      title: Text(label),
      initialValue: initialValue,
    );
  }
}
