import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common_widgets/custom_image_button.dart';
import '../../../common_widgets/loading_indicator.dart';
import '../../../common_widgets/user_menu.dart';
import '../application/story_controller.dart';
import 'components/book_stack.dart';
import 'components/image_carousel.dart';
import 'components/timeline_widget.dart';

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
              loading: () => LoadingIndicator(AppLocalizations.of(context)!.storyLoading),
              error: (error, stackTrace) => Center(child: Text(AppLocalizations.of(context)!.storyLoadingFailed)),
              data: (data) {
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: data.books.isEmpty && data.images.isEmpty && data.history.isEmpty
                      ? Center(child: Text(AppLocalizations.of(context)!.storyEmpty))
                      : CustomScrollView(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          slivers: [
                            if (data.images.isNotEmpty) ImageCarousel(data.images, controller: carouselController),
                            if (data.books.isNotEmpty) BookStack(data.books),
                            if (data.history.isNotEmpty) TimelineWidget(data.history),
                          ],
                        ),
                );
              },
            ),
          ),
          if (!kIsWeb && Platform.isWindows)
            Positioned(top: 3, right: 3, child: CustomImageButton(icon: const FaIcon(FontAwesomeIcons.arrowsRotate), onPressed: _refresh)),
        ],
      ),
    );
  }
}
