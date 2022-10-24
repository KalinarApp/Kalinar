import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/domain/node.dart';
import 'package:hero/src/features/admin/presentation/skilltree/skilltree_state.dart';

class SkilltreeController extends StateNotifier<SkilltreeState> {
  SkilltreeController() : super(const SkilltreeState());

  void addNode(Map<String, dynamic> data) {
    final node = Node.fromJson(data);
    state = state.copyWith(nodes: [...state.nodes, node]);
  }

  void deleteNode(Node node) {
    state = state.copyWith(nodes: [...state.nodes.where((element) => element != node)]);
  }
}

final skilltreeControllerProvider = StateNotifierProvider<SkilltreeController, SkilltreeState>((ref) {
  return SkilltreeController();
});
