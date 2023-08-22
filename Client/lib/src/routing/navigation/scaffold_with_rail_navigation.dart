import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/expandable.dart';
import '../../common_widgets/user_menu.dart';
import '../../features/authentication/data/firebase_auth_repository.dart';
import '../../features/user_management/data/user_repository.dart';
import 'navigation_item.dart';
import 'rail_navigation_item.dart';

class ScaffoldWithRailNavigation extends HookConsumerWidget {
  final Widget body;
  final List<NavigationItem> tabs;

  const ScaffoldWithRailNavigation({required this.body, required this.tabs, super.key});

  // Future _showCharacterContextMenu(BuildContext context, CharacterOverview character, Offset position) async {
  //   final left = position.dx;
  //   final top = position.dy;

  //   await showMenu<String>(
  //     context: context,
  //     position: RelativeRect.fromDirectional(textDirection: Directionality.of(context), start: left, top: top, end: left + 2, bottom: top + 2),
  //     items: const [
  //       PopupMenuItem<String>(value: "Settings", child: Text("Einstellungen")),
  //       PopupMenuDivider(),
  //       PopupMenuItem<String>(value: "Settings", child: Text("Löschen")),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final characters = ref.watch(orderedCharactersStateProvider);

    final selectedOrFirst = tabs.where((element) => GoRouterState.of(context).uri.toString() == element.route).firstOrNull ?? tabs.first;

    // ref.listen(charactersStateProvider, (_, characters) {
    //   ref.read(orderedCharactersStateProvider.notifier).load(characters);
    // });

    // useEffect(() {
    //   ref.read(charactersProvider).getAll();
    //   return;
    // }, [const ValueKey(null)]);

    // TODO: implement loading characters and orders

    final userId = ref.watch(firebaseAuthProvider).currentUser!.uid;
    final user = ref.watch(getUserByIdProvider(userId));

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
                            title: selectedOrFirst.title,
                            icon: Icon(selectedOrFirst.icon),
                            isSelected: GoRouterState.of(context).uri.toString() == selectedOrFirst.route,
                            onTap:
                                GoRouterState.of(context).uri.toString() == selectedOrFirst.route ? null : () => context.go(selectedOrFirst.route)),
                      ),
                      secondChild: Column(
                        children: tabs.whereNot((element) => element == selectedOrFirst).map(
                          (e) {
                            final isRoute = GoRouterState.of(context).uri.toString() == e.route;
                            return DesktopNavigationItem(
                              title: e.title,
                              icon: Icon(e.icon),
                              isSelected: isRoute,
                              onTap: isRoute ? null : () => context.go(e.route),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                customChild: Container(),
                // customChild: ReorderableListView.builder(
                //   buildDefaultDragHandles: false,
                //   shrinkWrap: true,
                //   itemCount: 0,
                //   onReorder: ref.read(orderedCharactersStateProvider.notifier).reorder,
                //   footer: DesktopNavigationItem(
                //     isSelected: false,
                //     title: "Charakter erstellen",
                //     icon: const Icon(Icons.add),
                //     onTap: () => showCharacterEditorDialog(context),
                //   ),
                //   itemBuilder: (context, index) => ReorderableDragStartListener(
                //     key: ValueKey(characters[index]),
                //     index: index,
                //     child: DesktopNavigationItem(
                //       title: characters[index].name,
                //       isSelected: GoRouterState.of(context).uri.toString() == "${CharacterOverviewScreen.route}/${characters[index].id}",
                //       image: null != characters[index].iconUrl ? CachedNetworkImageProvider(characters[index].iconUrl!) : null,
                //       onTap: () => context.goNamed(CharacterDetailScreen.name, pathParameters: {"id": characters[index].id}),
                //       // onSecondaryTap: (details) => _showCharacterContextMenu(context, characters[index], details.globalPosition),
                //     ),
                //   ),
                // ),
                footer: user.hasValue ? const Column(children: [UserMenu(), SizedBox(height: 20)]) : null,
              );
            },
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
