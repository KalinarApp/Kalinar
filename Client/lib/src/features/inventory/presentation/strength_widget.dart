import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalinar/src/features/inventory/domain/weapon.dart';

class StrengthWidget extends StatelessWidget {
  final Weapon item;

  const StrengthWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(FontAwesomeIcons.handFist),
        const SizedBox(width: 5),
        Text(
          "${item.diceCount}d${item.dice}${0 < item.bonus ? "+${item.bonus}" : ""}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
