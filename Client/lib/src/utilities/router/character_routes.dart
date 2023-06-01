import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/characters/presentation/character_detail_screen.dart';
import '../../features/characters/presentation/character_editor_screen.dart';
import '../../features/characters/presentation/character_overview_screen.dart';
import '../../features/characters/presentation/skilltree_screen.dart';

GoRoute getCharacterRoutes(Ref ref) => GoRoute(
      name: CharacterOverviewScreen.name,
      path: CharacterOverviewScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const CharacterOverviewScreen()),
      routes: [
        GoRoute(
          name: CharacterEditorScreen.name,
          path: CharacterEditorScreen.route,
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: CharacterEditorScreen(state.queryParameters["id"])),
        ),
        GoRoute(
          name: CharacterDetailScreen.name,
          path: CharacterDetailScreen.route,
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: CharacterDetailScreen(state.pathParameters["id"]!)),
        ),
        GoRoute(
          name: SkilltreeScreen.name,
          path: SkilltreeScreen.route,
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: SkilltreeScreen(state.pathParameters["id"]!)),
        )
      ],
    );
