import 'package:animations/animations.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../admin/storyline/domain/story_entry_overview.dart';
import 'book_widget.dart';

class BookStack extends StatelessWidget {
  static const double scaleFactor = .25;

  final List<StoryEntryOverview> books;
  const BookStack(this.books, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * scaleFactor;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.allBooks, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            SizedBox(
              height: height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                    width: height * .6,
                    child: OpenContainer(
                      closedElevation: 4,
                      closedColor: Theme.of(context).cardColor,
                      clipBehavior: Clip.hardEdge,
                      closedBuilder: (context, action) => FancyShimmerImage(
                        imageUrl: books[index].imageUrl ?? "",
                        boxFit: BoxFit.fitHeight,
                        alignment: Alignment.center,
                        errorWidget:
                            Center(child: Text(books[index].title, maxLines: 5, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis)),
                      ),
                      openBuilder: (context, action) => BookWidget(books[index].id),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
