import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common_widgets/navigation/navigation.dart';
import '../../features/authentication/application/user_controller.dart';
import '../../features/authentication/presentation/auth_screen.dart';
import '../../features/group_management/presentation/group_screen.dart';
import '../../features/group_management/presentation/user_invite_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/story/presentation/story_screen.dart';
import 'admin_routes.dart';
import 'character_routes.dart';
import 'traits_routes.dart';

final routeProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();

  final authState = ref.watch(firebaseAuthProvider);

  ref.listen(firebaseAuthProvider, (previous, next) {
    if (next.hasValue && next.value != null) ref.read(userControllerProvider).getCurrentUser();
  });

  return GoRouter(
    initialLocation: AuthScreen.route,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    redirect: (context, state) async {
      if (authState.isLoading || authState.hasError) return null;

      final isAuthenticated = authState.valueOrNull != null;

      final onLoginPage = state.location == AuthScreen.route;

      if (!isAuthenticated && !onLoginPage) return AuthScreen.route;

      if (isAuthenticated && onLoginPage) return HomeScreen.route;
      return null;
    },
    routes: [
      GoRoute(
        name: AuthScreen.name,
        path: AuthScreen.route,
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const AuthScreen()),
      ),
      GoRoute(
        name: GroupScreen.name,
        path: GroupScreen.route,
        // redirect: (context, state) async => groupState.hasGroup ?? true ? HomeScreen.route : null,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const GroupScreen()),
      ),
      GoRoute(
        name: UserInviteScreen.name,
        path: UserInviteScreen.route,
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: UserInviteScreen(state.queryParameters["code"])),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => Navigation(child: child),
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
