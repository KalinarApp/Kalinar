import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DescriptionField extends StatelessWidget {
  final String? initialValue;
  final String? label;

  const DescriptionField({this.label, this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: "description",
      initialValue: initialValue,
      maxLines: 4,
      decoration: InputDecoration(
        label: null != label ? Text(label!) : null,
        alignLabelWithHint: true,
        prefixIconConstraints: const BoxConstraints.expand(width: 48, height: 100),
        prefixIcon: const Align(
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
