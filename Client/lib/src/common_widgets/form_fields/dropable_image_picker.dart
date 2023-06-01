import 'dart:convert';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';

import '../../utilities/image_repository.dart';

class DropableImagePicker extends ConsumerWidget {
  final String name;
  final String? initialValue;
  final bool enabled;
  final Widget Function(String? imageUrl, bool isLoading) builder;

  const DropableImagePicker({this.name = "iconUrl", this.initialValue, this.enabled = true, required this.builder, super.key});

  Future<void> _openFilePicker(WidgetRef ref, Function(String?) onChanged) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null && (result.files.single.bytes?.isNotEmpty ?? false)) {
      final bytes = result.files.single.bytes!;
      _uploadImage(base64Encode(bytes), ref, onChanged);
    }
  }

  Future _uploadImage(String? base64, WidgetRef ref, Function(String?) onChanged) async {
    if (null != base64) {
      final url = await ref.read(imageRepositoryProvider).uploadImageToImgur(base64);
      onChanged(url);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormBuilderField<String?>(
      name: name,
      initialValue: initialValue,
      enabled: enabled,
      builder: (field) {
        return GestureDetector(
          onTap: enabled ? () => _openFilePicker(ref, field.didChange) : null,
          child: DropTarget(
            onDragDone: enabled
                ? (details) async {
                    if (lookupMimeType(details.files.first.name)?.startsWith("image/") ?? false) {
                      final value = base64Encode(await details.files.first.readAsBytes());
                      await _uploadImage(value, ref, field.didChange);
                    }
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Stack(
                children: [
                  Padding(padding: const EdgeInsets.all(4), child: builder(field.value, false)),
                  if (null != field.value)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            field.didChange(null);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
