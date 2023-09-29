import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoAnimationSliverGrid extends ConsumerWidget {
  final SliverGridDelegate gridDelegate;
  final NullableIndexedWidgetBuilder itemBuilder;
  final ChildIndexGetter? findChildIndexCallback;
  final int? itemCount;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;

  const NoAnimationSliverGrid({
    super.key,
    required this.gridDelegate,
    required this.itemBuilder,
    this.findChildIndexCallback,
    this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: SliverGrid.builder(
        gridDelegate: gridDelegate,
        itemBuilder: itemBuilder,
        findChildIndexCallback: findChildIndexCallback,
        itemCount: itemCount,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
      ),
    );
  }
}
