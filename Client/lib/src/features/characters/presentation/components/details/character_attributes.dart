import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../utilities/global_attributes.dart';
import '../../../../traits/domain/attribute_value.dart';
import '../../../domain/character.dart';
import '../attribute_value_widget.dart';

class CharacterAttributes extends StatelessWidget {
  final Character character;

  const CharacterAttributes(this.character, {super.key});

  List<AttributeValueWidget> _getGlobalAttribute(String id) {
    return [
      if (character.attributes.any((element) => element.attribute.id.toLowerCase() == id))
        AttributeValueWidget(character.attributes.firstWhere((element) => element.attribute.id.toLowerCase() == id), showTitle: true),
    ];
  }

  List<Widget> _getGroupedAttributes(List<AttributeValue> attributes, BuildContext context) {
    final grouped = groupBy(attributes, (element) => element.attribute.category);
    final keys = grouped.keys.toList()
      ..sort(
        (a, b) {
          if (a == null) return 1;
          if (b == null) return -1;
          return a.compareTo(b);
        },
      );

    List<Widget> groups = [];
    for (final key in keys) {
      final list = grouped[key]!;
      list.sortBy((element) => element.attribute.name);
      groups.add(
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("${key ?? AppLocalizations.of(context)!.attributesMore}:"),
              const SizedBox(height: 4),
              StaggeredGrid.extent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 4,
                crossAxisSpacing: 10,
                children: list.map((e) => AttributeValueWidget(e, showTitle: true)).toList(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    }

    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final globalAttributes = [
      ..._getGlobalAttribute(GlobalAttribute.health),
      ..._getGlobalAttribute(GlobalAttribute.parry),
      ..._getGlobalAttribute(GlobalAttribute.dodge),
      ..._getGlobalAttribute(GlobalAttribute.motionRange),
      ..._getGlobalAttribute(GlobalAttribute.initiative),
    ];

    final others = character.attributes.where((x) => !globalAttributes.any((y) => x.attributeId == y.value.attributeId)).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StaggeredGrid.extent(maxCrossAxisExtent: 200, mainAxisSpacing: 4, crossAxisSpacing: 10, children: globalAttributes),
        const SizedBox(height: 20),
        ..._getGroupedAttributes(others, context),
      ],
    );
  }
}
