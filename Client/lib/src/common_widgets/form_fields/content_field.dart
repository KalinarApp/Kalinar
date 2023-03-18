import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ContentField extends StatelessWidget {
  final String name;
  final String? label;
  final IconData? icon;
  final String? Function(String?)? validators;
  final String? initialValue;

  const ContentField(this.name, {this.label, this.icon, this.initialValue, this.validators, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      initialValue: initialValue,
      validator: validators,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
