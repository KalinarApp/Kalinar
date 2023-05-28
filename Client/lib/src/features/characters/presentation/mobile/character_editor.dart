import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../common_widgets/form_fields/custom_text_field.dart';
import '../../../../common_widgets/form_fields/description_field.dart';
import '../../../../common_widgets/form_fields/image_picker_field.dart';
import '../../../../common_widgets/form_fields/image_selector.dart';
import '../../../../common_widgets/form_fields/multiline_text_field.dart';
import '../../../../common_widgets/save_button.dart';
import '../../domain/character.dart';
import '../shared/race_selection.dart';

class CharacterEditor extends ConsumerWidget {
  final Character? character;
  final RoundedLoadingButtonController buttonController;
  final Function() onSave;

  const CharacterEditor(this.character, {required this.onSave, required this.buttonController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: SaveButton(controller: buttonController, onSave: onSave),
          ),
        ],
      ),
      body: FocusTraversalGroup(
        policy: ReadingOrderTraversalPolicy(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ImagePickerField(initialValue: character?.iconUrl, type: ImageType.characterImage),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: CustomtextField(
                        name: "name",
                        initialValue: character?.name,
                        label: AppLocalizations.of(context)!.characterName,
                        icon: FontAwesomeIcons.userTag,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 100),
                        child: FormBuilderTextField(
                            name: "age",
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(labelText: AppLocalizations.of(context)!.characterAge),
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.integer(),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                      ),
                    ),
                  ],
                ),
                GridView.extent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 400 / 55,
                  crossAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    CustomtextField(
                      name: "profession",
                      initialValue: character?.profession,
                      icon: FontAwesomeIcons.toolbox,
                      label: AppLocalizations.of(context)!.characterProfession,
                    ),
                    CustomtextField(
                      name: "relationship",
                      initialValue: character?.relationship,
                      icon: FontAwesomeIcons.handHoldingHeart,
                      label: AppLocalizations.of(context)!.characterRelationship,
                    ),
                    CustomtextField(
                      name: "religion",
                      initialValue: character?.religion,
                      icon: FontAwesomeIcons.bookBible,
                      label: AppLocalizations.of(context)!.characterReligion,
                    ),
                  ],
                ),
                DescriptionField(label: AppLocalizations.of(context)!.characterDescription, initialValue: character?.description),
                const RaceSelection(),
                MultilineTextField(
                  name: "inventory",
                  maxLines: 3,
                  label: AppLocalizations.of(context)!.characterInventory,
                  icon: FontAwesomeIcons.clipboardList,
                ),
                MultilineTextField(
                  name: "notes",
                  maxLines: 3,
                  label: AppLocalizations.of(context)!.characterNotes,
                  icon: FontAwesomeIcons.noteSticky,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
