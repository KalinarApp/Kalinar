import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/story_entry_repository.dart';
import '../domain/story_entry.dart';
import 'story_entry_list_controller.dart';

class StoryEntryController {
  final StoryEntryRepository repo;
  final StoryEntryListController storyEntrylist;

  StoryEntryController(this.repo, this.storyEntrylist);

  Future<AsyncValue> reorder(String id, int newPosition) async {
    return AsyncValue.guard(() async {
      await repo.reorder(id, newPosition);
      storyEntrylist.refresh();
    });
  }

  Future<AsyncValue> unlock(String id, bool isUnlocked) async {
    return AsyncValue.guard(() async {
      await repo.unlock(id, isUnlocked);
      storyEntrylist.refresh();
    });
  }

  Future<StoryEntry> get(String id) async {
    return await repo.getById(id);
  }

  Future<AsyncValue> create(Map<String, dynamic> data) async {
    final state = await AsyncValue.guard(() async => await repo.createEntry(data));
    await storyEntrylist.refresh();
    return state;
  }

  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    final state = await AsyncValue.guard(() async => await repo.updateEntry(id, data));
    await storyEntrylist.refresh();
    return state;
  }

  // Future<AsyncValue> delete(String id) async {
  //   final state = await AsyncValue.guard(() async => await repo.deleteStoryEntry(id));
  //   await storyEntrylist.refresh();
  //   return state;
  // }
}

final storyEntryControllerProvider = Provider<StoryEntryController>(
    (ref) => StoryEntryController(ref.watch(storyEntryRepositoryProvider), ref.watch(storyEntryListControllerProvider.notifier)));
