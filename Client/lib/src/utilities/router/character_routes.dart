import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/inventory/presentation/items_list_screen.dart';

import '../../features/characters/presentation/character_detail_screen.dart';
import '../../features/characters/presentation/character_editor_screen.dart';
import '../../features/characters/presentation/character_overview_screen.dart';
import '../../features/characters/presentation/skilltree_screen.dart';

final characterRoutes = GoRoute(
  name: CharacterOverviewScreen.name,
  path: CharacterOverviewScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const CharacterOverviewScreen()),
  routes: [
    GoRoute(
      name: ItemsListScreen.name,
      path: ItemsListScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ItemsListScreen()),
    ),
    GoRoute(
      name: CharacterEditorScreen.name,
      path: CharacterEditorScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: CharacterEditorScreen(state.queryParams["id"])),
    ),
    GoRoute(
      name: CharacterDetailScreen.name,
      path: CharacterDetailScreen.route,
      pageBuilder: (context, state) {
        return NoTransitionPage(key: state.pageKey, child: CharacterDetailScreen(state.params["id"]!));
      },
    ),
    GoRoute(
      name: SkilltreeScreen.name,
      path: SkilltreeScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: SkilltreeScreen(state.params["id"]!)),
    )
  ],
);
