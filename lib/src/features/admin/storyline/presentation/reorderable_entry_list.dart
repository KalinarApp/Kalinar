import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/features/admin/storyline/presentation/story_list_entry.dart';

import '../../../../utilities/async_value_extension.dart';
import '../application/story_entry_controller.dart';
import '../domain/story_entry_overview.dart';

class ReorderableEntryList extends ConsumerStatefulWidget {
  final List<StoryEntryOverview> items;

  const ReorderableEntryList(this.items, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReorderableEntryListState();
}

class _ReorderableEntryListState extends ConsumerState<ReorderableEntryList> {
  List<StoryEntryOverview> items = [];

  @override
  void initState() {
    items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => StoryListEntry(items[index], key: ValueKey(items[index].id)),
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) newIndex -= 1;

        ref.read(storyEntryControllerProvider).reorder(items[oldIndex].id, newIndex + 1).then((value) => value.showSnackbarOnError(context));

        setState(() {
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
        });
      },
    );
  }
}
