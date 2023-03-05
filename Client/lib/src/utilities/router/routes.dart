import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/story/presentation/story_screen.dart';
import 'package:kalinar/src/features/traits/presentation/traits_overview_screen.dart';
import 'package:kalinar/src/utilities/router/traits_routes.dart';

import '../../common_widgets/navigation/scaffold_with_bottom_navbar.dart';
import '../../common_widgets/navigation/scaffold_with_navbar_item.dart';
import '../../features/admin/common/presentation/admin_menu_screen.dart';
import '../../features/authentication/presentation/auth_screen.dart';
import '../../features/group_management/application/group_controller.dart';
import '../../features/group_management/application/group_notifier.dart';
import '../../features/group_management/presentation/group_screen.dart';
import '../../features/group_management/presentation/user_invite_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/home/presentation/welcome_screen.dart';
import 'admin_routes.dart';
import 'character_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final routeProvider = Provider<GoRouter>((ref) {
  ref.listen(firebaseAuthProvider, (previous, next) {
    if (next.valueOrNull != null) {
      ref.read(groupControllerProvider).check();
    }
  });

  final authState = ref.watch(firebaseAuthProvider);
  final groupState = ref.watch(groupNotifierProvider);

  return GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
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
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: UserInviteScreen(state.queryParams["code"])),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          final isAdmin = FirebaseAuth.instance.currentUser?.uid == groupState.group?.ownerId;
          return ScaffoldWithBottomNavbar(
            tabs: [
              ScaffoldWithNavbarItem(
                initialLocation: HomeScreen.route,
                icon: const Icon(Icons.home),
                label: (AppLocalizations.of(context)!.home),
              ),
              ScaffoldWithNavbarItem(
                initialLocation: "/characters",
                icon: const Icon(Icons.man),
                label: (AppLocalizations.of(context)!.characters),
              ),
              ScaffoldWithNavbarItem(
                initialLocation: StoryScreen.route,
                icon: const Icon(Icons.book),
                label: (AppLocalizations.of(context)!.story),
              ),
              ScaffoldWithNavbarItem(
                initialLocation: TraitsOverviewScreen.route,
                icon: const FaIcon(Icons.featured_video_sharp),
                label: AppLocalizations.of(context)!.traits,
              ),
              if (isAdmin)
                ScaffoldWithNavbarItem(
                  initialLocation: AdminMenuScreen.route,
                  icon: const Icon(Icons.coffee),
                  label: (AppLocalizations.of(context)!.admin),
                ),
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
          characterRoutes,
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
