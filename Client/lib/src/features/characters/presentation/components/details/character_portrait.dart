import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_view/photo_view.dart';

class CharacterPortrait extends StatelessWidget {
  final String? imageUrl;

  const CharacterPortrait(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final image = null == imageUrl ? null : CachedNetworkImage(imageUrl: imageUrl!);
    return OpenContainer(
      closedElevation: 4,
      closedColor: Theme.of(context).colorScheme.background,
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
        body: PhotoView(
          imageProvider: CachedNetworkImageProvider(imageUrl!),
          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
        ),
      ),
    );
  }
}
