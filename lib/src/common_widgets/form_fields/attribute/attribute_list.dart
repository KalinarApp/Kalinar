import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/features/admin/management/application/attribute_controller.dart';

import '../../../features/admin/management/domain/attribute.dart';
import '../../../features/admin/management/domain/attribute_value.dart';

import 'attribute_search.dart';
import 'attribute_value_range.dart';

class AttributeList extends ConsumerStatefulWidget {
  final List<AttributeValue>? value;
  final bool alwaysShowGlobal;
  final Function(List<AttributeValue>? value) onChanged;

  const AttributeList({required this.onChanged, this.alwaysShowGlobal = false, this.value, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttributeListState();
}

class _AttributeListState extends ConsumerState<AttributeList> {
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

  Future<List<AttributeValue>> _getAllGlobal() async {
    try {
      final attributes = await ref.read(attributeControllerProvider).getAllGlobal();
      return attributes.map((e) => AttributeValue(attributeId: e.id, attribute: e, value: 0)).toList();
    } catch (error) {}

    return [];
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (null != widget.value && widget.value!.isNotEmpty) {
        setState(() => attributes = [...widget.value!]);
      } else if (widget.alwaysShowGlobal) {
        final tmp = await _getAllGlobal();
        setState(() => attributes = tmp);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: attributes.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => Column(
            children: [
              AttributeValueRange(
                attributes[index],
                key: ValueKey(attributes[index].attributeId),
                onDelete: attributes[index].attribute.isGlobal && widget.alwaysShowGlobal ? null : (item) => _removeItem(item),
                onChanged: (attributeId, value) {
                  updateValue(attributeId, value);
                  widget.onChanged(attributes);
                },
              ),
              const Divider(),
            ],
          ),
        ),
        AttributeSearch(
          onSelect: (selected) {
            setState(() => attributes = [...attributes, AttributeValue(attributeId: selected.id, attribute: selected.translate(context), value: 0)]);
            widget.onChanged(attributes);
          },
          selectedAttributes: attributes.map((e) => e.attribute).toList(),
        ),
      ],
    );
  }
}
