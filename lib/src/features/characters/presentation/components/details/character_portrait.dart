import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CharacterPortrait extends StatelessWidget {
  final String? imageUrl;

  const CharacterPortrait(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final image = null == imageUrl ? null : Image.network(imageUrl!);
    return OpenContainer(
      closedElevation: 4,
      closedColor: Theme.of(context).backgroundColor,
      clipBehavior: Clip.hardEdge,
      closedBuilder: (context, action) => SizedBox(
        width: 150,
        child: image ?? Center(child: Text(AppLocalizations.of(context)!.characterNoPortrait)),
      ),
      tappable: null != image,
      openBuilder: (context, action) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Image.network(
          imageUrl!,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
