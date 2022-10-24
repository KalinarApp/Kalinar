import 'package:go_router/go_router.dart';
import 'package:hero/src/features/admin/presentation/skills/create_skill_screen.dart';
import 'package:hero/src/features/admin/presentation/skills/edit_skill_screen.dart';
import 'package:hero/src/features/admin/presentation/skills/list_skills_screen.dart';
import 'package:hero/src/features/admin/presentation/skilltree/skilltree_builder_screen.dart';

import '../../features/admin/presentation/abilities/create_ability_screen.dart';
import '../../features/admin/presentation/abilities/edit_ability_screen.dart';
import '../../features/admin/presentation/abilities/list_abilities_screen.dart';
import '../../features/admin/presentation/admin_menu_screen.dart';
import '../../features/admin/presentation/manage_group_screen.dart';

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
  name: SkilltreeBuilderScreen.name,
  path: SkilltreeBuilderScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const SkilltreeBuilderScreen()),
);
