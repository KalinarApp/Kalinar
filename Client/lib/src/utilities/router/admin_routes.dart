import 'package:go_router/go_router.dart';

import '../../features/admin/common/presentation/admin_menu_screen.dart';
import '../../features/admin/common/presentation/manage_group_screen.dart';
import '../../features/admin/skilltrees/presentation/skilltree_builder_screen.dart';
import '../../features/admin/skilltrees/presentation/skilltree_list_screen.dart';
import '../../features/admin/storyline/presentation/page_editor_screen.dart';
import '../../features/admin/storyline/presentation/storyline_detail_screen.dart';
import '../../features/admin/storyline/presentation/storyline_edit_screen.dart';
import '../../features/admin/storyline/presentation/storyline_overview_screen.dart';

final adminRoutes = GoRoute(
  path: AdminMenuScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const AdminMenuScreen()),
  routes: [
    GoRoute(
      name: ManageGroupScreen.name,
      path: ManageGroupScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ManageGroupScreen()),
    ),
    adminSkilltreeRoutes,
    adminStorylineRoutes,
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
        pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: SkilltreeBuilderScreen(
              skilltreeId: state.queryParams["skilltreeId"],
              blueprintId: state.queryParams["blueprintId"],
              blueprintAsNew: state.queryParams.containsKey("asNew"),
            )),
      ),
    ]);

final adminStorylineRoutes = GoRoute(
  name: StorylineOverviewScreen.name,
  path: StorylineOverviewScreen.route,
  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const StorylineOverviewScreen()),
  routes: [
    GoRoute(
      name: StorylineEditScreen.name,
      path: StorylineEditScreen.route,
      pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: StorylineEditScreen(state.queryParams["id"])),
    ),
    GoRoute(
        name: StorylineDetailScreen.name,
        path: StorylineDetailScreen.route,
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: StorylineDetailScreen(state.params["id"]!)),
        routes: [
          GoRoute(
            name: PageEditorScreen.name,
            path: PageEditorScreen.route,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: PageEditorScreen(state.queryParams["id"], state.params["id"]),
            ),
          )
        ])
  ],
);
