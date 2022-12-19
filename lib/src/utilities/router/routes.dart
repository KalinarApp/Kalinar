import 'package:flutter/material.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common_widgets/navigation/scaffold_with_bottom_navbar.dart';
import '../../common_widgets/navigation/scaffold_with_navbar_item.dart';
import '../../features/admin/common/presentation/admin_menu_screen.dart';
import '../../features/authentication/data/auth_repository.dart';
import '../../features/authentication/domain/user_info.dart';
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
  // final authState = RouterStreamNotifier(ref);
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
        return isAuthenticated ? HomeScreen.route : "/login";
      }

      final isLoggedIn = state.location == "/login";

      if (isLoggedIn) {
        return isAuthenticated ? HomeScreen.route : null;
      }

      return isAuthenticated ? null : "/";
    },
    routes: [
      GoRoute(
        path: "/",
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const WelcomeScreen()),
      ),
      GoRoute(
        path: "/login",
        pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: SignInScreen(
              providers: [EmailAuthProvider(), UniversalEmailSignInProvider()],
              showAuthActionSwitch: true,
              headerBuilder: (context, constraints, shrinkOffset) => ConstrainedBox(
                constraints: constraints,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Image.asset("assets/app_icon/icon.png"),
                ),
              ),
            )),
      ),
      GoRoute(
        name: GroupScreen.name,
        path: GroupScreen.route,
        redirect: (context, state) => null != groupState.group ? HomeScreen.route : null,
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
          final user = ref.read(userChangedProvider);
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
              if (null != user && user.isAdmin())
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
            redirect: (context, state) {
              if (state.location != GroupScreen.route && state.subloc != UserInviteScreen.route) {
                if (false == groupState.hasGroup) return GroupScreen.route;
              }

              if (state.subloc != UserInviteScreen.route && (groupState.hasGroup ?? false)) {
                return HomeScreen.route;
              }

              return null;
            },
          ),
          GoRoute(
            path: "/profile",
            name: "Profile",
            pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ProfileScreen()),
          ),
          characterRoutes,
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
  final ProviderRef _ref;
  bool skipNotifications = false;

  RouterStreamNotifier(this._ref) {
    _ref.listen(authStateChangedProvider, (previous, next) {
      if (!skipNotifications) {
        notifyListeners();
      }
    });
  }
}
