import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../common_widgets/form_fields/custom_text_field.dart';
import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/dropable_image_picker.dart';
import '../../../common_widgets/form_fields/multiline_text_field.dart';
import '../domain/character.dart';
import 'shared/race_selection.dart';
import 'desktop/components/custom_card.dart';

class CharacterEditor extends ConsumerWidget {
  final Character? character;
  final RoundedLoadingButtonController buttonController;
  final Function() onSave;

  const CharacterEditor(this.character, {required this.onSave, required this.buttonController, super.key});

  Widget _buildCard(Widget child) {
    return AspectRatio(aspectRatio: 1, child: child);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FocusTraversalGroup(
      policy: ReadingOrderTraversalPolicy(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Charakter erstellen", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 32)),
                DropableImagePicker(
                  initialValue: character?.iconUrl,
                  builder: (image, isLoading) => LayoutBuilder(
                    builder: (ctx, constraints) {
                      if (isLoading || image == null) {
                        return Center(
                          child: SizedBox(
                            width: constraints.maxWidth / 2,
                            child: CustomCard(
                              child: _buildCard(
                                isLoading
                                    ? const Center(child: CircularProgressIndicator())
                                    : Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                        const Icon(Icons.camera_alt),
                                        const SizedBox(height: 10),
                                        Text(AppLocalizations.of(context)!.imageSelectionDescription, textAlign: TextAlign.center),
                                      ]),
                              ),
                            ),
                          ),
                        );
                      }

                      return Center(
                        child: CustomCard(
                          child: CachedNetworkImage(
                            imageUrl: image,
                            placeholder: (context, url) => SizedBox(width: 100, child: _buildCard(const Center(child: CircularProgressIndicator()))),
                          ),
                        ),
                      );
                    },
                  ),
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
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerRight,
                  child: RoundedLoadingButton(
                    borderRadius: 8,
                    resetAfterDuration: true,
                    resetDuration: const Duration(seconds: 3),
                    controller: buttonController,
                    onPressed: onSave,
                    child: Text(AppLocalizations.of(context)!.save, style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
