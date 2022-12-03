import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../admin/management/domain/ability.dart';
import '../../../../admin/management/domain/attribute_value.dart';
import '../../../../admin/skilltrees/domain/node.dart';
import '../attribute_value_widget.dart';

class NodeTooltip extends StatelessWidget {
  final Widget child;
  final Node node;
  final JustTheController? controller;

  const NodeTooltip(this.node, {required this.child, this.controller, super.key});

  Widget _buildTitle(BuildContext context) {
    return Wrap(
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
    );
  }

  Widget _buildAbilityDescription(BuildContext context, Ability ability) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Text("${AppLocalizations.of(context)!.newAbility}: ${ability.name}", style: Theme.of(context).textTheme.caption),
        const SizedBox(height: 4),
        if (null != ability.description && ability.description!.isNotEmpty) Text(ability.description!, style: Theme.of(context).textTheme.caption),
      ],
    );
  }

  Widget _buildAttributes(List<AttributeValue> attributes) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Wrap(
          runSpacing: 4,
          spacing: 10,
          children: [for (final attribute in attributes) AttributeValueWidget(attribute)],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      controller: controller,
      isModal: !Platform.isWindows,
      triggerMode: TooltipTriggerMode.tap,
      elevation: 4,
      offset: 5,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitle(context),
              if (null != node.skill.description && node.skill.description!.isNotEmpty) Text(node.skill.description!),
              if (null != node.skill.ability) _buildAbilityDescription(context, node.skill.ability!),
              if (node.skill.attributes.isNotEmpty) _buildAttributes(node.skill.attributes),
            ],
          ),
        ),
      ),
      child: child,
    );
  }
}
