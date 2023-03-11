import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'image_selector.dart';

class ImagePickerField extends StatelessWidget {
  final String name;
  final String? initialValue;
  final ImageType type;
  final Widget Function(Image? image, bool isLoading)? builder;

  const ImagePickerField({this.name = "iconUrl", this.initialValue, this.type = ImageType.skill, this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String?>(
      name: name,
      initialValue: initialValue,
      builder: (field) {
        return ImageSelector(
          value: field.value,
          type: type,
          builder: builder,
          onChanged: (file) => field.didChange(file),
        );
      },
    );
  }
}
