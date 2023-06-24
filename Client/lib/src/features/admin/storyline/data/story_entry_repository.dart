import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/base_repository.dart';
import '../domain/story_entry.dart';
import '../domain/story_entry_overview.dart';

class StoryEntryRepository extends HeroBaseRepository {
  StoryEntryRepository();

  Future<List<StoryEntryOverview>> getAll({bool unlockedOnly = false}) async {
    return await heroGet(
      "/api/story",
      query: {"unlockedOnly": unlockedOnly.toString()},
      (response) => List<StoryEntryOverview>.from(response.map((model) => StoryEntryOverview.fromJson(model))),
    );
  }

  Future<StoryEntry> getById(String id) async {
    return await heroGet("/api/story/$id", (response) => StoryEntry.fromJson(response));
  }

  Future<StoryEntryOverview> createEntry(Map<String, dynamic> data) async {
    return await heroPost("/api/story", data, (response) => StoryEntryOverview.fromJson(response));
  }

  Future<StoryEntryOverview> updateEntry(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/story/$id", data, (response) => StoryEntryOverview.fromJson(response));
  }

  Future reorder(String id, int newPosition) async {
    await heroPost("/api/story/reorder", {"entityId": id, "position": newPosition}, (response) => true);
  }

  Future unlock(String id, bool isUnlocked) async {
    await heroPost("/api/story/$id/unlock", {"state": isUnlocked}, (response) => true);
  }

  Future deleteEntry(String id) async {
    await heroDelete("/api/story/$id");
  }
}

final storyEntryRepositoryProvider = Provider<StoryEntryRepository>((ref) {
  return StoryEntryRepository();
});
