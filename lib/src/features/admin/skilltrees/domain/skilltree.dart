import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hero/src/features/characters/domain/character.dart';
import 'package:hero/src/features/characters/domain/character_overview.dart';

import 'node.dart';

part 'skilltree.freezed.dart';
part 'skilltree.g.dart';

@freezed
class Skilltree with _$Skilltree {
  const factory Skilltree({
    @Default("") String id,
    @Default("") String name,
    CharacterOverview? character,
    @Default(0) int points,
    @Default(true) bool isActiveTree,
    @Default([]) List<Node> nodes,
  }) = _Skilltree;

  factory Skilltree.fromJson(Map<String, dynamic> json) => _$SkilltreeFromJson(json);
}

extension SkilltreeExtension on Skilltree {
  Skilltree updateNodes(List<String> idsToDelete, List<Node> newNodes) {
    return copyWith(nodes: [...nodes.where((element) => !idsToDelete.contains(element.id)), ...newNodes]);
  }

  bool isNodeUnlockable(String nodeId) {
    Node nodeToCheck = nodes.singleWhere((element) => nodeId == element.id);

    return nodeToCheck.isEasyReachable
        ? nodes.where((element) => nodeToCheck.precessors.contains(element.id)).any((element) => element.isUnlocked)
        : !nodes.where((element) => nodeToCheck.precessors.contains(element.id)).any((element) => !element.isUnlocked);
  }
}
