import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:intl/intl.dart';

class ValueRangeField extends StatelessWidget {
  final double initialValue;
  final String label;
  final double min;
  final double max;
  final double step;
  final String name;
  final NumberFormat? format;

  const ValueRangeField(
      {required this.name,
      required this.label,
      required this.initialValue,
      required this.min,
      required this.max,
      required this.step,
      this.format,
      super.key});

  bool _isInteger(num value) => value is int || value == value.roundToDouble();

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name,
      initialValue: initialValue,
      builder: (field) => SpinBox(
        min: min,
        max: max,
        value: field.value ?? 0,
        decimals: _isInteger(step) ? 1 : 0,
        step: step,
        incrementIcon: const Icon(Icons.add_circle_outline),
        decrementIcon: const Icon(Icons.remove_circle_outline),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.titleLarge,
        ),
        onChanged: (value) => field.didChange(value),
      ),
    );
  }
}
