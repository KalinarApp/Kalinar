import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:go_router/go_router.dart';
import '../abilities/edit_ability_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/ability_list_controller.dart';
import '../../../domain/ability.dart';

class AbilitySelectionField extends ConsumerWidget {
  final Ability? initialValue;

  const AbilitySelectionField({this.initialValue, super.key});

  Future<void> _showAbilityScreen(BuildContext context) async {
    GoRouter.of(context).pushNamed(EditAbilityScreen.name);
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
            decoration: InputDecoration(labelText: AppLocalizations.of(context)!.selectAnAbility, prefixIcon: const Icon(Icons.handyman)),
            asyncItems: ref.read(abilityListControllerProvider.notifier).filter,
            compareFn: (item1, item2) => item1.name == item2.name,
            itemAsString: (item) => item.name,
            clearButtonProps: const ClearButtonProps(isVisible: true),
            dropdownSearchDecoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.abilities,
              hintText: AppLocalizations.of(context)!.selectAnAbility,
            ),
            popupProps: PopupProps.modalBottomSheet(
              modalBottomSheetProps: ModalBottomSheetProps(elevation: 16, backgroundColor: Theme.of(context).dialogBackgroundColor),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(border: const UnderlineInputBorder(), labelText: AppLocalizations.of(context)!.searchForAbility),
              ),
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
