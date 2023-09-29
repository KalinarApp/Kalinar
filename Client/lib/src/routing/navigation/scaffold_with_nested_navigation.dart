import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/layout/responsive_layout.dart';
import '../../constants/kalinar_icons.dart';
import '../../features/characters/presentation/character_overview_screen.dart';
import '../../features/traits/presentation/traits_overview_screen.dart';
import '../../features/user_management/data/user_repository.dart';
import '../app_route.dart';
import 'navigation_item.dart';
import 'scaffold_with_bottom_navigation.dart';
import 'scaffold_with_rail_navigation.dart';

class ScaffoldWithNestedNavigation extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNestedNavigation({super.key, required this.navigationShell});

  void _goBranch(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getCurrentUserProvider);

    final tabs = [
      NavigationItem(route: AppRoute.home.route, icon: Icons.home, title: (AppLocalizations.of(context)!.home)),
      NavigationItem(route: CharacterOverviewScreen.route, icon: Kalinar.kali, title: (AppLocalizations.of(context)!.characters)),
      // NavigationItem(route: StoryScreen.route, icon: Kalinar.timeline, title: (AppLocalizations.of(context)!.story)),
      NavigationItem(route: TraitsOverviewScreen.route, icon: Kalinar.jigsaw, title: AppLocalizations.of(context)!.traits),
      // if (isAdmin) NavigationItem(route: AdminMenuScreen.route, icon: Kalinar.coffee, title: (AppLocalizations.of(context)!.admin))
    ];

    return ResponsiveLayout(
      mobile: ScaffoldWithBottomNavigation(
        body: navigationShell,
        currentIndex: navigationShell.currentIndex,
        tabs: tabs,
        onDestinationSelected: _goBranch,
        currentUser: user.hasValue ? user.value : null,
      ),
      desktop: ScaffoldWithRailNavigation(
        body: navigationShell,
        tabs: tabs,
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
