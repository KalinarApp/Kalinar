import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../shimmer_widget.dart';

class DescriptionField extends StatelessWidget {
  final String? initialValue;
  final String? label;
  final bool isLoading;
  final bool readOnly;
  final void Function(String? value)? onChanged;

  const DescriptionField({this.label, this.initialValue, this.isLoading = false, this.readOnly = false, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ShimmerWidget.rectangular(height: 100)
        : FormBuilderTextField(
            name: "description",
            initialValue: initialValue,
            maxLines: 4,
            onChanged: onChanged,
            enabled: !readOnly,
            decoration: InputDecoration(
              label: null != label ? Text(label!) : null,
              alignLabelWithHint: true,
              prefixIconConstraints: const BoxConstraints.expand(width: 48, height: 100),
              prefixIcon: const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Icon(Icons.description),
                ),
              ),
            ),
          );
  }
}
