import 'package:flutter/material.dart';

import '../../../features/admin/management/domain/attribute.dart';
import '../../../features/admin/management/domain/attribute_value.dart';

import 'attribute_search.dart';
import 'attribute_value_range.dart';

class AttributeList extends StatefulWidget {
  final List<AttributeValue>? value;
  final Function(List<AttributeValue>? value) onChanged;

  const AttributeList({required this.onChanged, this.value, super.key});

  @override
  State<AttributeList> createState() => _AttributeListState();
}

class _AttributeListState extends State<AttributeList> {
  List<AttributeValue> attributes = [];

  void _removeItem(AttributeValue item) {
    setState(() {
      attributes = [...attributes.where((element) => item.attributeId != element.attributeId)];
    });
    widget.onChanged(attributes);
  }

  void updateValue(String attributeId, double value) {
    final index = attributes.indexWhere((element) => element.attributeId == attributeId);
    attributes[index] = attributes[index].copyWith(value: value);
    setState(() => attributes = [...attributes]);
  }

  @override
  void initState() {
    attributes = [...widget.value ?? []];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    attributes.globalFirst();
    return Column(
      children: [
        for (final attribute in attributes)
          Column(
            children: [
              AttributeValueRange(
                attribute,
                key: ValueKey(attribute.attributeId),
                onDelete: (item) => _removeItem(item),
                onChanged: (attributeId, value) {
                  updateValue(attributeId, value);
                  widget.onChanged(attributes);
                },
              ),
              const Divider(),
            ],
          ),
        AttributeSearch(
          onSelect: (selected) {
            setState(() => attributes = [
                  ...attributes,
                  AttributeValue(attributeId: selected.id, attribute: selected.translate(context), value: selected.minValue)
                ]);
            widget.onChanged(attributes);
          },
          selectedAttributes: attributes.map((e) => e.attribute).toList(),
        ),
      ],
    );
  }
}
