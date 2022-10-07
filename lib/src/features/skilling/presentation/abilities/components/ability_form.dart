import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AbilityForm extends StatelessWidget {
  const AbilityForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FormBuilderTextField(
        name: "name",
        initialValue: "",
        textInputAction: TextInputAction.next,
        validator: FormBuilderValidators.required(),
        decoration: const InputDecoration(labelText: "Ability name", prefixIcon: SizedBox(width: 20)),
      ),
      FormBuilderSwitch(
        name: "isPassive",
        initialValue: false,
        title: Text(
          "Is passive ability?",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        decoration: const InputDecoration(prefixIcon: Icon(Icons.gps_not_fixed_outlined)),
      ),
      FormBuilderTextField(
        name: "description",
        initialValue: "",
        maxLines: 4,
        decoration: const InputDecoration(
          label: Text("Ability description"),
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
    ]);
  }
}
