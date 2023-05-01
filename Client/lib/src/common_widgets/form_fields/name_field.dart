import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../shimmer_widget.dart';

class NameField extends StatelessWidget {
  final bool readOnly;
  final String name;
  final String? label;
  final String? initialValue;
  final Widget? icon;
  final bool isLoading;
  final void Function(String? value)? onChanged;

  const NameField(
      {this.name = "name", this.label, this.icon, this.initialValue, this.isLoading = false, this.readOnly = false, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ShimmerWidget.rectangular(height: 102)
        : FormBuilderTextField(
            name: name,
            maxLines: 2,
            maxLength: 100,
            onChanged: onChanged,
            initialValue: initialValue,
            enabled: !readOnly,
            validator: FormBuilderValidators.required(),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: label ?? "Name",
              prefixIcon: icon ?? const SizedBox(),
              contentPadding: const EdgeInsets.only(right: 8),
            ),
          );
  }
}
