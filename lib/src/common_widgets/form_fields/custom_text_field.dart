import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomtextField extends StatelessWidget {
  final String name;
  final String? initialValue;
  final String? label;
  final IconData? icon;
  final TextInputAction? action;
  final String? Function(String?)? validator;

  const CustomtextField({required this.name, this.label, this.initialValue, this.icon, this.validator, this.action, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      initialValue: initialValue,
      enableSuggestions: true,
      autocorrect: true,
      validator: validator,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: action ?? TextInputAction.next,
      decoration: InputDecoration(
        label: null != label ? Text(label!) : null,
        prefixIcon: null != icon ? Icon(icon!) : null,
      ),
    );
  }
}
