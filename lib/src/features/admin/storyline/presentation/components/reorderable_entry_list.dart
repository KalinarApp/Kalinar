import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utilities/async_value_extension.dart';
import '../../application/story_entry_controller.dart';
import '../../domain/story_entry_overview.dart';
import 'story_list_entry.dart';

class ReorderableEntryList extends ConsumerStatefulWidget {
  final List<StoryEntryOverview> items;
  final Function(String id, bool isUnlocked) unlock;

  const ReorderableEntryList(this.items, {required this.unlock, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReorderableEntryListState();
}

class _ReorderableEntryListState extends ConsumerState<ReorderableEntryList> {
  List<StoryEntryOverview> items = [];

  void unlock(String id, bool isUnlocked) {
    widget.unlock(id, isUnlocked);
    setState(() {
      final index = items.indexWhere((element) => element.id == id);
      final item = items.removeAt(index);
      items.insert(index, item.copyWith(isUnlocked: isUnlocked));
    });
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;

    ref.read(storyEntryControllerProvider).reorder(items[oldIndex].id, newIndex + 1).then((value) => value.showSnackbarOnError(context));

    setState(() {
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  }

  @override
  void didChangeDependencies() {
    setState(() {
      items = widget.items;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => StoryListEntry(items[index], unlock: unlock, key: ValueKey(items[index].id)),
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: const EdgeInsets.all(12),
      onReorder: reorder,
    );
  }
}
