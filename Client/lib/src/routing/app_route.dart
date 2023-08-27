enum AppRoute {
  signIn,
  home,
  userProfile,
  userProfileEdit,
  groupList,
  groupDetails,
  groupCreate,
  groupEdit,
  groupJoin,
  characterList,
  characterDetails,
  addCharacter,
  editCharacter,
  characterTraitsList,
  abilityDetails,
  abilityCreate,
  abilityEdit,
}

extension AppRouteExtension on AppRoute {
  String get route {
    switch (this) {
      case AppRoute.home:
        return '/';
      case AppRoute.signIn:
        return '/signIn';
      case AppRoute.groupList:
        return '/groups';
      case AppRoute.groupCreate:
        return 'create';
      case AppRoute.groupDetails:
        return ':id';
      case AppRoute.groupEdit:
        return 'edit';
      case AppRoute.groupJoin:
        return 'join';
      case AppRoute.userProfile:
        return '/user-profile';
      case AppRoute.userProfileEdit:
        return '/create-profile';
      case AppRoute.characterList:
        return '/characters';
      case AppRoute.characterDetails:
        return ':id';
      case AppRoute.addCharacter:
        return 'add';
      case AppRoute.editCharacter:
        return 'edit';
      case AppRoute.characterTraitsList:
        return '/traits';
      case AppRoute.abilityCreate:
        return 'create';
      case AppRoute.abilityDetails:
        return ':id';
      case AppRoute.abilityEdit:
        return 'edit';
    }
  }
}
