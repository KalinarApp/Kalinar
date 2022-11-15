import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hero/src/common_widgets/form_fields/attribute/attribute_list.dart';
import 'package:hero/src/features/admin/management/domain/attribute_value.dart';

class AttributesField extends StatelessWidget {
  final List<AttributeValue>? initialValue;

  const AttributesField({this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<AttributeValue>>(
      name: "attributes",
      valueTransformer: (value) => value ?? [],
      initialValue: initialValue,
      builder: (field) => AttributeList(value: field.value, onChanged: (value) => field.didChange(value)),
    );
  }
}
