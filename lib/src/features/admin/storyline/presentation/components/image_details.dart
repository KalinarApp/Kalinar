import 'package:flutter/material.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry.dart';
import 'package:photo_view/photo_view.dart';

class ImageDetails extends StatelessWidget {
  final StoryEntry item;

  const ImageDetails(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: null != item.imageUrl ? NetworkImage(item.imageUrl!) : null,
      backgroundDecoration: const BoxDecoration(color: Colors.transparent),
    );
  }
}
