import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

class InvisibleField<T> extends StatelessWidget {
  final String name;
  final T? initialValue;

  const InvisibleField({required this.name, this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<T>(
      name: name,
      initialValue: initialValue,
      builder: (field) => Container(),
    );
  }
}
