import 'package:flutter/material.dart';

import '../../../domain/character_overview.dart';

class CharacterGridItem extends StatelessWidget {
  final CharacterOverview item;
  final Function(CharacterOverview item)? onLongPress;
  final Function(CharacterOverview item)? onTap;

  const CharacterGridItem(this.item, {this.onTap, this.onLongPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onLongPress: null != onLongPress ? () => onLongPress!(item) : null,
        onTap: null != onTap ? () => onTap!(item) : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const RadialGradient(
                    radius: 0.55,
                    center: Alignment.center,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: null != item.iconUrl
                    ? Image.network(
                        item.iconUrl!,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth,
                      )
                    : null,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Container(
                width: 150,
                color: Colors.black38,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
