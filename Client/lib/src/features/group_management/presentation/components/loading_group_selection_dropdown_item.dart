import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class LoadingGroupSelectionDropdownItem extends StatelessWidget {
  final int delay;

  const LoadingGroupSelectionDropdownItem({super.key, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    final fadeTheme = Theme.of(context).brightness == Brightness.dark ? FadeTheme.dark : FadeTheme.light;

    return ListTile(
        title: FadeShimmer(
      width: double.infinity,
      height: Theme.of(context).textTheme.titleMedium!.fontSize!,
      fadeTheme: fadeTheme,
      millisecondsDelay: delay,
    ));
  }
}
