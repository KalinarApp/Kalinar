import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/common_widgets/user_menu.dart';
import 'package:kalinar/src/features/characters/presentation/components/character_list.dart';

import '../navigation/navigation_item.dart';

class DesktopNavigation extends StatefulWidget {
  final Widget child;
  final List<NavigationItem> tabs;

  const DesktopNavigation({required this.child, required this.tabs, super.key});

  @override
  State<DesktopNavigation> createState() => _DesktopNavigationState();
}

class _DesktopNavigationState extends State<DesktopNavigation> with TickerProviderStateMixin {
  late final TabController controller;

  String? _currentCharacterId;

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index = widget.tabs.indexWhere((t) => location.startsWith(t.route));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].route);
    }
  }

  @override
  void initState() {
    controller = TabController(length: widget.tabs.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            hasResizer: false,
            mode: SideMenuMode.compact,
            hasResizerToggle: false,
            builder: (data) {
              return SideMenuData(
                  header: const Padding(
                    padding: EdgeInsets.only(bottom: 20, top: 8),
                    child: UserMenu(),
                  ),
                  items: widget.tabs
                      .map(
                        (e) => SideMenuItemDataTile(
                          icon: Icon(e.icon),
                          title: e.title,
                          isSelected: widget.tabs.indexOf(e) == _currentIndex,
                          onTap: () {
                            _onItemTapped(widget.tabs.indexOf(e));
                            setState(() => _currentCharacterId = null);
                          },
                          hasSelectedLine: false,
                        ),
                      )
                      .toList());
            },
          ),
          CharacterList(selectedId: _currentCharacterId, onSelectionChanged: (id) => setState(() => _currentCharacterId = id)),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
