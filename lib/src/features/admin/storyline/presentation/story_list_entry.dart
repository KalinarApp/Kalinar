import 'package:flutter/material.dart';

import 'package:kalinar/src/features/admin/storyline/domain/story_entry_overview.dart';

class StoryListEntry extends StatelessWidget {
  final StoryEntryOverview item;

  const StoryListEntry(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          key: key,
          title: Text(item.title),
        ),
        const Divider(),
      ],
    );
  }
}
