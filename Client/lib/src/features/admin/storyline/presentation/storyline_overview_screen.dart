import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/user_menu.dart';
import '../../../../utils/async_value_extension.dart';
import '../application/story_entries_controller.dart';
import '../application/story_entries_state_notifier.dart';
import 'components/reorderable_entry_list.dart';
import 'storyline_edit_screen.dart';

class StorylineOverviewScreen extends ConsumerStatefulWidget {
  static const String name = "storylineList";
  static const String route = "story";

  const StorylineOverviewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StorylineOverviewScreenState();
}

class _StorylineOverviewScreenState extends ConsumerState<StorylineOverviewScreen> {
  Future _onRefresh() async {
    final value = await ref.read(storyEntriesControllerProvider).getAll();
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _unlock(String id, bool isUnlocked) {
    ref.read(storyEntriesControllerProvider).unlock(id, isUnlocked).then((value) => value.showSnackbarOnError(context));
  }

  void _reorder(String id, int newIndex) {
    ref.read(storyEntriesControllerProvider).reorder(id, newIndex).then((value) => value.showSnackbarOnError(context));
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, _onRefresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storyEntriesStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).pushNamed(StorylineEditScreen.name),
        child: const Icon(Icons.add),
      ),
      body: null == state
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const CircularProgressIndicator(), Text(AppLocalizations.of(context)!.listLoading)],
              ),
            )
          : state.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.listEmpty))
              : RefreshIndicator(onRefresh: _onRefresh, child: ReorderableEntryList(state, unlock: _unlock, reorder: _reorder)),
    );
  }
}
