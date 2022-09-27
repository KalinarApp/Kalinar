import 'package:flutter/material.dart';

import '../../domain/ability.dart';

class AbilityListItem extends StatelessWidget {
  final Ability ability;

  const AbilityListItem(this.ability, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(),
          title: Text(ability.name),
          subtitle: Text(ability.description),
        ),
        const Divider(),
      ],
    );
  }
}
