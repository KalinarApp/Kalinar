import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CharacterPortrait extends StatelessWidget {
  final String? imageUrl;

  const CharacterPortrait(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        child: null != imageUrl ? Image.network(imageUrl!) : Center(child: Text(AppLocalizations.of(context)!.characterNoPortrait)),
      ),
    );
  }
}
