import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:kalinar/src/common_widgets/form_fields/custom_text_field.dart';
import 'package:kalinar/src/common_widgets/form_fields/description_field.dart';
import 'package:kalinar/src/common_widgets/form_fields/image_picker_field.dart';
import 'package:kalinar/src/common_widgets/form_fields/image_selector.dart';
import 'package:kalinar/src/common_widgets/form_fields/multiline_text_field.dart';
import 'package:kalinar/src/common_widgets/form_fields/name_field.dart';

import '../application/story_entry_controller.dart';
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
  StoryEntry? item;
  late StoryEntryType selectedType;

  @override
  void initState() {
    selectedType = StoryEntryType.StoryImage;
    if (null != widget.id) {
      Future.delayed(Duration.zero, () async {
        final result = await ref.read(storyEntryControllerProvider).get(widget.id!);
        setState(() {
          item = result;
          selectedType = StoryEntryType.values.byName(result.type);
        });
      });
    }
    super.initState();
  }

  List<Widget> _buildImageFields() {
    return [
      ImagePickerField(name: "imageUrl", initialValue: item?.imageUrl, type: ImageType.characterImage),
    ];
  }

  List<Widget> _buildBookFields() {
    return [];
  }

  Widget _buildIconPicker(Image? image, bool isLoading) {
    return SizedBox(
      width: 125,
      height: 150,
      child: Card(elevation: 4, child: image),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FormBuilder(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderDropdown<StoryEntryType>(
                  name: "type",
                  isExpanded: true,
                  valueTransformer: (value) => value.toString(),
                  initialValue: selectedType,
                  onChanged: (value) => setState(() => selectedType = value ?? StoryEntryType.StoryImage),
                  items: StoryEntryType.values.map((e) => DropdownMenuItem<StoryEntryType>(value: e, child: Text(e.getTitle(context)))).toList(),
                ),
                CustomtextField(name: "title", label: "Titel", initialValue: item?.title),
                Row(
                  children: [
                    ImagePickerField(initialValue: item?.iconUrl, type: ImageType.characterImage, builder: _buildIconPicker),
                    Expanded(child: MultilineTextField(name: "description", initialValue: item?.description, label: "Beschreibung", maxLines: 6)),
                  ],
                ),
                if (StoryEntryType.StoryImage == selectedType) ..._buildImageFields(),
                if (StoryEntryType.StoryBook == selectedType) ..._buildBookFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
