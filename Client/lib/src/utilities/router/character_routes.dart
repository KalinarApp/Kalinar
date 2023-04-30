import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/common_widgets/layout/size.dart';

import '../../features/characters/application/controllers/character_controller.dart';
import '../../features/characters/presentation/character_detail_screen.dart';
import '../../features/characters/presentation/character_editor_screen.dart';
import '../../features/characters/presentation/character_overview_screen.dart';
import '../../features/characters/presentation/skilltree_screen.dart';

GoRoute getCharacterRoutes(Ref ref) => GoRoute(
      name: CharacterOverviewScreen.name,
      path: CharacterOverviewScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const CharacterOverviewScreen()),
      redirect: (context, state) async {
        if (state.fullpath == "${CharacterOverviewScreen.route}/${CharacterDetailScreen.route}") return null;
        if (MediaQuery.of(context).size.width > mobileMaxWidth) {
          final items = await ref.read(characterControllerProvider).getAll();
          if (!context.mounted || items.isEmpty) return null;
          return state.namedLocation(CharacterDetailScreen.name, params: {"id": items.first.id});
        }
        return null;
      },
      routes: [
        GoRoute(
          name: CharacterEditorScreen.name,
          path: CharacterEditorScreen.route,
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: CharacterEditorScreen(state.queryParams["id"])),
        ),
        GoRoute(
          name: CharacterDetailScreen.name,
          path: CharacterDetailScreen.route,
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: CharacterDetailScreen(state.params["id"]!)),
        ),
        GoRoute(
          name: SkilltreeScreen.name,
          path: SkilltreeScreen.route,
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: SkilltreeScreen(state.params["id"]!)),
        )
      ],
    );
