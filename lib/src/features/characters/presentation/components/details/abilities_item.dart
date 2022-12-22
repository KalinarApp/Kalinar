import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:kalinar/src/features/admin/management/domain/ability.dart';

class AbilitiesItem extends StatelessWidget {
  final Ability ability;

  const AbilitiesItem(this.ability, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(ability.name),
              const SizedBox(width: 5),
              Text(ability.isPassive ? "Passiv" : "", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          subtitle: null != ability.description && ability.description!.isNotEmpty ? Text(ability.description!) : null,
          trailing: ability.isPassive ? null : const IconButton(icon: FaIcon(FontAwesomeIcons.diceD20), onPressed: null),
        ),
        const Divider(),
      ],
    );
  }
}
