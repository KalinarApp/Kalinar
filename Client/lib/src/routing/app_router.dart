import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/character_traits/presentation/character_traits_screen.dart';
import 'package:kalinar/src/features/user_management/presentation/edit_user_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/data/firebase_auth_repository.dart';
import '../features/authentication/presentation/custom_sign_in_screen.dart';
import '../features/group_management/domain/group.dart';
import '../features/group_management/presentation/edit_group_dialog.dart';
import '../features/group_management/presentation/join_group_dialog.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/user_management/domain/user.dart';
import '../features/user_management/presentation/user_profile_dialog.dart';
import 'app_route.dart';
import 'dialog_page.dart';
import 'go_router_refresh_stream.dart';
import 'navigation/scaffold_with_nested_navigation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _charactersNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'characters');
final _storyNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'story');
final _traitsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'traits');
final _traitAbilityNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'traits-abilities');
final _traitAttributeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'traits-attributes');
final _traitSkillNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'traits-skills');
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
        path: AppRoute.userProfileEdit.route,
        name: AppRoute.userProfileEdit.name,
        pageBuilder: (context, state) => DialogPage(barrierDismissible: false, builder: (_) => EditUserDialog(user: state.extra as User?)),
      ),
      GoRoute(
        path: AppRoute.userProfile.route,
        name: AppRoute.userProfile.name,
        pageBuilder: (context, state) => DialogPage(builder: (_) => const UserProfileDialog()),
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
          GoRoute(
            path: AppRoute.groupJoin.route,
            name: AppRoute.groupJoin.name,
            pageBuilder: (context, state) => DialogPage(builder: (_) => const JoinGroupDialog()),
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
                path: AppRoute.home.route,
                name: AppRoute.home.name,
                pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const HomeScreen()),
              ),
            ],
          ),
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
          StatefulShellBranch(
            navigatorKey: _traitsNavigatorKey,
            routes: [
              StatefulShellRoute.indexedStack(
                builder: (context, state, navigationShell) => CharacterTraitsScreen(navigationShell: navigationShell),
                branches: [
                  StatefulShellBranch(
                    navigatorKey: _traitAbilityNavigatorKey,
                    routes: [
                      GoRoute(
                        path: '/traits/abilties',
                        name: 'Abilities',
                        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const Text('Abilities')),
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    navigatorKey: _traitAttributeNavigatorKey,
                    routes: [
                      GoRoute(
                        path: '/traits/attributes',
                        name: 'Attributes',
                        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const Text('Attributes')),
                      ),
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      ),
    ],
  );
}
