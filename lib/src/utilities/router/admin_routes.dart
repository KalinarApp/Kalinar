import 'package:go_router/go_router.dart';

import '../../features/admin/abilities/presentation/create_ability_screen.dart';
import '../../features/admin/abilities/presentation/edit_ability_screen.dart';
import '../../features/admin/abilities/presentation/list_abilities_screen.dart';
import '../../features/admin/common/presentation/admin_menu_screen.dart';
import '../../features/admin/common/presentation/manage_group_screen.dart';
import '../../features/admin/skills/presentation/create_skill_screen.dart';
import '../../features/admin/skills/presentation/edit_skill_screen.dart';
import '../../features/admin/skills/presentation/list_skills_screen.dart';
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
    adminAbilityRoutes,
    adminSkillRoutes,
    adminSkilltreeRoutes,
  ],
);

final adminAbilityRoutes = GoRoute(
  name: ListAbilitiesScreen.name,
  path: ListAbilitiesScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ListAbilitiesScreen()),
  routes: [
    GoRoute(
      name: CreateAbilityScreen.name,
      path: CreateAbilityScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const CreateAbilityScreen()),
    ),
    GoRoute(
      name: EditAbilityScreen.name,
      path: EditAbilityScreen.route,
      pageBuilder: (context, state) {
        final itemName = state.queryParams["name"]!;
        return NoTransitionPage(key: state.pageKey, child: EditAbilityScreen(itemName));
      },
    )
  ],
);

final adminSkillRoutes = GoRoute(
  name: ListSkillsScreen.name,
  path: ListSkillsScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ListSkillsScreen()),
  routes: [
    GoRoute(
      name: CreateSkillScreen.name,
      path: CreateSkillScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const CreateSkillScreen()),
    ),
    GoRoute(
      name: EditSkillScreen.name,
      path: EditSkillScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: EditSkillScreen(state.queryParams["id"]!)),
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
