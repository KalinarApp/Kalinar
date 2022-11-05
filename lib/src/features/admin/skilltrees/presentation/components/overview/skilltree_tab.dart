import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/features/admin/skilltrees/application/skilltree_controller.dart';
import 'package:hero/src/features/admin/skilltrees/presentation/skilltree_builder_screen.dart';

import '../../../../../../common_widgets/loading_indicator.dart';
import '../../../application/skilltree_list_controller.dart';
import '../../../domain/skilltree_overview.dart';
import '../menu/action_menu.dart';
import 'skilltree_character_item.dart';
import 'skilltree_item.dart';

class SkilltreeTab extends ConsumerStatefulWidget {
  const SkilltreeTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkilltreeTabState();
}

class _SkilltreeTabState extends ConsumerState<SkilltreeTab> {
  Future<void> _onRefresh() async {
    await ref.read(skilltreeListControllerProvider.notifier).getAllSkilltrees();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, _onRefresh);
    super.initState();
  }

  void _openBuilder(SkilltreeOverview item) {
    GoRouter.of(context).goNamed(SkilltreeBuilderScreen.name, queryParams: {"id": item.id});
  }

  Future<void> _showActionDialog(SkilltreeOverview item) async {
    final action = await showActionsModal(context);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _openBuilder(item);
        break;
      case DialogAction.delete:
        await ref.read(skilltreeControllerProvider.notifier).deleteOnServer(item.id);
        break;
      case DialogAction.cancel:
        break;
    }
  }

  SliverList _getUnassignedList(List<SkilltreeOverview> items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => SkilltreeItem(
                items[index],
                onPress: _openBuilder,
                onLongPress: _showActionDialog,
              ),
          childCount: items.length),
    );
  }

  SliverGrid _getCharacterGrid(Map<String, List<SkilltreeOverview>> characters) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate((context, index) => const SkilltreeCharacterItem(), childCount: characters.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(skilltreeListControllerProvider);

    return state.when(
      loading: () => const LoadingIndicator("Skillbäume werden abgerufen"),
      error: (error, stackTrace) => const Center(child: Text("Fehler beim Laden der Daten.")),
      data: (data) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              _getUnassignedList(data.unassigned),
              _getCharacterGrid(data.characters),
            ],
          ),
        ),
      ),
    );
  }
}
