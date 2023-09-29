import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/kalinar_icons.dart';
import '../../application/controller/abilities_controller.dart';
import '../../domain/ability.dart';
import '../../domain/suggestion_state.dart';
import '../edit_ability_screen.dart';

class AbilitySelectionField extends ConsumerWidget {
  final Ability? initialValue;
  final Function(Ability? item)? onSelectionChanged;

  const AbilitySelectionField({this.initialValue, this.onSelectionChanged, super.key});

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
            decoration: InputDecoration(labelText: AppLocalizations.of(context)!.selectAnAbility, prefixIcon: const Icon(Kalinar.star)),
            asyncItems: (text) async {
              final all =
                  await ref.read(abilitiesControllerProvider).search(query: text, allowedStates: [SuggestionState.approved, SuggestionState.pending]);
              return all..sortBy((element) => element.name);
            },
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
            onChanged: onSelectionChanged,
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
