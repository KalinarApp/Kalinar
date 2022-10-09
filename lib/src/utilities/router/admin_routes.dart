import 'package:go_router/go_router.dart';

import '../../features/admin/presentation/screens/abilities/create_ability_screen.dart';
import '../../features/admin/presentation/screens/abilities/list_abilities_screen.dart';
import '../../features/admin/presentation/screens/admin_menu_screen.dart';
import '../../features/admin/presentation/screens/manage_group_screen.dart';

final adminRoutes = GoRoute(
  path: AdminMenuScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const AdminMenuScreen()),
  routes: [
    GoRoute(
      name: ManageGroupScreen.name,
      path: ManageGroupScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ManageGroupScreen()),
    ),
    abilityRoutes,
  ],
);

final abilityRoutes = GoRoute(
  name: ListAbilitiesScreen.name,
  path: ListAbilitiesScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ListAbilitiesScreen()),
  routes: [
    GoRoute(
      name: CreateAbilityScreen.name,
      path: CreateAbilityScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const CreateAbilityScreen()),
    )
  ],
);
