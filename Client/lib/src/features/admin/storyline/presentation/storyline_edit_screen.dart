import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../common_widgets/save_button.dart';
import '../../../../utilities/async_value_extension.dart';
import '../application/story_entries_controller.dart';
import '../domain/story_entry.dart';
import '../domain/story_entry_type.dart';
import 'components/book_edit.dart';
import 'components/entry_edit.dart';
import 'components/image_edit.dart';

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
  StoryEntryType selectedType = StoryEntryType.StoryEntry;

  Future<StoryEntry?> _loadItem() async {
    if (null != widget.id) {
      final result = await ref.read(storyEntriesControllerProvider).getById(widget.id!);
      if (!mounted) return null;
      setState(() {
        selectedType = StoryEntryType.values.byName(result.type);
      });
      return result;
    }
    return null;
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
                        onChanged: (value) => setState(() => selectedType = value ?? StoryEntryType.StoryEntry),
                        items:
                            StoryEntryType.values.map((e) => DropdownMenuItem<StoryEntryType>(value: e, child: Text(e.getTitle(context)))).toList(),
                      ),
                      if (StoryEntryType.StoryBook == selectedType) BookEdit(formKey: _formKey, initialValue: item),
                      if (StoryEntryType.StoryImage == selectedType) ImageEdit(formKey: _formKey, initialValue: item),
                      if (StoryEntryType.StoryEntry == selectedType) EntryEdit(formKey: _formKey, initialValue: item),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
