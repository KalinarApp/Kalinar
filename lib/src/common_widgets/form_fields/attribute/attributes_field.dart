import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../features/admin/management/domain/attribute_value.dart';

import 'attribute_list.dart';

class AttributesField extends StatelessWidget {
  final List<AttributeValue>? initialValue;

  const AttributesField({this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<AttributeValue>>(
      name: "attributes",
      initialValue: initialValue,
      builder: (field) => AttributeList(value: field.value, onChanged: (value) => field.didChange(value)),
    );
  }
}
