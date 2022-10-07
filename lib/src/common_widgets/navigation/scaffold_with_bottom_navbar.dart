import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/common_widgets/navigation/scaffold_with_navbar_item.dart';

class ScaffoldWithBottomNavbar extends StatefulWidget {
  final Widget child;
  final List<ScaffoldWithNavbarItem> tabs;

  const ScaffoldWithBottomNavbar({required this.child, required this.tabs, super.key});

  @override
  State<ScaffoldWithBottomNavbar> createState() => _ScaffoldWithBottomNavbarState();
}

class _ScaffoldWithBottomNavbarState extends State<ScaffoldWithBottomNavbar> {
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index = widget.tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    // Only navigate if the tab index has changed
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: widget.tabs,
        onTap: (value) => _onItemTapped(context, value),
      ),
    );
  }
}
