import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:intl/intl.dart';

class ValueRangeField<T extends num> extends StatelessWidget {
  final T initialValue;
  final String label;
  final T min;
  final T max;
  final T step;
  final String name;
  final NumberFormat? format;
  final Function() reset;

  const ValueRangeField(
      {required this.name,
      required this.label,
      required this.initialValue,
      required this.min,
      required this.max,
      required this.step,
      required this.reset,
      this.format,
      super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTouchSpin(
      name: name,
      decoration: InputDecoration(label: Text(label, style: Theme.of(context).textTheme.titleLarge)),
      min: min,
      max: max,
      step: step,
      initialValue: initialValue,
      displayFormat: format,
      onChanged: (_) => reset(),
      addIcon: const Icon(Icons.add_circle_outline),
      subtractIcon: const Icon(Icons.remove_circle_outline),
      iconDisabledColor: Theme.of(context).disabledColor,
      iconPadding: const EdgeInsets.all(20),
    );
  }
}
