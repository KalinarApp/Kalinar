import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../utilities/global_attributes.dart';
import '../../../../admin/management/domain/attribute_value.dart';
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

  List<Widget> _getGroupedAttributes(List<AttributeValue> attributes) {
    final grouped = groupBy(attributes, (element) => element.attribute.category);
    List<Widget> groups = [];
    for (final key in grouped.keys) {
      final list = grouped[key];
      groups.add(
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: [],
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
        ..._getGroupedAttributes(others),
        if (others.isNotEmpty) Text(AppLocalizations.of(context)!.attributesMore),
        if (others.isNotEmpty) const SizedBox(height: 8),
        if (others.isNotEmpty)
          StaggeredGrid.extent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 4,
            crossAxisSpacing: 10,
            children: others.map((e) => AttributeValueWidget(e, showTitle: true)).toList(),
          ),
      ],
    );
  }
}
