import 'package:flutter/material.dart';

import 'package:kalinar/src/features/characters/domain/character.dart';
import 'package:kalinar/src/features/characters/presentation/components/attribute_value_widget.dart';
import 'package:kalinar/src/utilities/global_attributes.dart';

class CharacterAttributes extends StatelessWidget {
  final Character character;

  const CharacterAttributes(this.character, {super.key});

  List<AttributeValueWidget> _getGlobalAttribute(String id) {
    return [
      if (character.attributes.any((element) => element.attribute.id.toLowerCase() == id))
        AttributeValueWidget(character.attributes.firstWhere((element) => element.attribute.id.toLowerCase() == id)),
    ];
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

    final others = character.attributes
        .where((x) => !globalAttributes.any((y) => x.attributeId == y.value.attributeId))
        .map((e) => AttributeValueWidget(e))
        .toList();

    others.sort((a, b) => a.value.value == b.value.value
        ? 0
        : a.value.value > b.value.value
            ? -1
            : 1);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.extent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: 10,
          childAspectRatio: 250 / 30,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: globalAttributes,
        ),
        const SizedBox(height: 20),
        Text("Weitere Charakterattribute:"),
        const SizedBox(height: 4),
        GridView.extent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: 10,
          childAspectRatio: 250 / 30,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: others,
        ),
      ],
    );
  }
}
