import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/attribute.dart';
import '../../domain/attribute_value.dart';
import 'attribute_search.dart';
import 'attribute_value_range.dart';

class AttributeList extends ConsumerWidget {
  final List<AttributeValue>? value;
  final bool alwaysShowGlobal;
  final Function(List<AttributeValue>? value) onChanged;

  const AttributeList({required this.onChanged, this.alwaysShowGlobal = false, this.value, super.key});

  void _removeItem(AttributeValue item) {
    onChanged([...(value ?? []).where((element) => item.attributeId != element.attributeId)]);
  }

  void updateValue(String attributeId, double x) {
    List<AttributeValue> list = [...value ?? []];
    final index = list.indexWhere((element) => element.attributeId == attributeId);
    list[index] = value![index].copyWith(value: x);
    onChanged(list);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemCount: value?.length ?? 0,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => Column(
            children: [
              AttributeValueRange(
                value![index],
                key: ValueKey(value![index].attributeId),
                onDelete: value![index].attribute.isGlobal && alwaysShowGlobal ? null : (item) => _removeItem(item),
                onChanged: (attributeId, x) {
                  updateValue(attributeId, x);
                },
              ),
            ],
          ),
        ),
        AttributeSearch(
          onSelect: (selected) {
            onChanged([...value ?? [], AttributeValue(attributeId: selected.id, attribute: selected.translate(context), value: 0)]);
          },
          selectedAttributes: (value ?? []).map((e) => e.attribute).toList(),
        ),
      ],
    );
  }
}
