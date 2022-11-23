import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      triggerMode: TooltipTriggerMode.tap,
      isModal: true,
      elevation: 4,
      offset: 20,
      content: SizedBox(
        height: 200,
        width: 200,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.statistics, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
        ),
      ),
      child: const Center(child: FaIcon(FontAwesomeIcons.arrowTrendUp)),
    );
  }
}
