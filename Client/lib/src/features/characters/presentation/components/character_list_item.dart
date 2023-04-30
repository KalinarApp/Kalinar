import 'package:flutter/material.dart';
import 'package:kalinar/src/features/characters/domain/character_overview.dart';

class CharacterListItem extends StatelessWidget {
  final CharacterOverview item;
  final bool isSelected;
  final Function()? onTap;

  const CharacterListItem(this.item, {this.isSelected = false, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      title: Text(item.name),
      onTap: onTap,
      // leading: null != item.iconUrl ? CachedNetworkImage(imageUrl: item.iconUrl!) : null,
    );
  }
}
