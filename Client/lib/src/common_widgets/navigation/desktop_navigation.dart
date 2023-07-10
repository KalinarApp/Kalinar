import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';

import '../../features/characters/application/controllers/character_overview_controller.dart';
import '../../features/characters/application/notifier/character_overview_state_notifier.dart';
import '../../features/characters/presentation/character_detail_screen.dart';
import '../../features/characters/presentation/character_overview_screen.dart';
import '../user_menu.dart';
import 'desktop_navigation_item.dart';
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

    final itemWidgets = [
      ...items.map(
        (e) => DesktopNavigationItem(
          isSelected: GoRouter.of(context).location == "${CharacterOverviewScreen.route}/${e.id}",
          image: null != e.iconUrl ? CachedNetworkImageProvider(e.iconUrl!) : null,
          onTap: () => context.goNamed(CharacterDetailScreen.name, pathParameters: {"id": e.id}),
        ),
      )
    ];

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
                    ...widget.tabs
                        .map(
                          (e) => DesktopNavigationItem(
                            icon: Icon(e.icon),
                            isSelected: GoRouter.of(context).location == e.route,
                            onTap: () => context.go(e.route),
                          ),
                        )
                        .toList(),
                    const Divider(),
                  ],
                ),
                customChild: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemWidgets.length,
                  itemBuilder: (context, index) => itemWidgets[index],
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
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
