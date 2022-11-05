import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/user_menu.dart';
import 'components/overview/blueprint_tab.dart';
import 'components/overview/skilltree_tab.dart';
import 'skilltree_builder_screen.dart';

class SkilltreeListScreen extends ConsumerStatefulWidget {
  static const String name = "SkilltreeList";
  static const String route = "skilltrees";

  const SkilltreeListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SkilltreeListScreenState();
}

class SkilltreeListScreenState extends ConsumerState<SkilltreeListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => GoRouter.of(context).pushNamed(SkilltreeBuilderScreen.name),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          actions: const [
            Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu()),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: FaIcon(FontAwesomeIcons.circleNodes)),
              Tab(icon: FaIcon(FontAwesomeIcons.map)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SkilltreeTab(),
            BlueprintTab(),
          ],
        ),
      ),
    );
  }
}
