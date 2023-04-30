import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/common_widgets/user_menu.dart';

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
    final tab = AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).canvasColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        onTap: _onItemTapped,
        tabs: widget.tabs.map((e) => Tab(icon: Icon(e.icon))).toList(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: tab,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: const [Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu())],
      ),
      body: widget.child,
    );
  }
}
