import 'package:flutter/cupertino.dart';

class ScaffoldWithNavbarItem extends BottomNavigationBarItem {
  ScaffoldWithNavbarItem({required this.initialLocation, required Widget icon, String? label}) : super(icon: icon, label: label);

  final String initialLocation;
}
