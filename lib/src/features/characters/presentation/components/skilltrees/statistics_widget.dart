import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../admin/management/domain/attribute_value.dart';
import '../../../../admin/skilltrees/domain/skilltree.dart';

import 'attribute_statistic.dart';

class StatisticsWidget extends StatelessWidget {
  final Skilltree skilltree;

  const StatisticsWidget(this.skilltree, {super.key});

  List<AttributeValue> _getCurrentValue() {
    final allFromUnlocked =
        skilltree.nodes.where((element) => element.isUnlocked).map((e) => e.skill.attributes).expand((element) => element).toList();
    final unlockedGroup = groupBy(allFromUnlocked, (e) => e.attributeId);

    final List<AttributeValue> results = [];

    unlockedGroup.forEach((key, value) => results.add(AttributeValue(
        attributeId: key, attribute: value.first.attribute, value: value.fold(0, (previousValue, element) => previousValue + element.value))));

    return results;
  }

  List<AttributeValue> _combineAttributes() {
    final all = skilltree.nodes.map((e) => e.skill.attributes).expand((element) => element).toList();
    final group = groupBy(all, (attribute) => attribute.attributeId);
    final allFromUnlocked = _getCurrentValue();

    final List<AttributeValue> results = [];

    group.forEach(
      (key, value) => results.add(
        AttributeValue(
          attributeId: key,
          attribute: value.first.attribute,
          currentValue: allFromUnlocked.firstWhereOrNull((element) => element.attributeId == key)?.value ?? 0,
          value: value.fold(0, (previousValue, element) => previousValue + element.value),
        ),
      ),
    );

    return results;
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.statistics, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                for (final attribute in _combineAttributes()) AttributeStatistic(attribute),
              ],
            ),
          ),
        ),
      ),
      child: const Center(child: FaIcon(FontAwesomeIcons.arrowTrendUp)),
    );
  }
}
