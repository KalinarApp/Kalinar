import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/loading_indicator.dart';

import '../../../../application/skilltree_list_controller.dart';
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: data.unassigned.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => SkilltreeItem(data.unassigned[index]),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.characters.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) => const SkilltreeCharacterItem(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
