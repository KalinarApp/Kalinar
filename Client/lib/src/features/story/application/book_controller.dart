import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../admin/storyline/data/story_entry_repository.dart';
import '../../admin/storyline/domain/story_entry.dart';

class BookController extends StateNotifier<AsyncValue<StoryEntry>> {
  final StoryEntryRepository repo;

  BookController(this.repo) : super(const AsyncLoading());

  Future refresh(String id) async {
    state = await AsyncValue.guard(() async => await repo.getById(id));
  }
}

final bookControllerProvider = StateNotifierProvider<BookController, AsyncValue<StoryEntry>>((ref) {
  return BookController(ref.watch(storyEntryRepositoryProvider));
});
