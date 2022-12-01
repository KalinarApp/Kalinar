import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../admin/management/domain/attribute.dart';
import '../../../admin/management/domain/attribute_value.dart';

class AttributeValueWidget extends StatelessWidget {
  final AttributeValue value;
  final bool showTitle;

  const AttributeValueWidget(this.value, {this.showTitle = false, super.key});

  @override
  Widget build(BuildContext context) {
    final icon = null != value.attribute.iconData ? deserializeIcon(json.decode(value.attribute.iconData!)) : null;
    final translatedAttribute = value.attribute.translate(context);

    return JustTheTooltip(
      triggerMode: TooltipTriggerMode.tap,
      isModal: !Platform.isWindows,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20, child: Center(child: FaIcon(icon ?? FontAwesomeIcons.tag, size: 20))),
          const SizedBox(width: 10),
          if (showTitle)
            SizedBox(
              width: 100,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(value.attribute.name, maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
            ),
          if (showTitle) const SizedBox(width: 5),
          SizedBox(
            width: showTitle ? 40 : null,
            child: Align(alignment: showTitle ? Alignment.centerRight : Alignment.centerLeft, child: Text(value.value.toString())),
          ),
        ],
      ),
    );
  }
}
