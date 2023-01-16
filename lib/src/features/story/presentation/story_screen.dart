import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalinar/src/common_widgets/custom_image_button.dart';
import 'package:kalinar/src/common_widgets/loading_indicator.dart';
import 'package:kalinar/src/features/story/application/story_controller.dart';
import 'package:kalinar/src/features/story/presentation/components/image_carousel.dart';

import '../../../common_widgets/user_menu.dart';
import 'components/book_stack.dart';

class StoryScreen extends ConsumerStatefulWidget {
  static const name = "Story";
  static const route = "/story";

  const StoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoryScreenState();
}

class _StoryScreenState extends ConsumerState<StoryScreen> {
  final carouselController = CarouselController();

  Future _refresh() async {
    await ref.read(storyControllerProvider.notifier).refresh();
  }

  @override
  void didChangeDependencies() {
    _refresh();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storyControllerProvider);

    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu()),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: state.when(
              loading: () => const LoadingIndicator("Loading storyline..."),
              error: (error, stackTrace) => const Center(child: Text("Loading storyline failed!")),
              data: (data) {
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      ImageCarousel(data.images, controller: carouselController),
                      BookStack(data.books),
                    ],
                  ),
                );
              },
            ),
          ),
          if (Platform.isWindows)
            Positioned(top: 3, right: 3, child: CustomImageButton(icon: const FaIcon(FontAwesomeIcons.arrowsRotate), onPressed: _refresh)),
        ],
      ),
    );
  }
}
