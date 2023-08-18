import 'dart:math';

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class LoadingCharacterSkillItem extends StatelessWidget {
  final int delay;

  const LoadingCharacterSkillItem({this.delay = 0, super.key});

  @override
  Widget build(BuildContext context) {
    final fadeTheme = Theme.of(context).brightness == Brightness.dark ? FadeTheme.dark : FadeTheme.light;

    return LayoutBuilder(
      builder: (ctx, constraints) => ListTile(
        leading: Transform.rotate(
          angle: pi / 4,
          child: FadeShimmer(
            height: 48,
            width: 48,
            fadeTheme: fadeTheme,
            millisecondsDelay: delay,
          ),
        ),
        title: FadeShimmer(
          width: constraints.maxWidth - 75,
          height: Theme.of(context).textTheme.titleMedium!.fontSize!,
          fadeTheme: fadeTheme,
          millisecondsDelay: delay,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FadeShimmer(
            width: constraints.maxWidth - 50,
            height: Theme.of(context).textTheme.titleMedium!.fontSize! * 3,
            fadeTheme: fadeTheme,
            millisecondsDelay: delay,
          ),
        ),
      ),
    );
  }
}
