import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/admin/storyline/application/story_entry_controller.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry_type.dart';
import 'package:kalinar/src/features/admin/storyline/presentation/components/image_details.dart';
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
  void initState() {
    Future.delayed(Duration.zero, () async {
      final result = await ref.read(storyEntryControllerProvider).get(widget.id);
      setState(() => item = result);
    });

    super.initState();
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
