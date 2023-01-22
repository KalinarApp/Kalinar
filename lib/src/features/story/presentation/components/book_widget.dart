import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common_widgets/custom_image_button.dart';
import '../../../../common_widgets/loading_indicator.dart';
import '../../../admin/storyline/domain/book_page.dart';
import '../../application/book_controller.dart';
import 'book_content_table_widget.dart';
import 'page_widget.dart';

class BookWidget extends ConsumerStatefulWidget {
  final String bookId;

  const BookWidget(this.bookId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookState();
}

class _BookState extends ConsumerState<BookWidget> {
  int currentPage = 0;
  int length = 0;

  void changePage(int newPage) {
    if (newPage >= 0 && newPage < length) {
      setState(() => currentPage = newPage);
    }
  }

  @override
  void didChangeDependencies() {
    setState(() => currentPage = 0);
    ref.read(bookControllerProvider.notifier).refresh(widget.bookId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: state.when(
        data: (data) {
          List<BookPage> pages = [...data.pages]..sort((a, b) => a.pageNumber.compareTo(b.pageNumber));
          final newLength = pages.length + 1;

          if (0 == length || length != newLength) setState(() => length = newLength);

          return Column(children: [
            Expanded(
              child: 0 == currentPage ? BookContentTableWidget(pages, onPageSelected: changePage) : PageWidget(pages[currentPage - 1]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageButton(
                    icon: const FaIcon(FontAwesomeIcons.arrowLeft), onPressed: 0 < currentPage ? () => changePage(currentPage - 1) : null),
                CustomImageButton(icon: const FaIcon(FontAwesomeIcons.house), onPressed: 0 < currentPage ? () => changePage(0) : null),
                CustomImageButton(
                    icon: const FaIcon(FontAwesomeIcons.arrowRight), onPressed: length - 1 > currentPage ? () => changePage(currentPage + 1) : null),
              ],
            )
          ]);
        },
        error: (error, stackTrace) => Center(child: Text(AppLocalizations.of(context)!.bookLoadingFailed)),
        loading: () => LoadingIndicator(AppLocalizations.of(context)!.bookLoading),
      ),
    );
  }
}
