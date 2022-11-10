import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hero/src/features/admin/skilltrees/domain/skilltree.dart';
import 'package:hero/src/features/character_management/domain/character.dart';

import 'node.dart';

part 'blueprint.freezed.dart';
part 'blueprint.g.dart';

@freezed
class Blueprint with _$Blueprint {
  const factory Blueprint({
    @Default("") String id,
    @Default("") String name,
    Character? character,
    @Default(0) int points,
    @Default(true) bool isActiveTree,
    @Default([]) List<Node> nodes,
  }) = _Blueprint;

  factory Blueprint.fromJson(Map<String, dynamic> json) => _$BlueprintFromJson(json);
}

extension BlueprintExtension on Blueprint {
  Blueprint updateNodes(List<String> idsToDelete, List<Node> newNodes) {
    return copyWith(nodes: [...nodes.where((element) => !idsToDelete.contains(element.id)), ...newNodes]);
  }

  Skilltree toSkilltree() {
    return Skilltree(id: id, name: name, nodes: nodes);
  }
}
