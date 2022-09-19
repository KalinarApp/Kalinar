import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hero/src/features/skilling/presentation/edit_ability/edit_ability_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EditSkillForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey;

  const EditSkillForm(this._formKey, {super.key});

  Future<void> _showAbilityEditModal(BuildContext context) async {
    String? result = await showModalBottomSheet<String>(context: context, isScrollControlled: true, builder: (_) => const EditAbilityScreen());

    if (null != result) {
      _formKey.currentState?.fields["ability"]?.didChange(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
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
                      modalBottomSheetProps: ModalBottomSheetProps(elevation: 16, backgroundColor: Theme.of(context).backgroundColor),
                      showSearchBox: true,
                      searchFieldProps:
                          const TextFieldProps(decoration: InputDecoration(border: UnderlineInputBorder(), labelText: "Search for ability")),
                    ),
                    items: const ["Test", "Test2", "Test3"],
                  ),
                ),
                IconButton(
                  onPressed: () async => _showAbilityEditModal(context),
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.add, size: 32),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
