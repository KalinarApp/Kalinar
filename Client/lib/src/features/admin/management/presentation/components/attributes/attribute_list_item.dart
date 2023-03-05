import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../traits/domain/attribute.dart';

class AttributeListItem extends StatefulWidget {
  final Attribute item;
  final Function(Attribute item)? onLongPress;

  const AttributeListItem(this.item, {this.onLongPress, super.key});

  @override
  State<AttributeListItem> createState() => _AttributeListItemState();
}

class _AttributeListItemState extends State<AttributeListItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final translated = widget.item.translate(context);

    return Card(
      elevation: 4,
      child: Stack(
        children: [
          if (widget.item.isGlobal)
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [FaIcon(FontAwesomeIcons.globe, color: Theme.of(context).colorScheme.secondary, size: 14)],
                ),
              ),
            ),
          ListTile(
            onTap: () => setState(() => isExpanded = !isExpanded),
            onLongPress: null != widget.onLongPress && !translated.isGlobal ? () => widget.onLongPress!(widget.item) : null,
            leading: null != widget.item.iconData ? Icon(deserializeIcon(jsonDecode(widget.item.iconData!)), size: 48) : null,
            title: Text(translated.name, maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: null != widget.item.description && widget.item.description!.isNotEmpty
                ? Text(translated.description!, maxLines: isExpanded ? null : 3, overflow: isExpanded ? null : TextOverflow.ellipsis)
                : null,
          ),
        ],
      ),
    );
  }
}
