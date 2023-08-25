import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../domain/group_member.dart';
import 'group_selection_dropdown_item.dart';

class GroupSelectionDropdown extends StatelessWidget {
  final GroupMember? value;
  final List<GroupMember> items;
  final Function(GroupMember? group) onChanged;

  const GroupSelectionDropdown({super.key, required this.items, this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<GroupMember>(
        isExpanded: true,
        hint: Text(
          'Select Item',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: items.map((item) => DropdownMenuItem<GroupMember>(value: item, child: GroupSelectionDropdownItem(item: item))).toList(),
        value: value,
        onChanged: onChanged,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
