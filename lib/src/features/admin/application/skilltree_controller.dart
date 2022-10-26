import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/domain/edge.dart';
import 'package:hero/src/features/admin/domain/node.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'states/skilltree_state.dart';

class SkilltreeController extends StateNotifier<SkilltreeState> {
  SkilltreeController() : super(const SkilltreeState());

  void addNode(Map<String, dynamic> data) {
    final node = Node.fromJson(data);
    state = state.copyWith(nodes: [...state.nodes.withoutId(node.id), node]);
  }

  void addNodeWithPosition(Node node, Offset offset) {
    node = node.copyWith(xpos: offset.dx, ypos: offset.dy);
    state = state.copyWith(nodes: [...state.nodes.withoutId(node.id), node]);
  }

  void deleteNode(Node node) {
    state = state.copyWith(nodes: [...state.nodes.withoutId(node.id)]);
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

  void addPointForEdge(Node node) {
    if (null == state.selectedNode) {
      state = state.copyWith(selectedNode: node);
    } else if (state.selectedNode == node) {
      state = state.copyWith(selectedNode: null);
    } else if (!state.selectedNode!.successors.contains(node.id) && !state.selectedNode!.precessors.contains(node.id)) {
      addEdge(state.selectedNode!, node);
    }
  }

  void addEdge(Node start, Node end) {
    start = start.copyWith(successors: [...start.successors, end.id]);
    end = end.copyWith(precessors: [...end.precessors, start.id]);
    state = state.copyWith(
      selectedNode: null,
      nodes: [
        ...state.nodes.withoutIds([start.id, end.id]),
        start,
        end
      ],
    );
  }

  void removeEdge(Edge edge) {
    final start = edge.start.copyWith(successors: [...edge.start.successors.without(edge.end.id)]);
    final end = edge.end.copyWith(precessors: [...edge.end.precessors.without(edge.start.id)]);

    state = state.copyWith(nodes: [
      ...state.nodes.withoutIds([start.id, end.id]),
      start,
      end
    ]);
  }

  void swapEdges(Edge edge) {
    final start = edge.start.copyWith(
      successors: [...edge.start.successors.without(edge.end.id)],
      precessors: [...edge.start.precessors, edge.end.id],
    );
    final end = edge.end.copyWith(
      precessors: [...edge.end.precessors.without(edge.start.id)],
      successors: [...edge.end.successors, edge.start.id],
    );

    state = state.copyWith(nodes: [
      ...state.nodes.withoutIds([start.id, end.id]),
      start,
      end
    ]);
  }

  Future<void> loadLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList("currentSkilltree");
    if (null != data && state.nodes.isEmpty) {
      state = state.copyWith(nodes: List<Node>.from(data.map((model) => Node.fromJson(json.decode(model)))));
    }
  }

  Future<void> saveLocal() async {
    if (state.nodes.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList("currentSkilltree", state.nodes.map((e) => jsonEncode(e.toJson())).toList());
    }
  }

  Future<void> deleteLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("currentSkilltree");

    state = state.copyWith(nodes: [], selectedNode: null);
  }
}

final skilltreeControllerProvider = StateNotifierProvider<SkilltreeController, SkilltreeState>((ref) {
  return SkilltreeController();
});
