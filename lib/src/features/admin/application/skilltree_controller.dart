import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/domain/edge.dart';
import 'package:hero/src/features/admin/domain/node.dart';

import 'states/skilltree_state.dart';

class SkilltreeController extends StateNotifier<SkilltreeState> {
  SkilltreeController() : super(const SkilltreeState());

  void addNode(Map<String, dynamic> data) {
    final node = Node.fromJson(data);
    state = state.copyWith(nodes: [...state.nodes.where((element) => element.id != node.id), node]);
  }

  void addNodeWithPosition(Node node, Offset offset) {
    node = node.copyWith(xpos: offset.dx, ypos: offset.dy);
    state = state.copyWith(nodes: [...state.nodes.where((element) => element.id != node.id), node]);
  }

  void deleteNode(Node node) {
    state = state.copyWith(nodes: [...state.nodes.where((element) => element != node)]);
  }

  List<Edge> getAllEdges() {
    List<Edge> edges = [];
    for (final node in state.nodes) {
      for (final id in node.successors) {
        final edge = Edge(start: node, end: state.nodes.firstWhere((element) => element.id == id));
        edges.add(edge);
      }
    }

    return edges;
  }

  void addEdge(Node start, Node end) {
    deleteNode(start);
    deleteNode(end);

    start = start.copyWith(successors: [...start.successors, end.id]);
    end = end.copyWith(precessors: [...end.precessors, start.id]);
    state = state.copyWith(nodes: [...state.nodes, start, end]);
  }
}

final skilltreeControllerProvider = StateNotifierProvider<SkilltreeController, SkilltreeState>((ref) {
  return SkilltreeController();
});
