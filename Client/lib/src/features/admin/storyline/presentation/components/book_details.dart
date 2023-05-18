import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common_widgets/action_menu.dart';
import '../../../../../common_widgets/custom_image_button.dart';
import '../../../../../common_widgets/loading_indicator.dart';
import '../../../../../utilities/async_value_extension.dart';
import '../../application/book_controller.dart';
import '../../application/book_state_notifier.dart';
import '../../domain/book_page.dart';
import '../../domain/story_entry.dart';
import '../page_editor_screen.dart';

class BookDetails extends ConsumerStatefulWidget {
  final StoryEntry item;
  const BookDetails(this.item, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookDetailsState();
}

class _BookDetailsState extends ConsumerState<BookDetails> {
  Future _refresh() async {
    ref.read(storyBookControllerProvider).getBook(widget.item.id);
  }

  void _editPage(String bookId, String pageId) {
    GoRouter.of(context).pushNamed(PageEditorScreen.name, pathParameters: {"id": bookId}, queryParameters: {"id": pageId});
  }

  void _reorder(String bookId, String pageId, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;

    ref.read(storyBookControllerProvider).reorder(bookId, pageId, newIndex + 1).then((value) => value.showSnackbarOnError(context));
  }

  void _updateWrittenState(String bookId, String pageId, bool isWritten) {
    ref.read(storyBookControllerProvider).updateWrittenState(bookId, pageId, isWritten).then((value) => value.showSnackbarOnError(context));
  }

  void _deletePage(String bookId, String pageId) {
    ref.read(storyBookControllerProvider).delete(bookId, pageId).then((value) {
      value.showSnackbarOnError(context);
    });
  }

  Future<void> _showActionDialog(String bookId, String pageId) async {
    final action = await showActionsModal(context, actions: [DialogAction.edit, DialogAction.delete, DialogAction.cancel]);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _editPage(bookId, pageId);
        break;
      case DialogAction.delete:
        _deletePage(bookId, pageId);
        break;
      default:
        break;
    }
  }

  @override
  void didChangeDependencies() {
    _refresh();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookStateNotifierProvider);

    if (null == state) {
      return LoadingIndicator(AppLocalizations.of(context)!.storyLoading);
    }

    List<BookPage> pages = [...state.pages];
    pages.sort((a, b) => a.pageNumber.compareTo(b.pageNumber));

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ReorderableListView.builder(
        itemCount: pages.length,
        onReorder: (oldIndex, newIndex) => _reorder(pages[oldIndex].bookId, pages[oldIndex].id, oldIndex, newIndex),
        itemBuilder: (context, index) => ListTile(
          key: ValueKey(pages[index].id),
          leading: CustomImageButton(
            icon: FaIcon(pages[index].isWritten ? FontAwesomeIcons.penToSquare : FontAwesomeIcons.square),
            onPressed: () => _updateWrittenState(pages[index].bookId, pages[index].id, !pages[index].isWritten),
          ),
          title: Text(pages[index].title),
          trailing: ReorderableDelayedDragStartListener(index: index, child: const Icon(Icons.drag_handle)),
          onLongPress: () => _showActionDialog(pages[index].bookId, pages[index].id),
          onTap: () => _editPage(pages[index].bookId, pages[index].id),
        ),
      ),
    );
  }
}
