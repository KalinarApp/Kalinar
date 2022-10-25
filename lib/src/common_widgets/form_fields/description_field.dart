import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DescriptionField extends StatelessWidget {
  final String? initialValue;

  const DescriptionField({this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: "description",
      initialValue: initialValue,
      maxLines: 4,
      decoration: const InputDecoration(
        label: Text("Skill description"),
        alignLabelWithHint: true,
        prefixIconConstraints: BoxConstraints.expand(width: 48, height: 100),
        prefixIcon: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Icon(Icons.description),
          ),
        ),
      ),
    );
  }
}
