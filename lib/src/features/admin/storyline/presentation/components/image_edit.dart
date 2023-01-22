import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../common_widgets/form_fields/bool_field.dart';
import '../../../../../common_widgets/form_fields/custom_text_field.dart';
import '../../../../../common_widgets/form_fields/image_picker_field.dart';
import '../../../../../common_widgets/form_fields/multiline_text_field.dart';
import '../../../../../common_widgets/loading_indicator.dart';
import '../../domain/story_entry.dart';

class ImageEdit extends StatelessWidget {
  final StoryEntry? initialValue;
  final GlobalKey<FormBuilderState> formKey;

  const ImageEdit({required this.formKey, this.initialValue, super.key});

  Widget _buildImagePicker(Image? image, bool isLoading, BuildContext context) {
    Image? fittedImage = image;
    if (null != image) {
      fittedImage = Image(image: image.image, fit: BoxFit.cover);
    }

    Widget placeholder = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const FaIcon(FontAwesomeIcons.camera),
        const SizedBox(height: 5),
        Text(AppLocalizations.of(context)!.pickAnImage, textAlign: TextAlign.center),
      ],
    );

    Widget loadingWidget = Center(child: LoadingIndicator(AppLocalizations.of(context)!.uploadImage));

    return SizedBox(
      height: MediaQuery.of(context).size.height * .36,
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        margin: const EdgeInsets.all(0),
        clipBehavior: Clip.hardEdge,
        child: isLoading ? loadingWidget : fittedImage ?? placeholder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomtextField(
          name: "title",
          label: AppLocalizations.of(context)!.imageTitle,
          validator: FormBuilderValidators.required(),
          initialValue: initialValue?.title,
        ),
        ImagePickerField(
          name: "imageUrl",
          initialValue: initialValue?.imageUrl,
          builder: (image, isLoading) => _buildImagePicker(image, isLoading, context),
        ),
        MultilineTextField(
          name: "description",
          initialValue: initialValue?.description,
          label: AppLocalizations.of(context)!.entryDescription,
          maxLines: 6,
        ),
        CustomtextField(
          name: "date",
          label: AppLocalizations.of(context)!.imageDate,
          initialValue: initialValue?.date,
          helperText: AppLocalizations.of(context)!.entryDateHelp,
        ),
        BoolField(name: "isUnlocked", initialValue: initialValue?.isUnlocked, label: AppLocalizations.of(context)!.entryIsUnlocked),
      ],
    );
  }
}
