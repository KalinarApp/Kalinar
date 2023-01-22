import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/text.dart' as text;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/common_widgets/content_tab.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../common_widgets/save_button.dart';
import '../../../../utilities/async_value_extension.dart';
import '../application/book_controller.dart';
import '../application/book_state_notifier.dart';
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

class _PageEditorScreenState extends ConsumerState<PageEditorScreen> with SingleTickerProviderStateMixin {
  static final _formKey = GlobalKey<FormBuilderState>();

  final controller = RoundedLoadingButtonController();
  late final QuillController quillController;

  late final List<ContentTab> tabs;

  Future _save() async {
    try {
      final title = quillController.document.toPlainText().split("\n")[0];
      final shortTitle = title.substring(0, min(title.length, 100));

      final content = jsonEncode(quillController.document.toDelta().toJson());
      final data = {"title": shortTitle, "content": content};

      AsyncValue value;
      if (null != widget.id) {
        value = await ref.read(storyBookControllerProvider).update(widget.bookId!, widget.id!, data);
      } else {
        value = await ref.read(storyBookControllerProvider).create(widget.bookId!, data);
      }

      if (!mounted) return;
      value.showSnackbarOnError(context);

      if (value.hasError) {
        controller.error();
        Future.delayed(const Duration(seconds: 3), controller.reset);
      } else {
        controller.success();
        GoRouter.of(context).pop();
      }
    } catch (error) {
      controller.error();
      Future.delayed(const Duration(seconds: 3), controller.reset);
    }
  }

  Future<BookPage?> _loadItem() async {
    BookPage? page;
    if (null != widget.id) {
      final state = ref.read(bookStateNotifierProvider);
      if (state?.id != widget.bookId) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: text.Text(AppLocalizations.of(context)!.bookNotFound)));
      }

      page = state?.pages.firstWhere((element) => element.id == widget.id);

      quillController = null == page
          ? QuillController.basic()
          : QuillController(document: Document.fromJson(jsonDecode(page.content)), selection: const TextSelection.collapsed(offset: 0));
    } else {
      quillController = QuillController.basic();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadItem(),
        builder: (context, snapshot) {
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
                    Expanded(
                      child: QuillEditor.basic(controller: quillController, readOnly: false, embedBuilders: FlutterQuillEmbeds.builders()),
                    ),
                    QuillToolbar.basic(controller: quillController, embedButtons: FlutterQuillEmbeds.buttons()),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
