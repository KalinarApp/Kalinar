import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../admin/skilltrees/domain/skillpoints.dart';

class SkillpointsWidget extends StatelessWidget {
  final Skillpoints skillpoints;

  const SkillpointsWidget(this.skillpoints, {super.key});

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      offset: 20,
      elevation: 4,
      triggerMode: TooltipTriggerMode.tap,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          FaIcon(
            FontAwesomeIcons.lightbulb,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 5),
          Text("${skillpoints.currentSkillpoints} / ${skillpoints.maxSkillpoints}", style: Theme.of(context).textTheme.titleLarge),
        ]),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.lightbulb,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 5),
          Text(skillpoints.currentSkillpoints.toString(), style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
