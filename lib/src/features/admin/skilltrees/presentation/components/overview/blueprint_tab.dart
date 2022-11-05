import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/skilltree_overview.dart';
import 'skilltree_item.dart';

class BlueprintTab extends ConsumerWidget {
  const BlueprintTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: const [
          SkilltreeItem(SkilltreeOverview(id: "test", name: "Skilltree von Jonas", points: 100, isActiveTree: false, nodeCount: 100)),
          SkilltreeItem(SkilltreeOverview(id: "test", name: "Skilltree von Jonas", points: 100, isActiveTree: true, nodeCount: 100)),
          SkilltreeItem(SkilltreeOverview(id: "test", name: "Skilltree von Jonas", points: 100, isActiveTree: true, nodeCount: 100)),
          SkilltreeItem(SkilltreeOverview(id: "test", name: "Skilltree von Jonas", points: 100, isActiveTree: true, nodeCount: 100)),
        ],
      ),
    );
  }
}
