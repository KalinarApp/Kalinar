import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../navigation/navigation_item.dart';

class MobileNavigation extends StatefulWidget {
  final Widget child;
  final List<NavigationItem> tabs;

  const MobileNavigation({required this.child, required this.tabs, super.key});

  @override
  State<MobileNavigation> createState() => _MobileNavigationState();
}

class _MobileNavigationState extends State<MobileNavigation> with TickerProviderStateMixin {
  late final TabController controller;

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
    controller = TabController(length: widget.tabs.length, vsync: this);
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
        bottomNavigationBar: BottomNavigationBar(
          items: widget.tabs.map((e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.title)).toList(),
          currentIndex: _currentIndex,
          useLegacyColorScheme: false,
          onTap: (value) => _onItemTapped(context, value),
        ),
        body: widget.child,
      ),
    );
  }
}
