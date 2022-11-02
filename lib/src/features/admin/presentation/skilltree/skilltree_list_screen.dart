import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/user_menu.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/overview/skilltree_item.dart';

import '../../domain/skilltree_overview.dart';

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
    return Scaffold(
      appBar: AppBar(actions: const [
        Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu()),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          SkilltreeItem(SkilltreeOverview(id: "test", name: "Skilltree von Jonas", points: 100, isActiveTree: false, nodeCount: 100)),
          SkilltreeItem(SkilltreeOverview(id: "test", name: "Skilltree von Jonas", points: 100, isActiveTree: true, nodeCount: 100)),
        ],
      ),
    );
  }
}
