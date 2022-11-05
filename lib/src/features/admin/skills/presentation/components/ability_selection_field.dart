import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:go_router/go_router.dart';

import '../../../abilities/application/ability_list_controller.dart';
import '../../../abilities/domain/ability.dart';
import '../../../abilities/presentation/create_ability_screen.dart';

class AbilitySelectionField extends ConsumerWidget {
  final Ability? initialValue;

  const AbilitySelectionField({this.initialValue, super.key});

  Future<void> _showAbilityScreen(BuildContext context) async {
    GoRouter.of(context).pushNamed(CreateAbilityScreen.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Flexible(
          child: FormBuilderSearchableDropdown<Ability>(
            name: "abilityId",
            valueTransformer: (value) => value?.id,
            initialValue: initialValue,
            decoration: const InputDecoration(labelText: "Select Ability", prefixIcon: Icon(Icons.handyman)),
            // validator: FormBuilderValidators.required(),
            asyncItems: ref.read(abilityListControllerProvider.notifier).filter,
            compareFn: (item1, item2) => item1.name == item2.name,
            itemAsString: (item) => item.name,
            clearButtonProps: const ClearButtonProps(isVisible: true),
            dropdownSearchDecoration: const InputDecoration(
              labelText: "Abilities",
              hintText: "Select ability",
            ),
            popupProps: PopupProps.modalBottomSheet(
              modalBottomSheetProps: ModalBottomSheetProps(elevation: 16, backgroundColor: Theme.of(context).dialogBackgroundColor),
              showSearchBox: true,
              searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: UnderlineInputBorder(), labelText: "Search for ability")),
            ),
          ),
        ),
        IconButton(
          onPressed: () async => _showAbilityScreen(context),
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.add, size: 32),
        )
      ],
    );
  }
}
