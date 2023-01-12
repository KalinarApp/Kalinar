import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/admin/storyline/application/story_entries_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../common_widgets/form_fields/bool_field.dart';
import '../../../../common_widgets/form_fields/custom_text_field.dart';
import '../../../../common_widgets/form_fields/image_picker_field.dart';
import '../../../../common_widgets/form_fields/image_selector.dart';
import '../../../../common_widgets/form_fields/multiline_text_field.dart';
import '../../../../common_widgets/loading_indicator.dart';
import '../../../../common_widgets/save_button.dart';
import '../../../../utilities/async_value_extension.dart';
import '../domain/story_entry.dart';
import '../domain/story_entry_type.dart';

class StorylineEditScreen extends ConsumerStatefulWidget {
  static const name = "EditStoryline";
  static const route = "edit";

  final String? id;

  const StorylineEditScreen(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StorylineEditScreenState();
}

class _StorylineEditScreenState extends ConsumerState<StorylineEditScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();

  final controller = RoundedLoadingButtonController();
  StoryEntryType selectedType = StoryEntryType.StoryImage;

  Future<StoryEntry?> _loadItem() async {
    if (null != widget.id) {
      final result = await ref.read(storyEntriesControllerProvider).getById(widget.id!);
      setState(() {
        selectedType = StoryEntryType.values.byName(result.type);
      });
      return result;
    }
    return null;
  }

  List<Widget> _buildImageFields(String? imageUrl) {
    return [
      ImagePickerField(
        name: "imageUrl",
        initialValue: imageUrl,
        builder: _buildImagePicker,
      ),
    ];
  }

  List<Widget> _buildBookFields() {
    return [];
  }

  Widget _buildIconPicker(Image? image, bool isLoading) {
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
      width: 110,
      height: 150,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(0),
        clipBehavior: Clip.hardEdge,
        child: isLoading ? loadingWidget : fittedImage ?? placeholder,
      ),
    );
  }

  Widget _buildImagePicker(Image? image, bool isLoading) {
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

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 150),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(0),
        clipBehavior: Clip.hardEdge,
        child: isLoading ? loadingWidget : fittedImage ?? placeholder,
      ),
    );
  }

  Future _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        final value = null == widget.id
            ? await ref.read(storyEntriesControllerProvider).create(data)
            : await ref.read(storyEntriesControllerProvider).update(widget.id!, data);
        if (!mounted) return;
        value.showSnackbarOnError(context);
        if (value.hasError) {
          controller.error();
          Future.delayed(const Duration(seconds: 3), controller.reset);
        } else {
          controller.success();
          GoRouter.of(context).pop();
        }
      } else {
        controller.error();
        Future.delayed(const Duration(seconds: 3), controller.reset);
      }
    } else {
      controller.error();
      Future.delayed(const Duration(seconds: 3), controller.reset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadItem(),
        builder: (context, snapshot) {
          final item = snapshot.data;
          if (!snapshot.hasData && snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SaveButton(controller: controller, onSave: _save),
                )
              ],
            ),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilderDropdown<StoryEntryType>(
                        name: "type",
                        isExpanded: true,
                        enabled: widget.id == null,
                        valueTransformer: (value) => value.toString().split(".")[1],
                        initialValue: selectedType,
                        onChanged: (value) => setState(() => selectedType = value ?? StoryEntryType.StoryImage),
                        items:
                            StoryEntryType.values.map((e) => DropdownMenuItem<StoryEntryType>(value: e, child: Text(e.getTitle(context)))).toList(),
                      ),
                      CustomtextField(name: "title", label: "Titel", validator: FormBuilderValidators.required(), initialValue: item?.title),
                      Row(
                        children: [
                          if (StoryEntryType.StoryImage != selectedType)
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: ImagePickerField(initialValue: item?.iconUrl, type: ImageType.characterImage, builder: _buildIconPicker),
                            ),
                          Expanded(
                              child: MultilineTextField(name: "description", initialValue: item?.description, label: "Beschreibung", maxLines: 6)),
                        ],
                      ),
                      CustomtextField(
                        name: "date",
                        label: "Veröffentlichungsdatum",
                        initialValue: item?.date,
                        helperText: "Dient nur der Anzeige und ändert nichts an der Reihenfolge.",
                      ),
                      BoolField(
                          name: "isUnlocked", initialValue: item?.isUnlocked, label: "Wurde der Eintrag bereits von der Gruppe freigeschaltet?"),
                      if (StoryEntryType.StoryImage == selectedType) ..._buildImageFields(item?.imageUrl),
                      if (StoryEntryType.StoryBook == selectedType) ..._buildBookFields(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
