import 'package:flutter/material.dart';

import 'desktop_navigation.dart';
import 'mobile_navigation.dart';
import '../layout/responsive_layout.dart';
import 'navigation_item.dart';

class Navigation extends StatelessWidget {
  final Widget child;
  final List<NavigationItem> tabs;

  const Navigation({required this.child, required this.tabs, super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: MobileNavigation(tabs: tabs, child: child),
      desktop: DesktopNavigation(tabs: tabs, child: child),
    );
  }
}
