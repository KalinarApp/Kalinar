import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../../admin/storyline/domain/book_page.dart';

class PageWidget extends StatelessWidget {
  final BookPage page;

  const PageWidget(this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = QuillController(document: Document.fromJson(jsonDecode(page.content)), selection: const TextSelection.collapsed(offset: 0));

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: QuillEditor.basic(controller: controller, readOnly: true, embedBuilders: FlutterQuillEmbeds.builders()),
    );
  }
}
