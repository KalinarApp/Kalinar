import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/custom_icon_button.dart';
import '../../application/controllers/character_controller.dart';
import '../../application/controllers/character_overview_controller.dart';
import '../../application/notifier/character_overview_state_notifier.dart';
import '../character_detail_screen.dart';

class CharacterList extends ConsumerStatefulWidget {
  final String? selectedId;
  final Function(String id)? onSelectionChanged;

  const CharacterList({this.onSelectionChanged, this.selectedId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterListState();
}

class _CharacterListState extends ConsumerState<CharacterList> {
  final _menuController = SideMenuController();

  String? query;

  @override
  void initState() {
    ref.read(charactersProvider).getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(charactersStateProvider) ?? [];
    items.sortBy((e) => e.name);
    final currentIndex = items.indexWhere((element) => widget.selectedId == element.id);

    final filteredItems = query?.isEmpty ?? true ? items : items.where((element) => element.name.contains(query!)).toList();

    return SideMenu(
      controller: _menuController,
      hasResizer: false,
      hasResizerToggle: false,
      builder: (data) {
        return SideMenuData(
            header: const Padding(padding: EdgeInsets.only(top: 8.0, bottom: 20), child: CircleAvatar(backgroundColor: Colors.transparent)),
            items: filteredItems
                .map(
                  (e) => SideMenuItemDataTile(
                      icon: null != e.iconUrl
                          ? Padding(
                              padding: data.isOpen ? const EdgeInsets.only(right: 8.0) : EdgeInsets.zero,
                              child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(e.iconUrl!)))
                          : null,
                      title: e.name,
                      hasSelectedLine: false,
                      isSelected: currentIndex >= 0 && filteredItems[currentIndex].id == e.id,
                      onTap: () {
                        final item = filteredItems[filteredItems.indexOf(e)];
                        widget.onSelectionChanged?.call(item.id);
                        ref.read(characterControllerProvider).get(item.id);

                        GoRouter.of(context).goNamed(CharacterDetailScreen.name, pathParameters: {"id": item.id});
                      }),
                )
                .toList(),
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomIconButton(onTap: _menuController.toggle, icon: data.isOpen ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios_outlined)
              ],
            ));
      },
    );
  }
}
