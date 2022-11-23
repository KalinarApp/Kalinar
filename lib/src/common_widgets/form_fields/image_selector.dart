import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mime/mime.dart';

import '../../features/admin/management/data/imgur_repository.dart';
import '../loading_indicator.dart';

enum ImageType {
  skill,
  characterImage,
}

class ImageSelector extends ConsumerStatefulWidget {
  final ImageType type;
  final Function(String? data)? onChanged;
  final String? initialValue;

  const ImageSelector({this.initialValue, this.type = ImageType.skill, this.onChanged, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends ConsumerState<ImageSelector> {
  bool isDragging = false;
  bool isLoading = false;
  String? selectedImage;

  String? _toBase64(XFile? file) {
    String? base64;
    if (null != file) {
      final bytes = File(file.path).readAsBytesSync();
      base64 = base64Encode(bytes);
    }
    return base64;
  }

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        isLoading = true;
      });
      _uploadImage(_toBase64(XFile(file.path)));
    }
  }

  Image? _getImage() {
    Image? image;
    if (null != selectedImage) {
      if (Uri.tryParse(selectedImage!)?.isAbsolute == true) {
        image = Image.network(selectedImage!);
      } else {
        image = Image.memory(base64Decode(selectedImage!));
      }
    }
    return image;
  }

  Widget _buildByType(image) {
    switch (widget.type) {
      case ImageType.skill:
        return _buildSkillContent(image);
      case ImageType.characterImage:
        return _buildCharacterImageContent(image);
    }
  }

  Widget _buildSkillContent(Image? image) {
    return SizedBox(
        width: 128,
        height: 128,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: _buildContent(image),
          ),
        ));
  }

  Widget _buildCharacterImageContent(Image? image) {
    return DottedBorder(
      dashPattern: const [20, 2],
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: SizedBox(
        width: 200,
        child: ClipRRect(borderRadius: BorderRadius.circular(12), child: _buildContent(image)),
      ),
    );
  }

  Widget _buildContent(Image? image) {
    return isLoading
        ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: LoadingIndicator(AppLocalizations.of(context)!.uploadImage),
          )
        : Center(
            child: image ??
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const FaIcon(FontAwesomeIcons.camera),
                      const SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context)!.pickAnImage,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
          );
  }

  Future<void> _uploadImage(String? base64) async {
    if (null != base64) {
      final url = await ref.read(imgurRepositoryProvider).uploadImageToImgur(base64);
      setState(() {
        isLoading = false;
        selectedImage = url;
      });
      if (null != widget.onChanged) widget.onChanged!(url);
    }
  }

  @override
  void initState() {
    selectedImage = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final image = _getImage();
    return GestureDetector(
      onTap: _openFilePicker,
      child: DropTarget(
        onDragDone: (details) {
          if (lookupMimeType(details.files.first.name)?.startsWith("image/") ?? false) {
            final value = _toBase64(details.files.first);
            setState(() => isLoading = true);
            _uploadImage(value);
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
                child: _buildByType(image),
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
      ),
    );
  }
}
