import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../kalinar_icons.dart';
import '../../common_widgets/layout/navigation.dart';
import '../../common_widgets/layout/size.dart';
import '../../common_widgets/navigation/navigation_item.dart';
import '../../features/admin/common/presentation/admin_menu_screen.dart';
import '../../features/authentication/presentation/auth_screen.dart';
import '../../features/characters/presentation/character_overview_screen.dart';
import '../../features/group_management/application/group_controller.dart';
import '../../features/group_management/application/group_notifier.dart';
import '../../features/group_management/presentation/group_screen.dart';
import '../../features/group_management/presentation/user_invite_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/home/presentation/welcome_screen.dart';
import '../../features/story/presentation/story_screen.dart';
import '../../features/traits/presentation/traits_overview_screen.dart';
import 'admin_routes.dart';
import 'character_routes.dart';
import 'traits_routes.dart';

final routeProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();

  ref.listen(firebaseAuthProvider, (previous, next) {
    if (next.valueOrNull != null) {
      ref.read(groupControllerProvider).check();
    }
  });

  final authState = ref.watch(firebaseAuthProvider);
  final groupState = ref.watch(groupNotifierProvider);

  return GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: kDebugMode,
    navigatorKey: rootNavigatorKey,
    redirect: (context, state) {
      if (authState.isLoading || authState.hasError) return null;

      final isAuthenticated = authState.valueOrNull != null;

      if (state.location == "/") {
        return isAuthenticated ? GroupScreen.route : AuthScreen.route;
      }

      final isLoggedIn = state.location == AuthScreen.route;

      if (isLoggedIn) {
        return isAuthenticated ? GroupScreen.route : null;
      }

      return isAuthenticated ? null : "/";
    },
    routes: [
      GoRoute(
        path: "/",
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const WelcomeScreen()),
      ),
      GoRoute(
        name: AuthScreen.name,
        path: AuthScreen.route,
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const AuthScreen()),
      ),
      GoRoute(
        name: GroupScreen.name,
        path: GroupScreen.route,
        redirect: (context, state) async => groupState.hasGroup ?? true ? HomeScreen.route : null,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const GroupScreen()),
      ),
      GoRoute(
        name: UserInviteScreen.name,
        path: UserInviteScreen.route,
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: UserInviteScreen(state.queryParameters["code"])),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          final isAdmin = FirebaseAuth.instance.currentUser?.uid == groupState.group?.ownerId;
          return Navigation(
            tabs: [
              NavigationItem(route: HomeScreen.route, icon: Icons.home, title: (AppLocalizations.of(context)!.home)),
              if (MediaQuery.of(context).size.width <= mobileMaxWidth)
                NavigationItem(route: CharacterOverviewScreen.route, icon: Kalinar.kali, title: (AppLocalizations.of(context)!.characters)),
              NavigationItem(route: StoryScreen.route, icon: Kalinar.timeline, title: (AppLocalizations.of(context)!.story)),
              NavigationItem(route: TraitsOverviewScreen.route, icon: Kalinar.jigsaw, title: AppLocalizations.of(context)!.traits),
              if (isAdmin) NavigationItem(route: AdminMenuScreen.route, icon: Kalinar.coffee, title: (AppLocalizations.of(context)!.admin)),
            ],
            child: child,
          );
        },
        routes: [
          GoRoute(
            name: HomeScreen.name,
            path: HomeScreen.route,
            pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const HomeScreen()),
          ),
          GoRoute(
            path: "/profile",
            name: "Profile",
            pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ProfileScreen()),
          ),
          adminRoutes,
          getCharacterRoutes(ref),
          traitsRoutes,
          GoRoute(
            name: StoryScreen.name,
            path: StoryScreen.route,
            pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const StoryScreen()),
          )
        ],
      ),
    ],
  );
});

final firebaseAuthProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
