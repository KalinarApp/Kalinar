import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/features/characters/domain/character.dart';

class CharacterConfiguration extends ConsumerWidget {
  final Character character;
  final Function(String key, dynamic value) save;

  const CharacterConfiguration(this.character, {required this.save, super.key});

  Widget _buildSwitch(BuildContext context, {required String fieldName, bool? initialValue, required String title}) {
    return FormBuilderSwitch(name: "isPublic", initialValue: initialValue, title: Text(title), onChanged: (value) => save(fieldName, value));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(children: [
        _buildSwitch(context, fieldName: "isPublic", initialValue: character.isPublic, title: "Charakter mit Gruppenmitgliedern teilen"),
        if (character.isPublic)
          _buildSwitch(context, fieldName: "shareSkilltree", initialValue: character.shareSkilltree, title: "Andere dürfen Skillbäume sehen"),
        if (character.isPublic)
          _buildSwitch(context, fieldName: "shareNotes", initialValue: character.shareNotes, title: ("Andere dürfen Notizen sehen")),
        if (character.isPublic)
          _buildSwitch(context, fieldName: "shareInventory", initialValue: character.shareInventory, title: ("Andere dürfen Inventar sehen")),
        if (character.isPublic)
          _buildSwitch(context, fieldName: "shareAbilities", initialValue: character.shareAbilities, title: ("Andere dürfen Talente sehen")),
        if (character.isPublic)
          _buildSwitch(context, fieldName: "shareAttributes", initialValue: character.shareAttributes, title: ("Andere dürfen Statistik sehen")),
      ]),
    );
  }
}
