import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/story_entry_repository.dart';
import '../domain/story_entry_overview.dart';

class StoryEntryListController extends StateNotifier<AsyncValue<List<StoryEntryOverview>>> {
  final StoryEntryRepository repo;

  StoryEntryListController(this.repo) : super(const AsyncLoading());

  Future<void> getAll() async {
    state = const AsyncLoading();
    await refresh();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async => await repo.getAll());
  }
}

final storyEntryListControllerProvider = StateNotifierProvider<StoryEntryListController, AsyncValue<List<StoryEntryOverview>>>(
    (ref) => StoryEntryListController(ref.watch(storyEntryRepositoryProvider)));
