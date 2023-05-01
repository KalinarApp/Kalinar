import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/character.dart';

class SmallCharacterSheet extends StatelessWidget {
  final Character character;

  const SmallCharacterSheet(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    final image = null == character.iconUrl ? null : CachedNetworkImage(imageUrl: character.iconUrl!);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (null != image) image,
        ],
      ),
    );
  }
}
