import 'package:flutter/material.dart';

import '../../../domain/race.dart';

class RaceListItem extends StatelessWidget {
  final Race item;
  final Function(Race item)? onTab;
  final Function(Race item)? onLongPress;

  const RaceListItem(this.item, {this.onTab, this.onLongPress, super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: null != onTab ? () => onTab!(item) : null,
        onLongPress: null != onLongPress ? () => onLongPress!(item) : null,
        title: Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: null != item.description && item.description!.isNotEmpty ? Text(item.description!) : null,
      ),
    );
  }
}
