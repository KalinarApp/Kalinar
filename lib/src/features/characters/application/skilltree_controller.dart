import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../admin/skilltrees/data/skilltrees_repository.dart';

import '../../admin/skilltrees/domain/edge.dart';
import '../../admin/skilltrees/domain/skilltree.dart';

class SkilltreeController extends StateNotifier<AsyncValue<Skilltree>> {
  final SkilltreesRepository repo;

  SkilltreeController(this.repo) : super(const AsyncLoading());

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
    return state;
  }
}

final skilltreeControllerProvider = StateNotifierProvider.autoDispose<SkilltreeController, AsyncValue<Skilltree>>((ref) {
  return SkilltreeController(ref.read(skilltreesRepositoryProvider));
});
