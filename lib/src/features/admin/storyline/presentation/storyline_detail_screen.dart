import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/admin/storyline/application/story_entry_controller.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry_type.dart';
import 'package:kalinar/src/features/admin/storyline/presentation/components/image_details.dart';
import 'package:kalinar/src/features/admin/storyline/presentation/page_editor_screen.dart';
import 'package:kalinar/src/features/admin/storyline/presentation/storyline_edit_screen.dart';

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
      final result = await ref.read(storyEntryControllerProvider).get(widget.id);
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
        return Container();
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
          Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: null == item ? null : () => GoRouter.of(context).pushNamed(StorylineEditScreen.name, queryParams: {"id": item!.id}),
              ))
        ],
      ),
      body: _buildBody(),
    );
  }
}
