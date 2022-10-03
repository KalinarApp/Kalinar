import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'ability_selector.dart';

class SkillDescriptionComponent extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey;
  final RoundedLoadingButtonController _controller;

  const SkillDescriptionComponent(this._formKey, this._controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          DottedBorder(
            dashPattern: const [8],
            child: const SizedBox(
              width: 128,
              height: 128,
              child: Center(child: Text("Select an Icon")),
            ),
          ),
          const SizedBox(height: 25),
          FormBuilderTextField(
            name: "name",
            maxLines: 1,
            onChanged: (value) => _controller.reset(),
            validator: FormBuilderValidators.required(),
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: "Name"),
            style: Theme.of(context).textTheme.headline5,
          ),
          FormBuilderTextField(
            name: "description",
            initialValue: "",
            minLines: 4,
            maxLines: 5,
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
          AbilitySelector(() => Scaffold.of(context).openDrawer()),
        ],
      ),
    );
  }
}
