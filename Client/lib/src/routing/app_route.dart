enum AppRoute {
  signIn,
  home,
  userProfile,
  userProfileCreate,
  groupList,
  groupDetails,
  groupCreate,
  groupEdit,
  characterList,
  characterDetails,
  addCharacter,
  editCharacter,
}

extension AppRouteExtension on AppRoute {
  String get route {
    switch (this) {
      case AppRoute.signIn:
        return '/signIn';
      case AppRoute.home:
        return '/';
      case AppRoute.groupList:
        return '/groups';
      case AppRoute.groupCreate:
        return 'create';
      case AppRoute.groupDetails:
        return ':id';
      case AppRoute.groupEdit:
        return 'edit';
      case AppRoute.userProfile:
        return '/user-profile';
      case AppRoute.userProfileCreate:
        return '/create-profile';
      case AppRoute.characterList:
        return '/characters';
      case AppRoute.characterDetails:
        return ':id';
      case AppRoute.addCharacter:
        return 'add';
      case AppRoute.editCharacter:
        return 'edit';
    }
  }
}
