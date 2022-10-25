import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class NameField extends StatelessWidget {
  final bool readOnly;
  final String? initialValue;

  const NameField({this.initialValue, this.readOnly = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 52),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  children: [
                    FormBuilderField(name: "id", builder: (field) => Container()),
                    FormBuilderTextField(
                      name: "name",
                      maxLines: 2,
                      maxLength: 100,
                      initialValue: initialValue,
                      enabled: !readOnly,
                      validator: FormBuilderValidators.required(),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Name", contentPadding: EdgeInsets.only(right: 8)),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}
