import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:kalinar/src/features/inventory/domain/item.dart';
import 'package:kalinar/src/features/inventory/domain/weapon.dart';
import 'package:kalinar/src/features/inventory/presentation/strength_widget.dart';

class InventoryItem extends StatelessWidget {
  final Item item;

  const InventoryItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 175, maxHeight: 300),
          child: FlipCard(
            fill: Fill.fillBack,
            front: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Image(
                image: CachedNetworkImageProvider(item.imageUrl!),
                fit: BoxFit.scaleDown,
              ),
            ),
            back: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      if (item is Weapon) StrengthWidget(item as Weapon),
                      if (null != item.description && item.description!.isNotEmpty) Text(item.description!),
                    ],
                  )),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(item.title, overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
