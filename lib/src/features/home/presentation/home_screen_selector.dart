import 'package:flutter/material.dart';
import 'package:flutter_auth/models/auth_state.dart';

import '../../authentication/presentation/auth/sign_in_screen.dart';
import '../../authentication/domain/user_info_extensions.dart';
import '../../group_management/presentation/admin_screen.dart';
import '../../group_management/presentation/no_group_screen.dart';
import '../../group_management/presentation/user_screen.dart';
import 'welcome_screen.dart';

class HomeScreenSelector {
  static Widget getHomeScreen(AuthState? authState) {
    Widget homeScreen = const WelcomeScreen();
    if (null == authState?.isAuthenticated) {
      homeScreen = Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
    } else if (authState!.isAuthenticated!) {
      // check if user is in a group, if not show an info screen.
      if (authState.user!.groups.isEmpty) {
        homeScreen = const NoGroupScreen();
      } else {
        homeScreen = authState.user!.isAdmin() ? const AdminScreen() : const UserScreen();
      }
    } else if (!authState.isAuthenticated!) {
      homeScreen = const SignInScreen();
    } else {
      homeScreen = Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
    }

    return homeScreen;
  }
}
