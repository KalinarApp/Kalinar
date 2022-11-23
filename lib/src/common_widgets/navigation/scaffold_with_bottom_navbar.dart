import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'scaffold_with_navbar_item.dart';

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
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].initialLocation);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).canvasColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: SalomonBottomBar(
          items: widget.tabs,
          currentIndex: _currentIndex,
          onTap: (value) => _onItemTapped(context, value),
        ),
      ),
    );
  }
}
