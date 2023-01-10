import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/admin/storyline/application/book_state_notifier.dart';
import 'package:kalinar/src/features/admin/storyline/data/story_book_repository.dart';
import 'package:kalinar/src/features/admin/storyline/data/story_entry_repository.dart';
import 'package:kalinar/src/features/admin/storyline/domain/book_page.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry.dart';

class BookPageController {
  final StoryEntryRepository entryRepo;
  final StoryBookRepository repo;
  final BookStateNotifier notifier;

  BookPageController(this.entryRepo, this.repo, this.notifier);

  Future<AsyncValue> getBook(String bookId) async {
    return await AsyncValue.guard(() async {
      StoryEntry entry = await entryRepo.getById(bookId);
      notifier.refresh(entry);
      return entry;
    });
  }

  Future<AsyncValue> create(String bookId, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      BookPage page = await repo.createPage(bookId, data);
      notifier.add(page);
    });
  }

  Future<AsyncValue> reorder(String bookId, String id, int newPosition) async {
    final state = await AsyncValue.guard(() async {
      notifier.updatePosition(id, newPosition);
      await repo.updatePageNumber(bookId, id, newPosition);
    });

    // if (state.hasError) {
    //   await getBook(bookId);
    // }

    return state;
  }

  Future<AsyncValue> update(String bookId, String pageId, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      BookPage page = await repo.updatePage(bookId, pageId, data);
      notifier.update(pageId, page);
    });
  }

  Future<AsyncValue> updateWrittenState(String bookId, String pageId, bool isWritten) async {
    final state = await AsyncValue.guard(() async {
      await repo.updateWrittenState(bookId, pageId, isWritten);
      notifier.updateWrittenState(pageId, isWritten);
    });

    if (state.hasError) {
      notifier.updateWrittenState(pageId, !isWritten);
    }

    return state;
  }

  Future<AsyncValue> delete(String bookId, String pageId) async {
    return await AsyncValue.guard(() async {
      await repo.deletePage(bookId, pageId);
      notifier.delete(pageId);
    });
  }

  // Future<AsyncValue> reorder(String id, int newPosition) async {
  //   return AsyncValue.guard(() async {
  //     await repo.reorder(id, newPosition);
  //     storyEntrylist.refresh();
  //   });
  // }

  // Future<AsyncValue> unlock(String id, bool isUnlocked) async {
  //   return AsyncValue.guard(() async {
  //     await repo.unlock(id, isUnlocked);
  //     storyEntrylist.refresh();
  //   });
  // }

  // Future<> getAllPages(String bookId) async {
  //   return await AsyncValue.guard(() async => await repo.getAllPages(bookId));
  // }

  // Future<AsyncValue> create(String bookId, Map<String, dynamic> data) async {
  //   final state = await AsyncValue.guard(() async => await repo.createPage(data));
  //   await storyEntrylist.refresh();
  //   return state;
  // }

  // Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
  //   final state = await AsyncValue.guard(() async => await repo.updateEntry(id, data));
  //   await storyEntrylist.refresh();
  //   return state;
  // }

  // Future<AsyncValue> delete(String id) async {
  //   final state = await AsyncValue.guard(() async => await repo.deleteEntry(id));
  //   await storyEntrylist.refresh();
  //   return state;
  // }
}

final storyBookControllerProvider = Provider<BookPageController>((ref) => BookPageController(
    ref.watch(storyEntryRepositoryProvider), ref.watch(storyBookRepositoryProvider), ref.watch(bookStateNotifierProvider.notifier)));
