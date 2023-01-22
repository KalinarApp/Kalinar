import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/admin/storyline/application/story_entries_state_notifier.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry_overview.dart';

import '../data/story_entry_repository.dart';

class StoryEntriesController {
  final StoryEntryRepository repo;
  final StoryEntriesStateNotifier notifier;

  StoryEntriesController(this.repo, this.notifier);

  Future<StoryEntry> getById(String id) async {
    return await repo.getById(id);
  }

  Future<AsyncValue> getAll() async {
    return await AsyncValue.guard(() async {
      List<StoryEntryOverview> entries = await repo.getAll();
      notifier.refresh(entries);
    });
  }

  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      StoryEntryOverview entry = await repo.createEntry(data);
      notifier.add(entry);
    });
  }

  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      StoryEntryOverview entry = await repo.updateEntry(id, data);
      notifier.update(id, entry);
    });
  }

  Future<AsyncValue> reorder(String id, int newPosition) async {
    return await AsyncValue.guard(() async {
      notifier.updatePosition(id, newPosition);
      await repo.reorder(id, newPosition);
    });
  }

  Future<AsyncValue> unlock(String id, bool isUnlocked) async {
    final state = await AsyncValue.guard(() async {
      notifier.unlock(id, isUnlocked);
      await repo.unlock(id, isUnlocked);
    });

    if (state.hasError) {
      notifier.unlock(id, !isUnlocked);
    }
    return state;
  }

  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      notifier.remove(id);
      await repo.deleteEntry(id);
    });
  }
}

final storyEntriesControllerProvider = Provider<StoryEntriesController>(
    (ref) => StoryEntriesController(ref.watch(storyEntryRepositoryProvider), ref.watch(storyEntriesStateNotifierProvider.notifier)));
