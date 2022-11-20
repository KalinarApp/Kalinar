import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:hero/src/common_widgets/form_fields/image_selector.dart';

class ImagePickerField extends StatelessWidget {
  final String? initialValue;
  final ImageType type;

  const ImagePickerField({this.initialValue, this.type = ImageType.skill, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String?>(
      name: "iconUrl",
      initialValue: initialValue,
      builder: (field) {
        return ImageSelector(
          initialValue: field.value,
          type: type,
          onChanged: (file) => field.didChange(file),
        );
      },
    );
  }
}
