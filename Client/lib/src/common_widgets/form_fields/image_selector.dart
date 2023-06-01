import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mime/mime.dart';

import '../../utilities/image_repository.dart';
import '../node_tile.dart';

enum ImageType {
  skill,
  characterImage,
}

class ImageSelector extends ConsumerWidget {
  final ImageType type;
  final Widget Function(Image? image, bool isLoading)? builder;
  final Function(String? data)? onChanged;
  final String? value;

  const ImageSelector({this.value, this.type = ImageType.skill, this.builder, this.onChanged, super.key});

  Future<void> _openFilePicker(WidgetRef ref) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null && (result.files.single.bytes?.isNotEmpty ?? false)) {
      final bytes = result.files.single.bytes!;
      _uploadImage(base64Encode(bytes), ref);
    }
  }

  Image? _getImage() {
    Image? image;
    if (null != value) {
      if (Uri.tryParse(value!)?.isAbsolute == true) {
        image = Image(image: CachedNetworkImageProvider(value!));
      } else {
        image = Image.memory(base64Decode(value!));
      }
    }
    return image;
  }

  Widget _buildByType(image, BuildContext context) {
    if (null != builder) {
      return builder!(image, false);
    }

    switch (type) {
      case ImageType.skill:
        return _buildSkillContent(image);
      case ImageType.characterImage:
        return _buildCharacterImageContent(image, context);
    }
  }

  Widget _buildSkillContent(Image? image) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: NodeTile(
        image,
        height: 110,
        width: 110,
        placeholderWidget: const Center(child: FaIcon(FontAwesomeIcons.camera, size: 40)),
      ),
    );
  }

  Widget _buildCharacterImageContent(Image? image, BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        child: _buildContent(image, context),
      ),
    );
  }

  Widget _buildContent(Image? image, BuildContext context) {
    return Center(
      child: image ??
          Column(
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
    );
  }

  Future<void> _uploadImage(String? base64, WidgetRef ref) async {
    if (null != base64) {
      final url = await ref.read(imageRepositoryProvider).uploadImageToImgur(base64);
      if (null != onChanged) onChanged!(url);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = _getImage();
    return GestureDetector(
      onTap: () => _openFilePicker(ref),
      child: DropTarget(
        onDragDone: (details) async {
          if (lookupMimeType(details.files.first.name)?.startsWith("image/") ?? false) {
            final value = base64Encode(await details.files.first.readAsBytes());
            _uploadImage(value, ref);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: _buildByType(image, context),
              ),
              if (null != value)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey),
                    child: InkWell(
                      onTap: () {
                        if (null != onChanged) onChanged!(null);
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
