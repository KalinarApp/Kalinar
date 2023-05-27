import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../traits/domain/attribute.dart';
import '../../../../traits/domain/attribute_value.dart';

class AttributeStatistic extends StatelessWidget {
  final AttributeValue attribute;
  const AttributeStatistic(this.attribute, {super.key});

  @override
  Widget build(BuildContext context) {
    final translated = attribute.attribute.translate(context);
    return ListTile(
      dense: true,
      horizontalTitleGap: 5,
      minVerticalPadding: 0,
      visualDensity: const VisualDensity(vertical: -4),
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        height: double.infinity,
        constraints: const BoxConstraints(minWidth: 32, maxWidth: 32),
        child: null != attribute.attribute.iconData
            ? Align(
                alignment: Alignment.centerLeft,
                child: FaIcon(deserializeIcon(json.decode(attribute.attribute.iconData!)), size: 28),
              )
            : null,
      ),
      subtitle: Text("${attribute.currentValue} / ${attribute.value}"),
      title: Text(translated.name),
    );
  }
}
