import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/characters/presentation/character_detail_screen.dart';
import 'package:kalinar/src/features/characters/presentation/character_overview_screen.dart';

import '../../features/characters/application/controllers/character_overview_controller.dart';
import '../../features/characters/application/notifier/character_overview_state_notifier.dart';
import '../user_menu.dart';
import 'navigation_item.dart';

class DesktopNavigation extends ConsumerStatefulWidget {
  final Widget child;
  final List<NavigationItem> tabs;

  const DesktopNavigation({required this.child, required this.tabs, super.key});

  @override
  ConsumerState<DesktopNavigation> createState() => _DesktopNavigationState();
}

class _DesktopNavigationState extends ConsumerState<DesktopNavigation> with TickerProviderStateMixin {
  @override
  void initState() {
    Future.delayed(Duration.zero, ref.read(charactersProvider).getAll);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(charactersStateProvider) ?? [];
    items.sortBy((e) => e.name);

    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            hasResizer: false,
            mode: SideMenuMode.compact,
            hasResizerToggle: false,
            builder: (data) {
              return SideMenuData(
                header: const SizedBox(height: 12),
                items: [
                  ...widget.tabs
                      .map(
                        (e) => SideMenuItemDataTile(
                          icon: Icon(e.icon),
                          title: e.title,
                          isSelected: GoRouter.of(context).location == e.route,
                          onTap: () => context.go(e.route),
                          hasSelectedLine: false,
                        ),
                      )
                      .toList(),
                  const SideMenuItemDataDivider(divider: Divider()),
                  ...items.map(
                    (e) => SideMenuItemDataTile(
                      isSelected: GoRouter.of(context).location == "${CharacterOverviewScreen.route}/${e.id}",
                      icon: null != e.iconUrl
                          ? Padding(
                              padding: data.isOpen ? const EdgeInsets.only(right: 8.0) : EdgeInsets.zero,
                              child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(e.iconUrl!)))
                          : null,
                      onTap: () => context.goNamed(CharacterDetailScreen.name, pathParameters: {"id": e.id}),
                      hasSelectedLine: false,
                    ),
                  )
                ],
                footer: Column(
                  children: const [
                    UserMenu(),
                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
          // CharacterList(selectedId: _currentCharacterId, onSelectionChanged: (id) => setState(() => _currentCharacterId = id)),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
