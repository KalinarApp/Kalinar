import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/character.dart';

class CharacterConfiguration extends ConsumerWidget {
  final Character character;
  final Function(String key, dynamic value) save;

  const CharacterConfiguration(this.character, {required this.save, super.key});

  Widget _buildSwitch(BuildContext context, {required String fieldName, bool? initialValue, required String title, bool isEnabled = true}) {
    return FormBuilderSwitch(
      name: fieldName,
      enabled: isEnabled,
      initialValue: initialValue,
      title: Text(title),
      onChanged: (value) => save(fieldName, value),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSwitch(context, fieldName: "isPublic", initialValue: character.isPublic, title: AppLocalizations.of(context)!.shareCharacter),
          _buildSwitch(context,
              fieldName: "shareSkilltree",
              isEnabled: character.isPublic,
              initialValue: character.shareSkilltree,
              title: AppLocalizations.of(context)!.shareCharacterSkilltrees),
          _buildSwitch(context,
              fieldName: "shareNotes",
              isEnabled: character.isPublic,
              initialValue: character.shareNotes,
              title: AppLocalizations.of(context)!.shareCharacterNotes),
          _buildSwitch(context,
              fieldName: "shareInventory",
              isEnabled: character.isPublic,
              initialValue: character.shareInventory,
              title: AppLocalizations.of(context)!.shareCharacterInventory),
          _buildSwitch(context,
              fieldName: "shareAbilities",
              isEnabled: character.isPublic,
              initialValue: character.shareAbilities,
              title: AppLocalizations.of(context)!.shareCharacterAbilities),
          _buildSwitch(context,
              fieldName: "shareAttributes",
              isEnabled: character.isPublic,
              initialValue: character.shareAttributes,
              title: AppLocalizations.of(context)!.shareCharacterAttributes),
        ],
      ),
    );
  }
}
