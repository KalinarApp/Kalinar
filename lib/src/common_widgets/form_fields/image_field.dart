import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ImageField extends StatelessWidget {
  final String? initialValue;

  const ImageField({this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return null == initialValue
        ? FormBuilderImagePicker(
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
                    Text("Select an Icon for this skill.", style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          )
        : FormBuilderField(
            name: "iconUrl",
            initialValue: initialValue,
            builder: (field) => Image.network(field.value!),
          );
  }
}
