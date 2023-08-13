import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/home/presentation/home_screen.dart';
import 'package:kalinar/src/features/user_management/presentation/edit_user_dialog.dart';
import 'package:kalinar/src/routing/app_route.dart';
import 'package:kalinar/src/routing/dialog_page.dart';
import 'package:kalinar/src/routing/go_router_refresh_stream.dart';
import 'package:kalinar/src/routing/navigation/scaffold_with_nested_navigation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/data/firebase_auth_repository.dart';
import '../features/authentication/presentation/custom_sign_in_screen.dart';

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
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final onLoginPage = state.uri.toString() == '/signIn';

      if (!isLoggedIn && !onLoginPage) return '/signIn';
      if (isLoggedIn && onLoginPage) return '/home';
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const CustomSignInScreen()),
      ),
      GoRoute(
        path: '/profile',
        name: AppRoute.userProfile.name,
        pageBuilder: (context, state) => DialogPage(builder: (_) => const Text("User Profile")),
        routes: [
          GoRoute(
            path: 'create',
            name: AppRoute.createProfile.name,
            pageBuilder: (context, state) => DialogPage(builder: (_) => const EditUserDialog()),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                name: AppRoute.home.name,
                pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _charactersNavigatorKey,
            routes: [
              GoRoute(
                path: '/characters',
                name: AppRoute.characterList.name,
                pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const Text('Characters')),
                routes: [
                  GoRoute(
                      path: ':id',
                      name: AppRoute.characterDetails.name,
                      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const Text('Character Details')),
                      routes: [
                        GoRoute(
                          path: 'edit',
                          name: AppRoute.editCharacter.name,
                          pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const Text('Edit Character')),
                        )
                      ]),
                  GoRoute(
                    path: 'add',
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
