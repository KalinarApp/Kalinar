import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/base_repository.dart';
import '../domain/book_page.dart';

class StoryBookRepository extends HeroBaseRepository {
  StoryBookRepository();

  // Future<List<BookPage>> getAllPages(String bookId) async {
  //   return await heroGet("/api/story/book/$bookId", (response) => List<BookPage>.from(response.map((model) => BookPage.fromJson(model))));
  // }

  // Future<StoryEntry> getById(String bookId, String pageId) async {
  //   return await heroGet("/api/story/book/$bookId", (response) => StoryEntry.fromJson(response));
  // }

  Future<BookPage> createPage(String bookId, Map<String, dynamic> data) async {
    return await heroPost("/api/story/book/$bookId", data, (response) => BookPage.fromJson(response));
  }

  Future<BookPage> updatePage(String bookId, String pageId, Map<String, dynamic> data) async {
    return await heroUpdate("/api/story/book/$bookId/$pageId", data, (response) => BookPage.fromJson(response));
  }

  Future updatePageNumber(String bookId, String pageId, int position) async {
    return await heroPost("/api/story/book/$bookId/reorder", {"entityId": pageId, "position": position}, (response) => true);
  }

  Future updateWrittenState(String bookId, String pageId, bool isWritten) async {
    return await heroPost("/api/story/book/$bookId/$pageId/unlock", {"state": isWritten}, (response) => true);
  }

  Future deletePage(String bookId, String pageId) async {
    await heroDelete("/api/story/book/$bookId/$pageId");
  }

  // Future reorder(String id, int newPosition) async {
  //   await heroPost("/api/story/reorder", {"entityId": id, "position": newPosition}, (response) => true);
  // }

  // Future unlock(String id, bool isUnlocked) async {
  //   await heroPost("/api/story/$id/unlock", {"state": isUnlocked}, (response) => true);
  // }

  // Future deleteEntry(String id) async {
  //   await heroDelete("/api/story/$id");
  // }
}

final storyBookRepositoryProvider = Provider<StoryBookRepository>((ref) {
  return StoryBookRepository();
});
