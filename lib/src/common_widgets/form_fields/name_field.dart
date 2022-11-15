import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class NameField extends StatelessWidget {
  final bool readOnly;
  final String? label;
  final String? initialValue;
  final Widget? icon;

  const NameField({this.label, this.icon, this.initialValue, this.readOnly = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 102,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: "name",
                      maxLines: 2,
                      maxLength: 100,
                      initialValue: initialValue,
                      enabled: !readOnly,
                      validator: FormBuilderValidators.required(),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: label ?? "Name",
                        prefixIcon: icon ?? const SizedBox(),
                        contentPadding: const EdgeInsets.only(right: 8),
                      ),
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
