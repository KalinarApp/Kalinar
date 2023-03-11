import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/attribute_value.dart';

class AttributeValueRange extends StatefulWidget {
  final AttributeValue item;
  final Function(String attributeId, double value)? onChanged;
  final Function(AttributeValue item)? onDelete;

  const AttributeValueRange(this.item, {this.onChanged, this.onDelete, super.key});

  @override
  State<AttributeValueRange> createState() => _AttributeValueRangeState();
}

class _AttributeValueRangeState extends State<AttributeValueRange> {
  bool _isInteger(num value) => value is int || value == value.roundToDouble();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SpinBox(
          min: widget.item.attribute.minValue,
          max: widget.item.attribute.maxValue,
          value: widget.item.value,
          decimals: _isInteger(widget.item.attribute.stepSize) ? 0 : 1,
          step: widget.item.attribute.stepSize,
          incrementIcon: const Icon(Icons.add_circle_outline),
          decrementIcon: const Icon(Icons.remove_circle_outline),
          decoration: InputDecoration(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (null != widget.item.attribute.iconData)
                  Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8.0),
                      child: FaIcon(deserializeIcon(json.decode(widget.item.attribute.iconData!)), size: 28)),
                Text(widget.item.attribute.name),
              ],
            ),
            labelStyle: Theme.of(context).textTheme.titleLarge,
          ),
          onChanged: (value) {
            if (null != widget.onChanged) widget.onChanged!(widget.item.attributeId, value.toDouble());
          },
        ),
        if (null != widget.onDelete)
          Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () => widget.onDelete!(widget.item),
                child: const Icon(Icons.close, size: 20),
              )),
      ],
    );
  }
}
