import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../admin/skilltrees/domain/node.dart';
import '../attribute_value_widget.dart';

class NodeTooltip extends StatelessWidget {
  final Widget child;
  final Node node;
  final JustTheController? controller;

  const NodeTooltip(this.node, {required this.child, this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      controller: controller,
      isModal: true,
      triggerMode: TooltipTriggerMode.tap,
      elevation: 4,
      offset: 5,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              runAlignment: WrapAlignment.end,
              children: [
                Text(node.skill.name, style: Theme.of(context).textTheme.titleLarge),
                if (!node.isUnlocked)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                    child: Text("(${AppLocalizations.of(context)!.cost}: ${node.cost})"),
                  ),
              ],
            ),
            if (null != node.skill.ability)
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  "${AppLocalizations.of(context)!.newAbility}: ${node.skill.ability!.name}",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            if (null != node.skill.ability) const Divider(),
            if (null != node.skill.description && node.skill.description!.isNotEmpty) Text(node.skill.description!),
            if (node.skill.attributes.isNotEmpty) const Divider(),
            if (node.skill.attributes.isNotEmpty)
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [for (final attribute in node.skill.attributes) AttributeValueWidget(attribute)],
              )
          ],
        ),
      ),
      child: child,
    );
  }
}
