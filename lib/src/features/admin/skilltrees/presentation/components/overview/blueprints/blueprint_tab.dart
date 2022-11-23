import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../common_widgets/action_menu.dart';
import '../../../../../../../common_widgets/loading_indicator.dart';
import '../../../../application/blueprint_controller.dart';
import '../../../../application/blueprint_list_controller.dart';
import '../../../../application/skilltree_controller.dart';
import '../../../../domain/blueprint_overview.dart';
import '../../../skilltree_builder_screen.dart';

import 'blueprint_item.dart';

class BlueprintTab extends ConsumerStatefulWidget {
  const BlueprintTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlueprintTabState();
}

class _BlueprintTabState extends ConsumerState<BlueprintTab> {
  Future<void> _onRefresh() async {
    await ref.read(blueprintListControllerProvider.notifier).getAllBlueprints();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, _onRefresh);
    super.initState();
  }

  void _openBuilder(BlueprintOverview item, {bool asNew = false}) {
    GoRouter.of(context).goNamed(SkilltreeBuilderScreen.name, queryParams: asNew ? {"blueprintId": item.id, "asNew": ""} : {"blueprintId": item.id});
  }

  Future<void> _showBlueprintActionDialog(BlueprintOverview item) async {
    final action = await showActionsModal(context, actions: [DialogAction.loadAsNewSkilltree, DialogAction.edit, DialogAction.delete]);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _openBuilder(item);
        break;
      case DialogAction.delete:
        await ref.read(blueprintControllerProvider).delete(item.id);
        break;
      case DialogAction.cancel:
        break;
      case DialogAction.loadAsNewSkilltree:
        _openBuilder(item, asNew: true);
        break;
      case DialogAction.saveAsBlueprint:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(blueprintListControllerProvider);

    return state.when(
      loading: () => LoadingIndicator(AppLocalizations.of(context)!.fetchBlueprints),
      error: (error, stackTrace) => Center(child: Text(AppLocalizations.of(context)!.fetchBlueprintsFailed)),
      data: (data) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => BlueprintItem(data[index], onPress: _openBuilder, onLongPress: _showBlueprintActionDialog),
                  childCount: data.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
