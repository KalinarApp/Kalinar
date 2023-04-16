import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/kalinar_icons.dart';
import 'package:side_navigation/side_navigation.dart';

import 'navigation_item.dart';

class ScaffoldWithNavbar extends StatefulWidget {
  final Widget child;
  final List<NavigationItem> tabs;

  const ScaffoldWithNavbar({required this.child, required this.tabs, super.key});

  @override
  State<ScaffoldWithNavbar> createState() => _ScaffoldWithNavbarState();
}

class _ScaffoldWithNavbarState extends State<ScaffoldWithNavbar> {
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index = widget.tabs.indexWhere((t) => location.startsWith(t.route));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].route);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).canvasColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        bottomNavigationBar: isMobile
            ? BottomNavigationBar(
                items: widget.tabs.map((e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.title)).toList(),
                currentIndex: _currentIndex,
                useLegacyColorScheme: false,
                onTap: (value) => _onItemTapped(context, value),
              )
            : null,
        body: isMobile
            ? widget.child
            : Row(
                children: [
                  SideNavigationBar(
                    selectedIndex: _currentIndex,
                    theme: SideNavigationBarTheme(
                      dividerTheme: SideNavigationBarDividerTheme.standard(),
                      itemTheme: SideNavigationBarItemTheme.standard(),
                      togglerTheme: SideNavigationBarTogglerTheme.standard(),
                      backgroundColor: null,
                    ),
                    header: SideNavigationBarHeader(
                      image: const Icon(Kalinar.kali, size: 32),
                      title: Text("Kalinar", style: Theme.of(context).textTheme.titleLarge),
                      subtitle: Container(),
                    ),
                    items: widget.tabs.map((e) => SideNavigationBarItem(icon: e.icon, label: e.title)).toList(),
                    onTap: (value) => _onItemTapped(context, value),
                  ),
                  Expanded(child: widget.child),
                ],
              ),
      ),
    );
  }
}
