import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../admin/management/domain/attribute.dart';
import '../../../admin/management/domain/attribute_value.dart';

class AttributeValueWidget extends StatelessWidget {
  final AttributeValue value;
  final bool showTitle;

  const AttributeValueWidget(this.value, {this.showTitle = false, super.key});

  Widget _tooltip(BuildContext context, Widget child) {
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
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final icon = null != value.attribute.iconData ? deserializeIcon(json.decode(value.attribute.iconData!)) : null;

    return showTitle
        ? ListTile(
            dense: true,
            horizontalTitleGap: 0,
            minVerticalPadding: 0,
            minLeadingWidth: 28,
            contentPadding: const EdgeInsets.all(0),
            visualDensity: const VisualDensity(vertical: -4),
            title: showTitle ? _tooltip(context, Text(value.attribute.name, maxLines: 2, overflow: TextOverflow.ellipsis)) : null,
            trailing: _tooltip(context, Text(value.value.toString(), textAlign: TextAlign.right)),
            leading: _tooltip(context, FaIcon(icon ?? FontAwesomeIcons.tag, size: 20)),
          )
        : _tooltip(
            context,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(icon ?? FontAwesomeIcons.tag, size: 20),
                const SizedBox(width: 4),
                Text(value.value.toString()),
              ],
            ),
          );
  }
}
