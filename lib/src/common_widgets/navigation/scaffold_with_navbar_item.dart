import 'package:flutter/cupertino.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ScaffoldWithNavbarItem extends SalomonBottomBarItem {
  ScaffoldWithNavbarItem({required this.initialLocation, required Widget icon, required Widget label, required Color color})
      : super(icon: icon, title: label, selectedColor: color);

  final String initialLocation;
}
