import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../icon_picker.dart';

class IconPickerField extends StatelessWidget {
  final String? initialValue;

  const IconPickerField({this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: "iconData",
      initialValue: null != initialValue ? deserializeIcon(jsonDecode(initialValue!)) : null,
      validator: FormBuilderValidators.required(),
      valueTransformer: (value) => null != value ? jsonEncode(serializeIcon(value)) : null,
      builder: (field) => IconPicker(
        initialValue: field.value,
        onChange: field.didChange,
        iconColor: field.hasError ? Colors.red : null,
      ),
    );
  }
}
