import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry_overview.dart';

class StoryEntriesStateNotifier extends StateNotifier<List<StoryEntryOverview>?> {
  StoryEntriesStateNotifier() : super(null);

  void refresh(List<StoryEntryOverview>? list) {
    list?.sort((a, b) => a.order.compareTo(b.order));
    state = list;
  }

  void add(StoryEntryOverview entry) {
    refresh([...state ?? [], entry]);
  }

  void update(String id, StoryEntryOverview updated) {
    final index = state?.indexWhere((element) => element.id == id);

    if (null != index) {
      final list = [...state ?? []];
      list[index] = updated;

      refresh([...list]);
    }
  }

  void updatePosition(String id, int newPosition) {
    var entries = [...state ?? []];
    final index = state?.indexWhere((element) => element.id == id);

    if (null != index) {
      int oldPosition = entries[index].order;
      int lower = min(newPosition, oldPosition);
      int upper = max(newPosition, oldPosition);
      int direction = oldPosition > newPosition ? 1 : -1;

      for (int i = 0; i < entries.length; i++) {
        if (entries[i].order > lower - (direction > 0 ? direction : 0) && entries[i].order < upper - (direction < 0 ? direction : 0)) {
          entries[i] = entries[i].copyWith(order: entries[i].order + direction);
        }
      }

      entries[index] = entries[index].copyWith(order: newPosition);
      refresh([...entries]);
    }
  }

  void unlock(String id, bool isUnlocked) {
    final index = state?.indexWhere((element) => element.id == id);

    if (null != index) {
      var entries = [...state ?? []];
      entries[index] = entries[index].copyWith(isUnlocked: isUnlocked);

      refresh([...entries]);
    }
  }

  void remove(String id) {
    state = state?.where((element) => element.id != id).toList();
  }
}

final storyEntriesStateNotifierProvider = StateNotifierProvider<StoryEntriesStateNotifier, List<StoryEntryOverview>?>((ref) {
  return StoryEntriesStateNotifier();
});
