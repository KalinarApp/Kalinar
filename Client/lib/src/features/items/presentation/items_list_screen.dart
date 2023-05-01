import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/items/domain/item_type.dart';

import '../../../utilities/async_value_extension.dart';
import '../application/items_controller.dart';
import 'item_editor_screen.dart';
import 'item_list_item.dart';

class ItemsListScreen extends ConsumerStatefulWidget {
  static const String name = "ItemsList";
  static const route = "items";

  const ItemsListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends ConsumerState<ItemsListScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final value = await ref.read(itemsNotifierProvider.notifier).refresh();
      if (!mounted) return;
      value.showSnackbarOnError(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemsNotifierProvider);

    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spaceBetweenChildren: 8,
        closeDialOnPop: true,
        renderOverlay: false,
        children: ItemType.values
            .map((e) => SpeedDialChild(
                label: e.getTitle(context),
                child: e.getIcon(),
                onTap: () => GoRouter.of(context).pushNamed(ItemEditorScreen.name, queryParams: {"type": e.name})))
            .toList(),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text("Items verwalten")),
          SliverList(delegate: SliverChildBuilderDelegate((context, index) => ItemListItem(items[index]), childCount: items.length)),
        ],
      ),
    );
  }
}
