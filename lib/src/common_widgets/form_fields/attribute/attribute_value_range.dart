import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:intl/intl.dart';

import '../../../features/admin/management/domain/attribute_value.dart';
import '../../../features/admin/management/domain/attribute.dart';

class AttributeValueRange extends StatefulWidget {
  final AttributeValue item;
  final Function(String attributeId, double value)? onChanged;
  final Function(AttributeValue item)? onDelete;

  const AttributeValueRange(this.item, {this.onChanged, this.onDelete, super.key});

  @override
  State<AttributeValueRange> createState() => _AttributeValueRangeState();
}

class _AttributeValueRangeState extends State<AttributeValueRange> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: LayoutGrid(
        areas: '''
          . icon title   close
          . icon spinner .
          . .    .       .
        ''',
        columnSizes: [4.px, auto, 4.fr, 20.px],
        rowSizes: [
          1.fr,
          2.fr,
          4.px,
        ],
        children: [
          gridArea("title").containing(Center(
              child: Text(
            widget.item.attribute.translate(context).name,
            style: Theme.of(context).textTheme.titleMedium,
          ))),
          gridArea("icon").containing(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
                child: null != widget.item.attribute.iconData
                    ? Icon(deserializeIcon(json.decode(widget.item.attribute.iconData!)), size: 28)
                    : const SizedBox(width: 28)),
          )),
          if (null != widget.onDelete)
            InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => widget.onDelete!(widget.item),
              child: const Icon(Icons.close, size: 20),
            ).inGridArea("close"),
          if (null == widget.onDelete) const SizedBox(width: 20, height: 20).inGridArea("close"),
          gridArea("spinner").containing(
            TouchSpin(
              min: widget.item.attribute.minValue,
              max: widget.item.attribute.maxValue,
              value: widget.item.value,
              displayFormat: NumberFormat.decimalPattern(),
              onChanged: (value) {
                if (null != widget.onChanged) Future.delayed(Duration.zero, () => widget.onChanged!(widget.item.attributeId, value.toDouble()));
              },
              step: widget.item.attribute.stepSize,
              addIcon: const Icon(Icons.add_circle_outline),
              subtractIcon: const Icon(Icons.remove_circle_outline),
              iconDisabledColor: Theme.of(context).disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
