import 'package:flutter/material.dart';

import '../../../domain/ability.dart';

class AbilityListItem extends StatelessWidget {
  final Ability item;
  final Function(Ability item)? onLongPress;
  final Function(Ability item)? onPress;

  const AbilityListItem(this.item, {this.onLongPress, this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: null != onPress ? () => onPress!(item) : null,
        onLongPress: null != onLongPress ? () => onLongPress!(item) : null,
        title: Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: null != item.description && item.description!.isNotEmpty ? Text(item.description!) : null,
        ),
      ),
    );
  }
}
