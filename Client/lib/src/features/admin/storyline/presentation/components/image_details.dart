import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../domain/story_entry.dart';

class ImageDetails extends StatelessWidget {
  final StoryEntry item;

  const ImageDetails(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: null != item.imageUrl ? CachedNetworkImageProvider(item.imageUrl!) : null,
      backgroundDecoration: const BoxDecoration(color: Colors.transparent),
    );
  }
}
