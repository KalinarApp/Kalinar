import 'package:go_router/go_router.dart';

import '../../features/traits/presentation/edit_ability_screen.dart';
import '../../features/traits/presentation/edit_attribute_screen.dart';
import '../../features/traits/presentation/edit_race_screen.dart';
import '../../features/traits/presentation/edit_skill_screen.dart';
import '../../features/traits/presentation/traits_overview_screen.dart';

final traitsRoutes = GoRoute(
  name: TraitsOverviewScreen.name,
  path: TraitsOverviewScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const TraitsOverviewScreen()),
  routes: [
    GoRoute(
      name: EditAbilityScreen.name,
      path: EditAbilityScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: EditAbilityScreen(state.queryParameters["id"])),
    ),
    GoRoute(
      name: EditAttributeScreen.name,
      path: EditAttributeScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: EditAttributeScreen(state.queryParameters["id"])),
    ),
    GoRoute(
      name: EditSkillScreen.name,
      path: EditSkillScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: EditSkillScreen(state.queryParameters["id"])),
    ),
    GoRoute(
      name: EditRaceScreen.name,
      path: EditRaceScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: EditRaceScreen(state.queryParameters["id"])),
    ),
  ],
);
