import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/admin/storyline/application/story_entries_controller.dart';
import 'package:kalinar/src/features/admin/storyline/presentation/components/book_details.dart';
import 'package:kalinar/src/features/admin/storyline/presentation/components/entry_details.dart';

import '../domain/story_entry.dart';
import '../domain/story_entry_type.dart';
import 'components/image_details.dart';
import 'page_editor_screen.dart';
import 'storyline_edit_screen.dart';

class StorylineDetailScreen extends ConsumerStatefulWidget {
  static const String name = "StorylineDetail";
  static const String route = ":id";

  final String id;

  const StorylineDetailScreen(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoryImageDetailScreenState();
}

class _StoryImageDetailScreenState extends ConsumerState<StorylineDetailScreen> {
  StoryEntry? item;

  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero, () async {
      final result = await ref.read(storyEntriesControllerProvider).getById(widget.id);
      setState(() => item = result);
    });
    super.didChangeDependencies();
  }

  Widget _buildBody() {
    if (null == item) {
      return const Center(child: CircularProgressIndicator());
    }

    StoryEntryType type = StoryEntryType.values.byName(item!.type);
    switch (type) {
      case StoryEntryType.StoryImage:
        return ImageDetails(item!);
      case StoryEntryType.StoryBook:
        return BookDetails(item!);
      case StoryEntryType.StoryEntry:
        return EntryDetails(item!);
    }
  }

  Future _deleteOnApproval() async {
    final shouldDelete = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.entryDelete),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(AppLocalizations.of(ctx)!.cancel)),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(AppLocalizations.of(ctx)!.delete)),
        ],
      ),
    );

    if (shouldDelete) {
      ref.read(storyEntriesControllerProvider).delete(widget.id);
      if (!mounted) return;
      GoRouter.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null != item && StoryEntryType.StoryBook == StoryEntryType.values.byName(item!.type)
          ? FloatingActionButton(
              onPressed: () => GoRouter.of(context).pushNamed(PageEditorScreen.name, params: {"id": widget.id}),
              child: const Icon(Icons.add),
            )
          : null,
      appBar: AppBar(
        title: null == item ? const CircularProgressIndicator() : Text(item!.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: null == item ? null : () => GoRouter.of(context).pushNamed(StorylineEditScreen.name, queryParams: {"id": item!.id}),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteOnApproval,
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }
}
