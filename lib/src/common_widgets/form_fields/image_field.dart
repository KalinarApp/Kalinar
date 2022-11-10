import 'dart:convert';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hero/src/common_widgets/form_fields/drag_drop_image.dart';

class ImageField extends StatelessWidget {
  final String? initialValue;

  const ImageField({this.initialValue, super.key});

  Widget _buildMobileImagePicker(BuildContext context) {
    return FormBuilderImagePicker(
      name: "iconUrl",
      valueTransformer: (value) {
        String? base64;
        if (null != value) {
          for (dynamic file in value) {
            final bytes = File(file!.path).readAsBytesSync();
            base64 = base64Encode(bytes);
            break;
          }
        }
        return base64;
      },
      maxImages: 1,
      placeholderWidget: SizedBox(
        width: 130,
        child: Container(
          color: (Theme.of(context).primaryColor).withAlpha(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_enhance,
                color: Theme.of(context).primaryColor,
                size: 48,
              ),
              const SizedBox(height: 3),
              Text(AppLocalizations.of(context)!.imageSelectionDescription, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropImagePicker(BuildContext context, String? initialValue) {
    return FormBuilderField<String?>(
      name: "iconUrl",
      initialValue: initialValue,
      builder: (field) {
        return DragDropImage(initialValue: field.value, onChanged: (file) => field.didChange(file));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid || Platform.isIOS
        ? null == initialValue
            ? _buildMobileImagePicker(context)
            : FormBuilderField(name: "iconUrl", initialValue: initialValue, builder: (field) => Image.network(field.value!))
        : _buildDropImagePicker(context, initialValue);
  }
}
