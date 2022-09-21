import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

class AbilitySelector extends StatelessWidget {
  final Function() onNewAbility;

  const AbilitySelector(this.onNewAbility, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
              searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: UnderlineInputBorder(), labelText: "Search for ability")),
            ),
            items: const ["Test", "Test2", "Test3"],
          ),
        ),
        IconButton(
          onPressed: onNewAbility,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.add, size: 32),
        )
      ],
    );
  }
}
