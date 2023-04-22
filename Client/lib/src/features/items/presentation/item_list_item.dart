import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../domain/item.dart';

class ItemListItem extends StatelessWidget {
  final Item item;

  const ItemListItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: item.imageUrl != null ? CachedNetworkImage(imageUrl: item.imageUrl!) : null,
      title: Text(item.title),
      subtitle: null != item.description ? Text(item.description!) : null,
    );
  }
}
