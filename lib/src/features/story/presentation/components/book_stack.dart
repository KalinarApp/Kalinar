import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry_overview.dart';

class BookStack extends StatelessWidget {
  static const double scaleFactor = .25;

  final List<StoryEntryOverview> books;
  const BookStack(this.books, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * scaleFactor;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) => SizedBox(
              width: height * .6,
              child: Card(
                elevation: 4,
                clipBehavior: Clip.hardEdge,
                child: FancyShimmerImage(
                    imageUrl: books[index].iconUrl ?? "",
                    boxFit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                    errorWidget: Text(books[index].title, overflow: TextOverflow.ellipsis)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
