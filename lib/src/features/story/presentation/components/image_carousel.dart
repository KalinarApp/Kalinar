import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry_overview.dart';
import 'package:kalinar/src/features/story/presentation/components/story_image_preview.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarousel extends StatefulWidget {
  final List<StoryEntryOverview> images;
  final CarouselController? controller;

  const ImageCarousel(this.images, {this.controller, super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late final CarouselController controller;

  int currentPage = 0;

  @override
  void initState() {
    controller = widget.controller ?? CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: widget.images.length,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * .6,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPage = index;
                    });
                  }),
              itemBuilder: (context, index, realIndex) => StoryImagePreview(widget.images[index]),
            ),
            AnimatedSmoothIndicator(
              activeIndex: currentPage,
              count: widget.images.length,
              onDotClicked: (index) => controller.animateToPage(index),
              effect: ExpandingDotsEffect(
                radius: 12,
                dotHeight: 12,
                dotWidth: 12,
                offset: 12,
                expansionFactor: 2,
                spacing: 6,
                activeDotColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
