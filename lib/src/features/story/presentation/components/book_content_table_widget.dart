import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kalinar/src/features/admin/storyline/domain/book_page.dart';

class BookContentTableWidget extends StatelessWidget {
  final List<BookPage> pages;
  final Function(int index) onPageSelected;

  const BookContentTableWidget(this.pages, {required this.onPageSelected, super.key});

  void selectPage(int index) {
    onPageSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.bookContentTable, style: Theme.of(context).textTheme.titleLarge),
          for (int i = 0; i < pages.length; i++)
            Row(children: [TextButton(child: Text(pages[i].title), onPressed: () => selectPage(i + 1)), const Spacer(), Text("${i + 1}")])
        ],
      ),
    );
  }
}
