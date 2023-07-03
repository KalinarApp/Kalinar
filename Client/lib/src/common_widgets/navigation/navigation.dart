import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../kalinar_icons.dart';
import '../../features/admin/common/presentation/admin_menu_screen.dart';
import '../../features/authentication/application/user_notifier.dart';
import '../../features/characters/presentation/character_overview_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/story/presentation/story_screen.dart';
import '../../features/traits/presentation/traits_overview_screen.dart';
import '../layout/responsive_layout.dart';
import '../layout/size.dart';
import 'desktop_navigation.dart';
import 'mobile_navigation.dart';
import 'navigation_item.dart';

class Navigation extends ConsumerWidget {
  final Widget child;

  const Navigation({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider).user;
    final isAdmin = FirebaseAuth.instance.currentUser?.uid == user?.ownedGroup?.ownerId;

    final tabs = [
      NavigationItem(route: HomeScreen.route, icon: Icons.home, title: (AppLocalizations.of(context)!.home)),
      if (MediaQuery.of(context).size.width <= mobileMaxWidth)
        NavigationItem(route: CharacterOverviewScreen.route, icon: Kalinar.kali, title: (AppLocalizations.of(context)!.characters)),
      NavigationItem(route: StoryScreen.route, icon: Kalinar.timeline, title: (AppLocalizations.of(context)!.story)),
      NavigationItem(route: TraitsOverviewScreen.route, icon: Kalinar.jigsaw, title: AppLocalizations.of(context)!.traits),
      if (isAdmin) NavigationItem(route: AdminMenuScreen.route, icon: Kalinar.coffee, title: (AppLocalizations.of(context)!.admin))
    ];

    return ResponsiveLayout(
      mobile: MobileNavigation(tabs: tabs, child: child),
      desktop: DesktopNavigation(tabs: tabs, child: child),
    );
  }
}
