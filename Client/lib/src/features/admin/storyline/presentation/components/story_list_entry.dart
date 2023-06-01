import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../domain/story_entry_overview.dart';
import '../storyline_detail_screen.dart';

class StoryListEntry extends StatelessWidget {
  final StoryEntryOverview item;
  final Function(String id, bool isUnlocked) unlock;

  const StoryListEntry(this.item, {required this.unlock, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      onTap: () => GoRouter.of(context).pushNamed(StorylineDetailScreen.name, pathParameters: {"id": item.id}),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          child: IconButton(
            icon: FaIcon(item.isUnlocked ? FontAwesomeIcons.bookOpen : FontAwesomeIcons.book),
            onPressed: () => unlock(item.id, !item.isUnlocked),
          ),
        ),
      ),
      title: Text(item.title),
      subtitle: null != item.description ? Text(item.description!.replaceAll(RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'), '\n'), maxLines: 2) : null,
    );
  }
}
