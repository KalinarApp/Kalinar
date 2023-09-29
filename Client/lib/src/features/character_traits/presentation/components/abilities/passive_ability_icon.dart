import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../../constants/app_sizes.dart';
import '../../../../../utils/build_context_extensions.dart';

class PassiveAbilityIcon extends StatelessWidget {
  const PassiveAbilityIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      content: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: Text(context.localizations.abilityPassiveToolTip),
      ),
      child: const Icon(Icons.shield_moon, size: Sizes.p20),
    );
  }
}
