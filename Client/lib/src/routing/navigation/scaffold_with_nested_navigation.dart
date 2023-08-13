import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/routing/navigation/scaffold_with_rail_navigation.dart';

import '../../common_widgets/layout/responsive_layout.dart';
import 'navigation_item.dart';
import 'scaffold_with_bottom_navigation.dart';

class ScaffoldWithNestedNavigation extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNestedNavigation({super.key, required this.navigationShell});

  void _goBranch(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = [
      NavigationItem(route: '/home', icon: Icons.home, title: (AppLocalizations.of(context)!.home)),
      // if (MediaQuery.of(context).size.width <= mobileMaxWidth)
      //   NavigationItem(route: CharacterOverviewScreen.route, icon: Kalinar.kali, title: (AppLocalizations.of(context)!.characters)),
      // NavigationItem(route: StoryScreen.route, icon: Kalinar.timeline, title: (AppLocalizations.of(context)!.story)),
      // NavigationItem(route: TraitsOverviewScreen.route, icon: Kalinar.jigsaw, title: AppLocalizations.of(context)!.traits),
      // if (isAdmin) NavigationItem(route: AdminMenuScreen.route, icon: Kalinar.coffee, title: (AppLocalizations.of(context)!.admin))
    ];

    return ResponsiveLayout(
      mobile: ScaffoldWithBottomNavigation(
        body: navigationShell,
        currentIndex: navigationShell.currentIndex,
        tabs: tabs,
        onDestinationSelected: _goBranch,
      ),
      desktop: ScaffoldWithRailNavigation(body: navigationShell, tabs: tabs),
    );
  }
}
