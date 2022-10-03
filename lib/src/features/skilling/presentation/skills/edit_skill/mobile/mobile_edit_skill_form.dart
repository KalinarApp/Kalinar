import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import '../../../abilities/edit_ability/create_ability_screen.dart';

class MobileEditSkillForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey;

  const MobileEditSkillForm(this._formKey, {super.key});

  Future<void> _showAbilityScreen(BuildContext context) async {
    await Navigator.pushNamed(context, CreateAbilityScreen.routeName).then((value) {
      if (null != value && value is String) {
        _formKey.currentState?.fields["ability"]?.didChange(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilderImagePicker(
              name: "icon",
              maxImages: 1,
              placeholderWidget: SizedBox(
                width: 130,
                child: Container(
                  color: (Theme.of(context).primaryColor).withAlpha(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_enhance,
                        color: Theme.of(context).primaryColor,
                        size: 48,
                      ),
                      const SizedBox(height: 3),
                      Text("Select an Icon for this skill.", style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
            ),
            FormBuilderTextField(
              name: "description",
              initialValue: "",
              maxLines: 4,
              decoration: const InputDecoration(
                label: Text("Skill description"),
                alignLabelWithHint: true,
                prefixIconConstraints: BoxConstraints.expand(width: 48, height: 100),
                prefixIcon: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Icon(Icons.description),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: FormBuilderSearchableDropdown<String>(
                    name: "ability",
                    decoration: const InputDecoration(labelText: "Select Ability", prefixIcon: Icon(Icons.handyman)),
                    clearButtonProps: const ClearButtonProps(isVisible: true),
                    dropdownSearchDecoration: const InputDecoration(
                      labelText: "Abilities",
                      hintText: "Select ability",
                    ),
                    popupProps: PopupProps.modalBottomSheet(
                      modalBottomSheetProps: ModalBottomSheetProps(elevation: 16, backgroundColor: Theme.of(context).dialogBackgroundColor),
                      showSearchBox: true,
                      searchFieldProps:
                          const TextFieldProps(decoration: InputDecoration(border: UnderlineInputBorder(), labelText: "Search for ability")),
                    ),
                    items: const ["Test", "Test2", "Test3"],
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
            ),
          ],
        ),
      ),
    );
  }
}
