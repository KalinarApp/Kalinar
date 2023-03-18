import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MultilineTextField extends StatelessWidget {
  final String name;
  final String? initialValue;
  final String? label;
  final IconData? icon;
  final int maxLines;

  const MultilineTextField({required this.name, this.maxLines = 4, this.label, this.initialValue, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      initialValue: initialValue,
      maxLines: maxLines,
      decoration: InputDecoration(
        label: null != label ? Text(label!) : null,
        alignLabelWithHint: true,
        prefixIconConstraints: BoxConstraints.expand(width: 48, height: maxLines * 23),
        prefixIcon: null != icon
            ? Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: maxLines * 2.3),
                  child: Icon(icon!),
                ),
              )
            : null,
      ),
    );
  }
}
