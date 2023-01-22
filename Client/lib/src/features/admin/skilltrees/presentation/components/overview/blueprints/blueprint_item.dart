import 'dart:math';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/blueprint_overview.dart';

class BlueprintItem extends StatelessWidget {
  final BlueprintOverview item;
  final Function(BlueprintOverview item)? onLongPress;
  final Function(BlueprintOverview item)? onPress;

  const BlueprintItem(this.item, {this.onLongPress, this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: null != onPress ? () => onPress!(item) : null,
        onLongPress: null != onLongPress ? () => onLongPress!(item) : null,
        title: Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Transform.rotate(angle: pi / 4, child: FaIcon(FontAwesomeIcons.square, color: Theme.of(context).colorScheme.secondary, size: 18)),
              const SizedBox(width: 5),
              Text("${item.nodeCount}"),
            ],
          ),
        ),
      ),
    );
  }
}
