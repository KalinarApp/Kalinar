import 'package:flutter/material.dart';

import '../../domain/story_entry_overview.dart';
import 'story_list_entry.dart';

class ReorderableEntryList extends StatelessWidget {
  final List<StoryEntryOverview> items;
  final Function(String id, bool isUnlocked) unlock;
  final Function(String id, int newPosition) reorder;

  const ReorderableEntryList(this.items, {required this.unlock, required this.reorder, super.key});

  void _reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;

    reorder(items[oldIndex].id, newIndex + 1);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => StoryListEntry(items[index], unlock: unlock, key: ValueKey(items[index].id)),
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: const EdgeInsets.all(12),
      onReorder: _reorder,
    );
  }
}
