import 'dart:async';
import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/data/skilltrees_repository.dart';
import 'package:hero/src/features/admin/domain/edge.dart';
import 'package:hero/src/features/admin/domain/node.dart';

import 'states/skilltree_state.dart';

class SkilltreeController extends StateNotifier<SkilltreeState> {
  final SkilltreesRepository repo;
  Timer? timer;

  SkilltreeController(this.repo) : super(const SkilltreeState());

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
    if (state.nodes.isEmpty) {
      state = state.copyWith(nodes: await repo.loadLocal());
    }
  }

  void startSavingLocal() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      // ToDo: Maybe check if any changes happend since last save and only then save the state.
      if (state.nodes.isNotEmpty) {
        state = state.copyWith(isSaving: true);
        await repo.saveLocal(state.nodes);
        state = state.copyWith(isSaving: false);
      }
    });
  }

  void endSavingLocal() {
    if (null != timer) {
      timer!.cancel();
    }
  }

  Future<void> deleteLocal() async {
    await repo.deleteLocal();
    state = state.copyWith(nodes: [], selectedNode: null);
  }

  Future<AsyncValue<void>> createOnServer(Map<String, dynamic> data) async {
    final alteredData = {...data, "node": jsonEncode(state.nodes)};
    return AsyncValue.guard(() => repo.createOnServer(alteredData));
  }
}

final skilltreeControllerProvider = StateNotifierProvider<SkilltreeController, SkilltreeState>((ref) {
  return SkilltreeController(ref.read(skilltreesRepositoryProvider));
});
