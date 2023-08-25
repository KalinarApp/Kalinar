import 'package:flutter/material.dart';
import 'package:kalinar/src/features/group_management/domain/role.dart';

import '../../domain/group_member.dart';

class GroupSelectionDropdownItem extends StatelessWidget {
  final GroupMember item;
  const GroupSelectionDropdownItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      isThreeLine: false,
      minVerticalPadding: 0,
      visualDensity: VisualDensity.compact,
      title: Text(item.group.name),
      subtitle: Text(item.role.getLocalization(context)),
    );
  }
}
