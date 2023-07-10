import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/features/characters/application/notifier/ordered_character_overview_state_notifier.dart';

import '../../features/characters/application/controllers/character_overview_controller.dart';
import '../../features/characters/application/notifier/character_overview_state_notifier.dart';
import '../../features/characters/presentation/character_detail_screen.dart';
import '../../features/characters/presentation/character_overview_screen.dart';
import '../expandable.dart';
import '../user_menu.dart';
import 'desktop_navigation_item.dart';
import 'navigation_item.dart';

class DesktopNavigation extends HookConsumerWidget {
  final Widget child;
  final List<NavigationItem> tabs;

  const DesktopNavigation({required this.child, required this.tabs, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(orderedCharactersStateProvider);

    final selectedOrFirst = tabs.where((element) => GoRouter.of(context).location == element.route).firstOrNull ?? tabs.first;

    ref.listen(charactersStateProvider, (_, characters) {
      ref.read(orderedCharactersStateProvider.notifier).load(characters);
    });

    useEffect(() {
      ref.read(charactersProvider).getAll();
      return;
    }, [const ValueKey(null)]);

    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            minWidth: 60,
            hasResizer: false,
            mode: SideMenuMode.compact,
            hasResizerToggle: false,
            builder: (data) {
              return SideMenuData(
                header: Column(
                  children: [
                    Expandable(
                      centralizeFirstChild: true,
                      backgroundColor: Theme.of(context).colorScheme.background.withOpacity(.6),
                      onHover: (isOpen) {},
                      firstChild: SizedBox(
                        height: 60,
                        child: DesktopNavigationItem(
                            icon: Icon(selectedOrFirst.icon),
                            isSelected: GoRouter.of(context).location == selectedOrFirst.route,
                            onTap: () => context.go(selectedOrFirst.route)),
                      ),
                      secondChild: Column(
                        children: tabs
                            .whereNot((element) => element == selectedOrFirst)
                            .map(
                              (e) => DesktopNavigationItem(
                                icon: Icon(e.icon),
                                isSelected: GoRouter.of(context).location == e.route,
                                onTap: () => context.go(e.route),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                customChild: ReorderableListView.builder(
                  buildDefaultDragHandles: false,
                  shrinkWrap: true,
                  itemCount: characters.length,
                  onReorder: ref.read(orderedCharactersStateProvider.notifier).reorder,
                  itemBuilder: (context, index) => ReorderableDragStartListener(
                    key: ValueKey(characters[index]),
                    index: index,
                    child: DesktopNavigationItem(
                      isSelected: GoRouter.of(context).location == "${CharacterOverviewScreen.route}/${characters[index].id}",
                      image: null != characters[index].iconUrl ? CachedNetworkImageProvider(characters[index].iconUrl!) : null,
                      onTap: () => context.goNamed(CharacterDetailScreen.name, pathParameters: {"id": characters[index].id}),
                    ),
                  ),
                ),
                footer: Column(
                  children: const [
                    UserMenu(),
                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
