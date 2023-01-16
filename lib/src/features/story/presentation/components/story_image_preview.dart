import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry_overview.dart';
import 'package:photo_view/photo_view.dart';

class StoryImagePreview extends StatelessWidget {
  final StoryEntryOverview item;

  const StoryImagePreview(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * .6;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(item.title, maxLines: 2, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 15),
          SizedBox(
            height: height * .6,
            width: double.infinity,
            child: OpenContainer(
              closedElevation: 4,
              closedColor: Theme.of(context).cardColor,
              closedShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
              clipBehavior: Clip.hardEdge,
              closedBuilder: (context, action) => FancyShimmerImage(
                imageUrl: item.imageUrl!,
                boxFit: BoxFit.fitWidth,
              ),
              openBuilder: (context, action) => Scaffold(
                appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PhotoView(
                    imageProvider: CachedNetworkImageProvider(item.imageUrl!),
                    backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          if (null != item.description) Text(item.description!, maxLines: 4)
        ],
      ),
    );
  }
}
