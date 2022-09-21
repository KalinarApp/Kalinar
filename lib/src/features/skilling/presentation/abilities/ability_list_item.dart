import 'package:flutter/material.dart';

class AbilityListItem extends StatelessWidget {
  const AbilityListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(
          leading: CircleAvatar(),
          title: Text("Ability I"),
          subtitle: Text("This is the super awesome description for Ability I"),
        ),
        Divider(),
      ],
    );
  }
}
