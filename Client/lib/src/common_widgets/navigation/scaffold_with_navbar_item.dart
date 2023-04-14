import 'package:flutter/material.dart';

class ScaffoldWithNavbarItem extends BottomNavigationBarItem {
  ScaffoldWithNavbarItem(BuildContext context, {required this.initialLocation, Widget? icon, String? imagePath, String? label})
      : assert(null == icon || null == imagePath),
        super(
          icon: icon ?? Image.asset(imagePath!, height: 24, width: 24, colorBlendMode: BlendMode.srcIn, color: Theme.of(context).iconTheme.color),
          activeIcon: null != imagePath
              ? Image.asset(imagePath, height: 24, width: 24, colorBlendMode: BlendMode.srcIn, color: Theme.of(context).colorScheme.secondary)
              : null,
          label: label,
        );

  final String initialLocation;
}
