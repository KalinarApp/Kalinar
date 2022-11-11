import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import '../../../domain/attribute.dart';

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
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: () => setState(() => isExpanded = !isExpanded),
        onLongPress: null != widget.onLongPress ? () => widget.onLongPress!(widget.item) : null,
        leading: null != widget.item.iconData ? Icon(deserializeIcon(jsonDecode(widget.item.iconData!)), size: 48) : null,
        title: Text(widget.item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: null != widget.item.description && widget.item.description!.isNotEmpty
            ? Text(widget.item.description!, maxLines: isExpanded ? null : 3, overflow: isExpanded ? null : TextOverflow.ellipsis)
            : null,
      ),
    );
  }
}
