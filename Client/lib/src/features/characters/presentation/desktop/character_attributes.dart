import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../utilities/global_attributes.dart';
import '../../../traits/domain/attribute_value.dart';
import '../../domain/character.dart';
import '../components/attribute_value_widget.dart';

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
      groups.add(_buildGroup(key ?? "", list.map((e) => AttributeValueWidget(e, showTitle: true)).toList(), context));
    }

    return groups;
  }

  Widget _buildGroup(String title, List<Widget> children, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        for (Widget child in children) Padding(padding: const EdgeInsets.only(bottom: 4.0), child: child),
      ],
    );
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

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final columnCount = (constraints.maxWidth / 200).floor();
        final items = [_buildGroup("Grundwerte", globalAttributes, context), ..._getGroupedAttributes(others, context)];
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: AlignedGridView.count(
            crossAxisCount: columnCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
            itemCount: items.length,
            itemBuilder: (context, index) => items[index],
          ),
        );
      },
    );
  }
}
