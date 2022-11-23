import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../common_widgets/form_fields/custom_text_field.dart';
import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/image_picker_field.dart';
import '../../../common_widgets/form_fields/image_selector.dart';
import '../../../common_widgets/form_fields/multiline_text_field.dart';
import '../../../common_widgets/save_button.dart';
import '../../../utilities/async_value_extension.dart';
import '../application/character_controller.dart';
import '../domain/character.dart';

import 'components/race_selection.dart';

class CharacterEditorScreen extends ConsumerStatefulWidget {
  static const name = "CharacterEditor";
  static const route = "editor";

  final String? skillId;

  const CharacterEditorScreen(this.skillId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterEditorScreenState();
}

class _CharacterEditorScreenState extends ConsumerState<CharacterEditorScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  late final Character? item = null;

  late CharacterController controller;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    controller = ref.read(characterControllerProvider);
    super.initState();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        final value = null == widget.skillId ? await controller.create(data) : await controller.update(widget.skillId!, data);
        if (!mounted) return;
        value.showSnackbarOnError(context);
        if (value.hasError) {
          _btnController.error();
          Future.delayed(const Duration(seconds: 3), _btnController.reset);
        } else {
          _btnController.success();
          GoRouter.of(context).pop();
        }
      } else {
        _btnController.error();
        Future.delayed(const Duration(seconds: 3), _btnController.reset);
      }
    } else {
      _btnController.error();
      Future.delayed(const Duration(seconds: 3), _btnController.reset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SaveButton(controller: _btnController, onSave: _save),
            ),
          ],
        ),
        body: FocusTraversalGroup(
          policy: ReadingOrderTraversalPolicy(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ImagePickerField(initialValue: item?.iconUrl, type: ImageType.characterImage),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: CustomtextField(
                          name: "name",
                          initialValue: item?.name,
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
                        initialValue: item?.profession,
                        icon: FontAwesomeIcons.toolbox,
                        label: AppLocalizations.of(context)!.characterProfession,
                      ),
                      CustomtextField(
                        name: "relationship",
                        initialValue: item?.relationship,
                        icon: FontAwesomeIcons.handHoldingHeart,
                        label: AppLocalizations.of(context)!.characterRelationship,
                      ),
                      CustomtextField(
                        name: "religion",
                        initialValue: item?.religion,
                        icon: FontAwesomeIcons.bookBible,
                        label: AppLocalizations.of(context)!.characterReligion,
                      ),
                    ],
                  ),
                  DescriptionField(label: AppLocalizations.of(context)!.characterDescription, initialValue: item?.description),
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
      ),
    );
  }
}
