import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/features/characters/application/skillpoint_controller.dart';

import '../../admin/skilltrees/data/skilltrees_repository.dart';
import '../../admin/skilltrees/domain/edge.dart';
import '../../admin/skilltrees/domain/skilltree.dart';

class SkilltreeController extends StateNotifier<AsyncValue<Skilltree>> {
  final SkilltreesRepository repo;
  final SkillpointController skillpointController;

  SkilltreeController(this.repo, this.skillpointController) : super(const AsyncLoading());

  Future<void> getById(String id) async {
    state = const AsyncLoading();
    await refresh(id);
  }

  Future<void> refresh(String id) async {
    state = await AsyncValue.guard(() async => await repo.getById(id));
  }

  List<Edge> getAllEdges() {
    List<Edge> edges = [];
    if (state.hasValue) {
      for (final node in state.value!.nodes) {
        for (final id in node.successors) {
          final edge = Edge(start: node, end: state.value!.nodes.firstWhere((element) => element.id == id));
          edges.add(edge);
        }
      }
    }
    return edges;
  }

  Future<AsyncValue> unlockNode(String skilltreeId, String nodeId) async {
    final state = await AsyncValue.guard(() async => await repo.unlockNode(skilltreeId, nodeId));
    await refresh(skilltreeId);
    await skillpointController.getSkillpointsForSkilltree(skilltreeId);
    return state;
  }

  Future<AsyncValue> resetNode(String skilltreeId, String nodeId) async {
    final state = await AsyncValue.guard(() async => await repo.resetNode(skilltreeId, nodeId));
    await refresh(skilltreeId);
    await skillpointController.getSkillpointsForSkilltree(skilltreeId);
    return state;
  }
}

final skilltreeControllerProvider = StateNotifierProvider.autoDispose<SkilltreeController, AsyncValue<Skilltree>>((ref) {
  return SkilltreeController(ref.watch(skilltreesRepositoryProvider), ref.watch(skillpointControllerProvider.notifier));
});
