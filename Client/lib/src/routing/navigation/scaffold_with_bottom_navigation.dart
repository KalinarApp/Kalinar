import 'package:flutter/material.dart';

import '../../features/user_management/domain/user.dart';
import 'navigation_item.dart';

class ScaffoldWithBottomNavigation extends StatelessWidget {
  final Widget body;
  final User? currentUser;
  final int currentIndex;
  final List<NavigationItem> tabs;
  final ValueChanged<int> onDestinationSelected;

  const ScaffoldWithBottomNavigation(
      {super.key, required this.body, required this.currentIndex, required this.tabs, required this.onDestinationSelected, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: tabs.length > 1
          ? NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: onDestinationSelected,
              destinations: tabs.map((dest) => NavigationDestination(icon: Icon(dest.icon), label: dest.title)).toList(),
            )
          : null,
    );
  }
}
