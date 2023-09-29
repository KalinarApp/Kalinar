import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoAnimationTabBarView extends ConsumerWidget {
  final TabController? controller;
  final List<Widget> children;

  const NoAnimationTabBarView({super.key, required this.children, this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: TabBarView(controller: controller, children: children));
  }
}
