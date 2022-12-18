import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:kalinar/src/features/admin/storyline/domain/story_entry_overview.dart';

class StoryListEntry extends StatelessWidget {
  final StoryEntryOverview item;

  const StoryListEntry(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Icon(FontAwesomeIcons.bookTanakh)],
      ),
      title: Text(item.title),
      subtitle: null != item.description ? Text(item.description!) : null,
    );
  }
}
