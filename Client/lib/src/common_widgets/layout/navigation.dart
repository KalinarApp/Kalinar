import 'package:flutter/material.dart';
import 'package:kalinar/src/common_widgets/layout/mobile_navigation.dart';
import 'package:kalinar/src/common_widgets/layout/responsive_layout.dart';

import '../navigation/navigation_item.dart';
import 'desktop_navigation.dart';

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
