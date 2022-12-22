import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/admin/storyline/presentation/storyline_detail_screen.dart';

import '../../domain/story_entry_overview.dart';

class StoryListEntry extends StatelessWidget {
  final StoryEntryOverview item;
  final Function(String id, bool isUnlocked) unlock;

  const StoryListEntry(this.item, {required this.unlock, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      onTap: () => GoRouter.of(context).pushNamed(StorylineDetailScreen.name, params: {"id": item.id}),
      title: Text(item.title),
      subtitle: null != item.description ? Text(item.description!) : null,
      trailing: Platform.isWindows
          ? null
          : InkWell(
              onTap: () => unlock(item.id, !item.isUnlocked),
              borderRadius: BorderRadius.circular(20),
              child: FaIcon(item.isUnlocked ? FontAwesomeIcons.book : FontAwesomeIcons.bookOpen),
            ),
    );
  }
}
