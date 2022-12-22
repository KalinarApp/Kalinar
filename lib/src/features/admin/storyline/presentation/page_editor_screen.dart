import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_toolbar/markdown_toolbar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../common_widgets/form_fields/custom_text_field.dart';
import '../../../../common_widgets/save_button.dart';
import '../domain/book_page.dart';

class PageEditorScreen extends ConsumerStatefulWidget {
  static const name = "PageEditor";
  static const route = "pages/edit";

  final String? id;
  final String? bookId;

  const PageEditorScreen(this.id, this.bookId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PageEditorScreenState();
}

class _PageEditorScreenState extends ConsumerState<PageEditorScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();

  final controller = RoundedLoadingButtonController();

  Future _save() async {
    // if (_formKey.currentState?.validate() ?? false) {
    //   _formKey.currentState?.save();
    //   final data = _formKey.currentState?.value;
    //   if (null != data) {
    //     final value = null == widget.id
    //         ? await ref.read(storyEntryControllerProvider).create(data)
    //         : await ref.read(storyEntryControllerProvider).update(widget.id!, data);
    //     if (!mounted) return;
    //     value.showSnackbarOnError(context);
    //     if (value.hasError) {
    //       controller.error();
    //       Future.delayed(const Duration(seconds: 3), controller.reset);
    //     } else {
    //       controller.success();
    //       GoRouter.of(context).pop();
    //     }
    //   } else {
    //     controller.error();
    //     Future.delayed(const Duration(seconds: 3), controller.reset);
    //   }
    // } else {
    //   controller.error();
    //   Future.delayed(const Duration(seconds: 3), controller.reset);
    // }
  }

  Future<BookPage?> _loadItem() async {
    // if (null != widget.id) {
    //   final result = await ref.read(storyEntryControllerProvider).get(widget.id!);
    //   setState(() {
    //     selectedType = StoryEntryType.values.byName(result.type);
    //   });
    //   return result;
    // }
    return null;
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
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomtextField(name: "title", label: "Titel", initialValue: item?.title),
                    const SizedBox(height: 10),
                    const Expanded(child: MarkdownToolbar(useIncludedTextField: true, height: 32, width: 32, iconSize: 24)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
