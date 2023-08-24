import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/group_management/presentation/edit_group_dialog.dart';
import 'package:kalinar/src/features/home/presentation/home_screen.dart';
import 'package:kalinar/src/features/user_management/presentation/edit_user_dialog.dart';
import 'package:kalinar/src/routing/app_route.dart';
import 'package:kalinar/src/routing/dialog_page.dart';
import 'package:kalinar/src/routing/go_router_refresh_stream.dart';
import 'package:kalinar/src/routing/navigation/scaffold_with_nested_navigation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/data/firebase_auth_repository.dart';
import '../features/authentication/presentation/custom_sign_in_screen.dart';
import '../features/group_management/domain/group.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _charactersNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'characters');
final _storyNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'story');
final _traitsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'traits');
final _adminNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'admin');

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: AppRoute.signIn.route,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final onLoginPage = state.uri.toString() == AppRoute.signIn.route;

      if (!isLoggedIn && !onLoginPage) return AppRoute.signIn.route;
      if (isLoggedIn && onLoginPage) return AppRoute.home.route;
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: AppRoute.signIn.route,
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const CustomSignInScreen()),
      ),
      GoRoute(
        path: AppRoute.userProfileCreate.route,
        name: AppRoute.userProfileCreate.name,
        pageBuilder: (context, state) => DialogPage(barrierDismissible: false, builder: (_) => const EditUserDialog()),
      ),
      GoRoute(
        path: AppRoute.userProfile.route,
        name: AppRoute.userProfile.name,
        pageBuilder: (context, state) => DialogPage(builder: (_) => const Text("User Profile")),
        routes: const [],
      ),
      GoRoute(
        path: AppRoute.groupList.route,
        name: AppRoute.groupList.name,
        pageBuilder: (context, state) => DialogPage(builder: (_) => const Text("Groups")),
        routes: [
          GoRoute(
            path: AppRoute.groupCreate.route,
            name: AppRoute.groupCreate.name,
            pageBuilder: (context, state) => DialogPage(builder: (_) => const EditGroupDialog()),
          ),
          GoRoute(
            path: AppRoute.groupEdit.route,
            name: AppRoute.groupEdit.name,
            pageBuilder: (context, state) => DialogPage(builder: (_) => EditGroupDialog(group: state.extra! as Group)),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(navigatorKey: _homeNavigatorKey, routes: [
            GoRoute(
                path: AppRoute.home.route,
                name: AppRoute.home.name,
                pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const HomeScreen())),
          ]),
          StatefulShellBranch(
            navigatorKey: _charactersNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.characterList.route,
                name: AppRoute.characterList.name,
                pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const Text('Characters')),
                routes: [
                  GoRoute(
                      path: AppRoute.characterDetails.route,
                      name: AppRoute.characterDetails.name,
                      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const Text('Character Details')),
                      routes: [
                        GoRoute(
                          path: AppRoute.editCharacter.route,
                          name: AppRoute.editCharacter.name,
                          pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const Text('Edit Character')),
                        )
                      ]),
                  GoRoute(
                    path: AppRoute.addCharacter.route,
                    name: AppRoute.addCharacter.name,
                    pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const Text('Add Character')),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
