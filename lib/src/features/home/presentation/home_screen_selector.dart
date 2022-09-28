import 'package:flutter/material.dart';
import 'package:flutter_auth/models/auth_state.dart';
import 'package:hero/src/features/authentication/domain/user_info_extensions.dart';
import 'package:hero/src/features/home/presentation/no_group_screen.dart';
import 'package:hero/src/features/home/presentation/welcome_screen.dart';

import '../../authentication/presentation/auth/sign_in_screen.dart';

class HomeScreenSelector {
  static Widget getHomeScreen(AuthState? authState) {
    Widget homeScreen = const WelcomeScreen();
    if (null == authState?.isAuthenticated) {
      homeScreen = Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
    } else if (authState!.isAuthenticated!) {
      homeScreen = const WelcomeScreen();
      // check if user is in a group, if not show an info screen.
      if (!authState.user!.isUser() && authState.user!.groups.isEmpty) {
        homeScreen = const NoGroupScreen();
      }
    } else if (!authState.isAuthenticated!) {
      homeScreen = const SignInScreen();
    } else {
      homeScreen = Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
    }

    return homeScreen;
  }
}
