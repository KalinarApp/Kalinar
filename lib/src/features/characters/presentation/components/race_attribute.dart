import 'package:flutter/material.dart';
import 'package:hero/src/features/admin/management/domain/attribute.dart';
import 'package:hero/src/features/admin/management/domain/attribute_value.dart';

class RaceAttribute extends StatelessWidget {
  final AttributeValue item;

  const RaceAttribute(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final attribute = item.attribute.translate(context);
    return Text("${attribute.name}: ${item.value}", style: Theme.of(context).textTheme.bodyLarge);
  }
}
