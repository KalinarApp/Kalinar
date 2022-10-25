import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/domain/node.dart';

import 'states/skilltree_state.dart';

class SkilltreeController extends StateNotifier<SkilltreeState> {
  SkilltreeController() : super(const SkilltreeState());

  void addNode(Map<String, dynamic> data) {
    final node = Node.fromJson(data);
    state = state.copyWith(nodes: [...state.nodes, node]);
  }

  void deleteNode(Node node) {
    state = state.copyWith(nodes: [...state.nodes.where((element) => element != node)]);
  }

  void updateNodePosition(Node node, Offset offset) {
    final index = state.nodes.indexOf(node);
    final newNodes = [...state.nodes];
    newNodes[index] = node.copyWith(xpos: offset.dx, ypos: offset.dy);

    state = state.copyWith(nodes: newNodes);
  }
}

final skilltreeControllerProvider = StateNotifierProvider<SkilltreeController, SkilltreeState>((ref) {
  return SkilltreeController();
});
