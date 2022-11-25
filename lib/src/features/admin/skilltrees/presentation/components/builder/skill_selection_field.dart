import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../management/application/skill_list_controller.dart';
import '../../../../management/domain/skill.dart';
import '../../../../management/presentation/components/skills/edit_skill_screen.dart';

class SkillSelectionField extends ConsumerWidget {
  final Skill? initialValue;

  const SkillSelectionField({this.initialValue, super.key});

  Future<void> _showCreateSkillScreen(BuildContext context) async {
    GoRouter.of(context).pushNamed(EditSkillScreen.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Flexible(
          child: FormBuilderSearchableDropdown<Skill>(
            name: "skill",
            valueTransformer: (value) {
              if (null != value) {
                final skill = jsonDecode(jsonEncode(value));
                return skill;
              }
              return null;
            },
            initialValue: initialValue,
            decoration: const InputDecoration(labelText: "Select Skill", prefixIcon: Icon(Icons.handyman)),
            validator: FormBuilderValidators.required(),
            asyncItems: ref.read(skillListControllerProvider.notifier).filter,
            compareFn: (item1, item2) => item1.name == item2.name,
            itemAsString: (item) => item.name,
            clearButtonProps: const ClearButtonProps(isVisible: true),
            dropdownSearchDecoration: const InputDecoration(
              labelText: "Skills",
              hintText: "Select skill",
            ),
            popupProps: PopupProps.modalBottomSheet(
              modalBottomSheetProps: ModalBottomSheetProps(elevation: 16, backgroundColor: Theme.of(context).dialogBackgroundColor),
              showSearchBox: true,
              searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: UnderlineInputBorder(), labelText: "Search for skills")),
            ),
          ),
        ),
        IconButton(
          onPressed: () async => _showCreateSkillScreen(context),
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.add, size: 32),
        )
      ],
    );
  }
}
