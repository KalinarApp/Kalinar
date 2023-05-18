import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../common_widgets/action_menu.dart';
import '../../../../../../../common_widgets/loading_indicator.dart';
import '../../../../../../../common_widgets/modal.dart';
import '../../../../../../../utilities/async_value_extension.dart';
import '../../../../application/skilltree_controller.dart';
import '../../../../application/skilltree_list_controller.dart';
import '../../../../domain/skilltree_overview.dart';
import '../../../skilltree_builder_screen.dart';
import '../../modals/blueprint_modal.dart';
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
    GoRouter.of(context).goNamed(SkilltreeBuilderScreen.name, queryParameters: {"skilltreeId": item.id});
  }

  Future<void> _showActionDialog(SkilltreeOverview item) async {
    final action = await showActionsModal(context, actions: [
      DialogAction.saveAsBlueprint,
      DialogAction.edit,
      DialogAction.reset,
      DialogAction.delete,
    ]);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _openBuilder(item);
        break;
      case DialogAction.delete:
        await ref.read(skilltreeControllerProvider.notifier).deleteOnServer(item.id);
        break;
      case DialogAction.saveAsBlueprint:
        showModal(context, const BlueprintModal());
        break;
      case DialogAction.reset:
        final result = await ref.read(skilltreeControllerProvider.notifier).resetSkilltree(item.id);
        if (!mounted) return;
        result.showSnackbarOnError(context);
        break;
      default:
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
      delegate: SliverChildBuilderDelegate(
        (context, index) => SkilltreeCharacterItem(
          characters[characters.keys.toList()[index]]!,
          onTap: _openBuilder,
          onLongPress: _showActionDialog,
        ),
        childCount: characters.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(skilltreeListControllerProvider);

    return state.when(
      loading: () => LoadingIndicator(AppLocalizations.of(context)!.fetchSkilltrees),
      error: (error, stackTrace) => Center(child: Text(AppLocalizations.of(context)!.fetchSkilltreesFailed)),
      data: (data) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              _getUnassignedList(data.unassigned),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              _getCharacterGrid(
                data.characters,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
