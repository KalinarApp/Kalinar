import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../admin/management/domain/attribute.dart';
import '../../../admin/management/domain/attribute_value.dart';

class AttributeValueWidget extends StatelessWidget {
  final AttributeValue value;

  const AttributeValueWidget(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    final icon = null != value.attribute.iconData ? deserializeIcon(json.decode(value.attribute.iconData!)) : null;
    final translatedAttribute = value.attribute.translate(context);

    return JustTheTooltip(
      triggerMode: TooltipTriggerMode.tap,
      isModal: true,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(translatedAttribute.name, style: Theme.of(context).textTheme.titleLarge),
            if (null != translatedAttribute.description) Text(translatedAttribute.description!),
          ],
        ),
      ),
      child: ListTile(
        dense: true,
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        minLeadingWidth: 30,
        contentPadding: const EdgeInsets.only(left: 0),
        visualDensity: const VisualDensity(vertical: -4),
        leading: FaIcon(icon ?? FontAwesomeIcons.tag, size: 20),
        title: Text(value.attribute.name),
        trailing: Text(value.value.toString()),
      ),
    );
  }
}
