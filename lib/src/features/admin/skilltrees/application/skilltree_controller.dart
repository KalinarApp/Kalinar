import 'dart:async';
import 'dart:convert';

import 'package:flutter/animation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/blueprint_repository.dart';
import '../data/skilltrees_repository.dart';
import '../domain/blueprint.dart';
import '../domain/edge.dart';
import '../domain/node.dart';
import '../domain/skilltree.dart';

import 'blueprint_controller.dart';
import 'skilltree_list_controller.dart';
import 'states/skilltree_state.dart';

class SkilltreeController extends StateNotifier<SkilltreeState> {
  final SkilltreesRepository repo;
  final BlueprintController blueprints;
  final SkilltreeListController listController;

  Timer? timer;

  SkilltreeController(this.repo, this.blueprints, this.listController) : super(const SkilltreeState());

  void addNode(Map<String, dynamic> data) {
    final alteredData = {...data, "skillId": data["skill"]["id"]};
    final node = Node.fromJson(alteredData);
    state = state.copyWith(skilltree: state.skilltree.updateNodes([node.id], [node]));
  }

  void addNodeWithPosition(Node node, Offset offset) {
    node = node.copyWith(xPos: offset.dx, yPos: offset.dy);
    state = state.copyWith(skilltree: state.skilltree.updateNodes([node.id], [node]));
  }

  void deleteNode(Node node) {
    state = state.copyWith(skilltree: state.skilltree.updateNodes([node.id], []));
  }

  List<Edge> getAllEdges() {
    List<Edge> edges = [];
    for (final node in state.skilltree.nodes) {
      for (final id in node.successors) {
        final edge = Edge(start: node, end: state.skilltree.nodes.firstWhere((element) => element.id == id));
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
    state = state.copyWith(selectedNode: null, skilltree: state.skilltree.updateNodes([start.id, end.id], [start, end]));
  }

  void removeEdge(Edge edge) {
    final start = edge.start.copyWith(successors: [...edge.start.successors.without(edge.end.id)]);
    final end = edge.end.copyWith(precessors: [...edge.end.precessors.without(edge.start.id)]);

    state = state.copyWith(skilltree: state.skilltree.updateNodes([start.id, end.id], [start, end]));
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

    state = state.copyWith(skilltree: state.skilltree.updateNodes([start.id, end.id], [start, end]));
  }

  Future<void> loadLocal() async {
    state = SkilltreeState(skilltree: Skilltree(nodes: await repo.loadLocal()));
  }

  void startSavingLocal() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      // ToDo: Maybe check if any changes happend since last save and only then save the state.
      if (state.skilltree.nodes.isNotEmpty) {
        state = state.copyWith(isSaving: true);
        await repo.saveLocal(state.skilltree.nodes);
        state = state.copyWith(isSaving: false);
      }
    });
  }

  void endSavingLocal() {
    if (null != timer) {
      timer!.cancel();
    }
  }

  Future<void> resetLocal({bool cleanup = false}) async {
    await repo.deleteLocal();
    if (null != state.id && !cleanup) {
      if (state.isBlueprint) {
        getBlueprintById(state.id!);
      } else {
        getSkilltreeById(state.id!);
      }
    } else {
      state = state.copyWith(skilltree: const Skilltree(), selectedNode: null);
    }
  }

  Future<AsyncValue> deleteOnServer(String id) async {
    return AsyncValue.guard(() async {
      await repo.deleteOnServer(id);
      await listController.refresh();
    });
  }

  Future<AsyncValue<void>> createOnServer(Map<String, dynamic> data) async {
    final alteredData = {...data, "nodes": jsonDecode(jsonEncode(state.skilltree.nodes))};
    return AsyncValue.guard(() async {
      await repo.createOnServer(alteredData);
      await listController.refresh();
      resetLocal(cleanup: true);
    });
  }

  Future<AsyncValue<void>> updateSkilltree(String id, Map<String, dynamic> data) async {
    final alteredData = {...data, "nodes": jsonDecode(jsonEncode(state.skilltree.nodes))};
    return AsyncValue.guard(() async {
      await repo.updateOnServer(id, alteredData);
      await listController.refresh();
      resetLocal(cleanup: true);
    });
  }

  Future<void> getSkilltreeById(String id) async {
    var skilltree = await repo.getById(id);
    state = state.copyWith(skilltree: skilltree, id: id, isBlueprint: false);
  }

  Future<AsyncValue<void>> createBlueprint(Map<String, dynamic> data) async {
    final alteredData = {...data, "nodes": jsonDecode(jsonEncode(state.skilltree.nodes))};
    final result = await blueprints.create(alteredData);
    if (!result.hasError) {
      resetLocal(cleanup: true);
    }
    return result;
  }

  Future<AsyncValue<void>> updateBlueprint(String id, Map<String, dynamic> data) async {
    final alteredData = {...data, "nodes": jsonDecode(jsonEncode(state.skilltree.nodes))};
    final result = await blueprints.update(id, alteredData);
    if (!result.hasError) {
      resetLocal(cleanup: true);
    }
    return result;
  }

  Future<void> getBlueprintById(String id) async {
    final blueprint = await blueprints.getById(id);
    state = state.copyWith(skilltree: blueprint.toSkilltree(), id: id, isBlueprint: true);
  }

  Future<void> loadBlueprintAsNew(String id) async {
    final blueprint = await blueprints.load(id);
    state = SkilltreeState(skilltree: blueprint.toSkilltree());
  }

  Future<AsyncValue> resetSkilltree(String id) async {
    return AsyncValue.guard(() async => await repo.resetSkilltree(id));
  }
}

final skilltreeControllerProvider = StateNotifierProvider<SkilltreeController, SkilltreeState>((ref) {
  return SkilltreeController(
    ref.watch(skilltreesRepositoryProvider),
    ref.watch(blueprintControllerProvider),
    ref.watch(skilltreeListControllerProvider.notifier),
  );
});
