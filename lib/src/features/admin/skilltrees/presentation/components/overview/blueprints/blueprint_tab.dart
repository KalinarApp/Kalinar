import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/loading_indicator.dart';
import 'package:hero/src/features/admin/skilltrees/application/blueprint_list_controller.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hero/src/features/admin/skilltrees/presentation/components/overview/blueprints/blueprint_item.dart';

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
                  (context, index) => BlueprintItem(data[index], onPress: (item) {}, onLongPress: (item) {}),
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
