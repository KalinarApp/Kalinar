import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auth/models/user_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/common_widgets/navigation/scaffold_with_bottom_navbar.dart';
import 'package:hero/src/common_widgets/navigation/scaffold_with_navbar_item.dart';
import 'package:hero/src/features/authentication/data/auth_repository.dart';
import 'package:hero/src/features/authentication/domain/user_info_extensions.dart';
import 'package:hero/src/features/authentication/presentation/auth/sign_in_screen.dart';
import 'package:hero/src/features/group_management/presentation/admin_screen.dart';
import 'package:hero/src/features/home/presentation/welcome_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();
  final currentUser = ref.watch(_userChangedProvider);
  // final authChanged = ref.read(authChangedProvider.stream);

  return GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    refreshListenable: RouterStreamNotifier(ref),
    redirect: (context, state) {
      final isAuthenticated = ref.read(_authStateChangedProvider);

      if (null == isAuthenticated) return null;

      if (state.location == "/") {
        return isAuthenticated ? "/home" : "/login";
      }

      if (state.location == "/login") {
        return isAuthenticated ? "/home" : null;
      }

      return isAuthenticated ? null : "/login";
    },
    routes: [
      GoRoute(
        path: "/",
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const WelcomeScreen()),
      ),
      GoRoute(
        path: "/login",
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const SignInScreen()),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => ScaffoldWithBottomNavbar(
          tabs: [
            const ScaffoldWithNavbarItem(initialLocation: "/characters", icon: Icon(Icons.man), label: "Charakter"),
            const ScaffoldWithNavbarItem(initialLocation: "/home", icon: Icon(Icons.home), label: "Home"),
            if (null != currentUser && currentUser.isAdmin())
              const ScaffoldWithNavbarItem(initialLocation: "/admin", icon: Icon(Icons.coffee), label: "Adminbereich"),
            if (null != currentUser && !currentUser.isAdmin())
              const ScaffoldWithNavbarItem(initialLocation: "/skilltrees", icon: Icon(Icons.trending_up), label: "Fähigkeiten"),
          ],
          child: child,
        ),
        routes: [
          GoRoute(
            path: "/home",
            pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const AdminScreen()),
          ),
          GoRoute(
            path: "/skilltrees",
            pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const Scaffold()),
          ),
          GoRoute(
            path: "/characters",
            pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const Scaffold()),
          ),
        ],
      ),
    ],
  );
});

final _authStateChangedProvider = Provider<bool?>((ref) {
  return ref.watch(authChangedProvider.select((data) {
    return data.value?.isAuthenticated;
  }));
});

final _userChangedProvider = Provider<UserInfo?>((ref) {
  return ref.watch(authChangedProvider.select((value) {
    return value.value?.user;
  }));
});

class RouterStreamNotifier with ChangeNotifier {
  final Ref _ref;

  RouterStreamNotifier(this._ref) {
    _ref.listen(_authStateChangedProvider, (previous, next) {
      notifyListeners();
    });
  }
}
