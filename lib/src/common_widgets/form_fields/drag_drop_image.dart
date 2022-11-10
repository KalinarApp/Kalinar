import 'dart:convert';
import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mime/mime.dart';

class DragDropImage extends StatefulWidget {
  final Function(String? data)? onChanged;
  final String? initialValue;

  const DragDropImage({this.initialValue, this.onChanged, super.key});

  @override
  State<DragDropImage> createState() => _DragDropImageState();
}

class _DragDropImageState extends State<DragDropImage> {
  bool isDragging = false;
  String? selectedImage;

  String? _toBase64(XFile? file) {
    String? base64;
    if (null != file) {
      final bytes = File(file.path).readAsBytesSync();
      base64 = base64Encode(bytes);
    }
    return base64;
  }

  Image _getImage() {
    if (null != selectedImage) {
      if (Uri.tryParse(selectedImage!)?.isAbsolute == true) {
        return Image.network(selectedImage!);
      } else {
        return Image.memory(base64Decode(selectedImage!));
      }
    }
    throw "cannot be null";
  }

  @override
  void initState() {
    selectedImage = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (details) {
        if (lookupMimeType(details.files.first.name)?.startsWith("image/") ?? false) {
          final value = _toBase64(details.files.first);
          setState(() => selectedImage = value);
          if (null != widget.onChanged) widget.onChanged!(value);
        }
      },
      onDragEntered: (details) => setState(() => isDragging = true),
      onDragExited: (_) => setState(() => isDragging = false),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: SizedBox(
                  width: 128,
                  height: 128,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: null != selectedImage
                          ? _getImage()
                          : Center(
                              child: Text(
                              AppLocalizations.of(context)!.imageDropHere,
                              textAlign: TextAlign.center,
                            )),
                    ),
                  )),
            ),
            if (null != selectedImage)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey),
                  child: InkWell(
                    onTap: () {
                      if (null != widget.onChanged) widget.onChanged!(null);
                      setState(() => selectedImage = null);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: const Icon(Icons.close),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
