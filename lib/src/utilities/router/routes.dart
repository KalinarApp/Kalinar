import 'package:flutter/material.dart';
import 'package:flutter_auth/models/user_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/common_widgets/navigation/scaffold_with_bottom_navbar.dart';
import 'package:hero/src/common_widgets/navigation/scaffold_with_navbar_item.dart';
import 'package:hero/src/features/admin/presentation/screens/admin_menu_screen.dart';
import 'package:hero/src/features/authentication/data/auth_repository.dart';
import 'package:hero/src/features/authentication/domain/user_info_extensions.dart';
import 'package:hero/src/features/authentication/presentation/auth/sign_in_screen.dart';
import 'package:hero/src/features/group_management/presentation/user_screen.dart';
import 'package:hero/src/features/home/presentation/welcome_screen.dart';
import 'package:hero/src/utilities/router/admin_routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();
  final currentUser = ref.watch(userChangedProvider);

  return GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    refreshListenable: RouterStreamNotifier(ref),
    redirect: (context, state) {
      final isAuthenticated = ref.read(authStateChangedProvider);

      if (null == isAuthenticated) return null;

      if (state.location == "/") {
        return isAuthenticated ? "/home" : SignInScreen.route;
      }

      if (state.location == SignInScreen.route) {
        return isAuthenticated ? "/home" : null;
      }

      return isAuthenticated ? null : SignInScreen.route;
    },
    routes: [
      GoRoute(
        path: "/",
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const WelcomeScreen()),
      ),
      GoRoute(
        path: SignInScreen.route,
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const SignInScreen()),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => ScaffoldWithBottomNavbar(
          tabs: [
            ScaffoldWithNavbarItem(
                initialLocation: "/home", icon: const Icon(Icons.home), label: const Text("Home"), color: Theme.of(context).colorScheme.primary),
            ScaffoldWithNavbarItem(
                initialLocation: "/characters",
                icon: const Icon(Icons.man),
                label: const Text("Charakter"),
                color: Theme.of(context).colorScheme.primary),
            if (null != currentUser && currentUser.isAdmin())
              ScaffoldWithNavbarItem(
                  initialLocation: AdminMenuScreen.route,
                  icon: const Icon(Icons.coffee),
                  label: const Text("Admin"),
                  color: Theme.of(context).colorScheme.primary),
            if (null != currentUser && !currentUser.isAdmin())
              ScaffoldWithNavbarItem(
                  initialLocation: "/skilltrees",
                  icon: const Icon(Icons.trending_up),
                  label: const Text("Fähigkeiten"),
                  color: Theme.of(context).colorScheme.primary),
          ],
          child: child,
        ),
        routes: [
          GoRoute(
            path: "/home",
            pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const UserScreen()),
          ),
          GoRoute(
            path: "/skilltrees",
            pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const Scaffold()),
          ),
          GoRoute(
            path: "/characters",
            pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const Scaffold()),
          ),
          adminRoutes,
        ],
      ),
    ],
  );
});

final authStateChangedProvider = Provider<bool?>((ref) {
  return ref.watch(authChangedProvider.select((data) {
    return data.value?.isAuthenticated;
  }));
});

final userChangedProvider = Provider<UserInfo?>((ref) {
  return ref.watch(authChangedProvider.select((value) {
    return value.value?.user;
  }));
});

class RouterStreamNotifier with ChangeNotifier {
  final Ref _ref;

  RouterStreamNotifier(this._ref) {
    _ref.listen(authStateChangedProvider, (previous, next) {
      notifyListeners();
    });
  }
}
