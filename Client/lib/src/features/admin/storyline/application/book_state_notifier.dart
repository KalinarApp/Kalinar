import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/admin/storyline/domain/book_page.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry.dart';

class BookStateNotifier extends StateNotifier<StoryEntry?> {
  BookStateNotifier() : super(null);

  void refresh(StoryEntry? entry) {
    state = entry;
  }

  void add(BookPage page) {
    state = state?.copyWith(pages: [...state?.pages ?? [], page]);
  }

  void update(String pageId, BookPage updated) {
    final index = state?.pages.indexWhere((element) => element.id == pageId);

    if (null != index) {
      var newList = [...state?.pages ?? []];
      newList[index] = updated;
      state = state?.copyWith(pages: [...newList]);
    }
  }

  void updateWrittenState(String pageId, bool isWritten) {
    var pages = [...state?.pages ?? []];
    final index = state?.pages.indexWhere((element) => element.id == pageId);

    if (null != index) {
      pages[index] = pages[index].copyWith(isWritten: isWritten);

      state = state?.copyWith(pages: [...pages]);
    }
  }

  void updatePosition(String pageId, int newPosition) {
    var pages = [...state?.pages ?? []];
    final index = state?.pages.indexWhere((element) => element.id == pageId);

    if (null != index) {
      int oldPosition = pages[index].pageNumber;
      int lower = min(newPosition, oldPosition);
      int upper = max(newPosition, oldPosition);
      int direction = oldPosition > newPosition ? 1 : -1;

      for (int i = 0; i < pages.length; i++) {
        if (pages[i].pageNumber > lower - (direction > 0 ? direction : 0) && pages[i].pageNumber < upper - (direction < 0 ? direction : 0)) {
          pages[i] = pages[i].copyWith(pageNumber: pages[i].pageNumber + direction);
        }
      }

      pages[index] = pages[index].copyWith(pageNumber: newPosition);

      state = state?.copyWith(pages: [...pages]);
    }
  }

  void delete(String pageId) {
    state = state?.copyWith(pages: [...state?.pages.where((element) => element.id != pageId).toList() ?? []]);
  }
}

final bookStateNotifierProvider = StateNotifierProvider<BookStateNotifier, StoryEntry?>((ref) {
  return BookStateNotifier();
});
