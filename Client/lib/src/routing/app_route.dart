enum AppRoute {
  signIn,
  home,
  userProfile,
  createProfile,
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
      case AppRoute.userProfile:
        return '/user-profile';
      case AppRoute.createProfile:
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
