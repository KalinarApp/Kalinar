import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../common_widgets/form_fields/selection_field.dart';
import '../../../../../characters/application/character_controller.dart';
import '../../../../../characters/domain/character_overview.dart';

class CharacterSelectionField extends ConsumerWidget {
  final CharacterOverview? initialValue;

  const CharacterSelectionField({this.initialValue, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SelectionField<CharacterOverview>(
      name: "characterId",
      initialValue: initialValue,
      transformer: (value) => value?.id,
      asString: (item) => item.name,
      compareFn: (item1, item2) => item1.name == item2.name,
      label: AppLocalizations.of(context)!.selectACharacter,
      searchLabel: AppLocalizations.of(context)!.searchForCharacter,
      icon: const Icon(FontAwesomeIcons.person),
      items: (_) async => await ref.read(characterControllerProvider.notifier).getAll(),
      onChanged: (previous, next) async => true,
    );
  }
}
