import 'package:go_router/go_router.dart';

import '../../features/traits/presentation/edit_ability_screen.dart';
import '../../features/traits/presentation/edit_attribute_screen.dart';
import '../../features/traits/presentation/traits_overview_screen.dart';

final traitsRoutes = GoRoute(
  name: TraitsOverviewScreen.name,
  path: TraitsOverviewScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const TraitsOverviewScreen()),
  routes: [
    GoRoute(
      name: EditAbilityScreen.name,
      path: EditAbilityScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: EditAbilityScreen(state.queryParams["id"])),
    ),
    GoRoute(
      name: EditAttributeScreen.name,
      path: EditAttributeScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: EditAttributeScreen(state.queryParams["id"])),
    ),
  ],
);
