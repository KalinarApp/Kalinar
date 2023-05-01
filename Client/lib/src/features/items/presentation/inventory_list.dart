import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kalinar/src/common_widgets/custom_image_button.dart';

import 'inventory_item.dart';

class InventoryList extends ConsumerStatefulWidget {
  const InventoryList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InventoryListState();
}

class _InventoryListState extends ConsumerState<InventoryList> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverToBoxAdapter(
              child: Row(
            children: [
              const Expanded(child: TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search)))),
              CustomImageButton(onPressed: () {}, icon: const Icon(Icons.reorder)),
              CustomImageButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ],
          )),
        ),
        SliverToBoxAdapter(
          child: MasonryGridView.count(
            controller: _controller,
            padding: const EdgeInsets.all(12),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            itemCount: [].length,
            itemBuilder: (context, index) => InventoryItem([][index]),
          ),
        ),
      ],
    );
  }
}
