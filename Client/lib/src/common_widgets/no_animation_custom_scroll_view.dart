import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoAnimationCustomScrollView extends ConsumerWidget {
  final ScrollController? controller;
  final List<Widget> slivers;

  const NoAnimationCustomScrollView({super.key, this.controller, required this.slivers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: CustomScrollView(slivers: slivers, controller: controller));
  }
}
