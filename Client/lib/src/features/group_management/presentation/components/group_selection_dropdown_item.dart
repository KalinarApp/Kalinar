import 'package:flutter/material.dart';

import '../../domain/group_member.dart';
import '../../domain/role.dart';

class GroupSelectionDropdownItem extends StatelessWidget {
  final GroupMember item;
  const GroupSelectionDropdownItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: item.group.name),
          TextSpan(text: '\n ${item.role.getLocalization(context)}', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
