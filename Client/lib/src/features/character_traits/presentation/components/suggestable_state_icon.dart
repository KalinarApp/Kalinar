import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../constants/app_sizes.dart';
import '../../domain/suggestion_state.dart';

class SuggestableStateIcon extends StatelessWidget {
  final SuggestionState state;

  const SuggestableStateIcon({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      content: Padding(padding: const EdgeInsets.all(Sizes.p8), child: Text(state.getLocalization(context))),
      child: state.getIcon(context),
    );
  }
}
