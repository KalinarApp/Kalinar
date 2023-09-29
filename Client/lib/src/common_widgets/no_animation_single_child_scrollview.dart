import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoAnimationSingleChildScrollView extends ConsumerWidget {
  final Widget child;

  const NoAnimationSingleChildScrollView({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(child: child));
  }
}
