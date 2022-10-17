import 'package:flutter/material.dart';
import 'package:flutter_auth/models/auth_state.dart';
import 'package:flutter_auth/models/user_info.dart';

import '../../authentication/presentation/auth/sign_in_screen.dart';
import '../../authentication/domain/user_info_extensions.dart';
import '../../group_management/presentation/admin_screen.dart';
import '../../group_management/presentation/no_group_screen.dart';
import '../../group_management/presentation/user_screen.dart';
import 'welcome_screen.dart';

class HomeScreenSelector {
  static Widget getHomeScreen(UserInfo user) {
    Widget homeScreen = const WelcomeScreen();
    if (user.groups.isEmpty) {
      homeScreen = const NoGroupScreen();
    } else if (user.isAdmin()) {
      homeScreen = const AdminScreen();
    } else if (user.isUser()) {
      homeScreen = const UserScreen();
    }

    return homeScreen;
  }
}
