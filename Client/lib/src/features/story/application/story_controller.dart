import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../admin/storyline/data/story_entry_repository.dart';
import '../../admin/storyline/domain/story_entry_type.dart';
import '../domain/story_state.dart';

class StoryController extends StateNotifier<AsyncValue<StoryState>> {
  final StoryEntryRepository repo;

  StoryController(this.repo) : super(const AsyncLoading());

  Future refresh() async {
    state = await AsyncValue.guard(() async {
      final all = await repo.getAll(unlockedOnly: true);
      final image = all.where((element) => StoryEntryType.StoryImage == StoryEntryType.values.byName(element.type)).toList();
      final books = all.where((element) => StoryEntryType.StoryBook == StoryEntryType.values.byName(element.type)).toList();

      return StoryState(
        images: image..sort((a, b) => a.order.compareTo(b.order)),
        books: books..sort((a, b) => a.order.compareTo(b.order)),
        history: all.where((element) => !image.contains(element) && !books.contains(element)).toList()..sort((a, b) => a.order.compareTo(b.order)),
      );
    });
  }
}

final storyControllerProvider = StateNotifierProvider<StoryController, AsyncValue<StoryState>>((ref) {
  return StoryController(ref.watch(storyEntryRepositoryProvider));
});
