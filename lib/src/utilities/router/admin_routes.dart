import 'package:go_router/go_router.dart';

import '../../features/admin/common/presentation/admin_menu_screen.dart';
import '../../features/admin/common/presentation/manage_group_screen.dart';
import '../../features/admin/management/presentation/edit_ability_screen.dart';
import '../../features/admin/management/presentation/edit_skill_screen.dart';
import '../../features/admin/management/presentation/management_tab_screen.dart';
import '../../features/admin/skilltrees/presentation/skilltree_builder_screen.dart';
import '../../features/admin/skilltrees/presentation/skilltree_list_screen.dart';

final adminRoutes = GoRoute(
  path: AdminMenuScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const AdminMenuScreen()),
  routes: [
    GoRoute(
      name: ManageGroupScreen.name,
      path: ManageGroupScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ManageGroupScreen()),
    ),
    adminSkillRoutes,
    adminSkilltreeRoutes,
  ],
);

final adminSkillRoutes = GoRoute(
  name: ManagementTabScreen.name,
  path: ManagementTabScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ManagementTabScreen()),
  routes: [
    GoRoute(
      name: EditSkillScreen.name,
      path: EditSkillScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: EditSkillScreen(state.queryParams["id"])),
    ),
    GoRoute(
      name: EditAbilityScreen.name,
      path: EditAbilityScreen.route,
      pageBuilder: (context, state) {
        return NoTransitionPage(key: state.pageKey, child: EditAbilityScreen(state.queryParams["id"]));
      },
    ),
  ],
);

final adminSkilltreeRoutes = GoRoute(
    name: SkilltreeListScreen.name,
    path: SkilltreeListScreen.route,
    pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const SkilltreeListScreen()),
    routes: [
      GoRoute(
        name: SkilltreeBuilderScreen.name,
        path: SkilltreeBuilderScreen.route,
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: SkilltreeBuilderScreen(state.queryParams["id"])),
      ),
    ]);
