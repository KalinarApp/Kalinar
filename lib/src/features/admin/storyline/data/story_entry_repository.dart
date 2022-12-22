import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/base_repository.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../group_management/application/group_notifier.dart';
import '../domain/story_entry.dart';
import '../domain/story_entry_overview.dart';

class StoryEntryRepository extends HeroBaseRepository {
  StoryEntryRepository(super.client, {super.group});

  Future<List<StoryEntryOverview>> getAll() async {
    return await heroGet("/api/story", (response) => List<StoryEntryOverview>.from(response.map((model) => StoryEntryOverview.fromJson(model))));
  }

  Future<StoryEntry> getById(String id) async {
    return await heroGet("/api/story/$id", (response) => StoryEntry.fromJson(response));
  }

  Future createEntry(Map<String, dynamic> data) async {
    return await heroPost("/api/story", data, (response) => true);
  }

  Future updateEntry(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/story/$id", data, (response) => true);
  }

  Future reorder(String id, int newPosition) async {
    await heroPost("/api/story/reorder", {"entityId": id, "position": newPosition}, (response) => true);
  }

  Future unlock(String id, bool isUnlocked) async {
    await heroPost("/api/story/$id/unlock", {"state": isUnlocked}, (response) => true);
  }
}

final storyEntryRepositoryProvider = Provider<StoryEntryRepository>((ref) {
  return StoryEntryRepository(ref.watch(authProvider), group: ref.watch(groupNotifierProvider).group);
});
