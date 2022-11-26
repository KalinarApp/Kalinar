import 'package:freezed_annotation/freezed_annotation.dart';

import '../../management/domain/skill.dart';

part 'node.freezed.dart';
part 'node.g.dart';

@freezed
class Node with _$Node {
  const factory Node({
    required String id,
    required int importance,
    required Skill skill,
    required String skillId,
    required int cost,
    required String color,
    required bool isEasyReachable,
    @Default(false) isUnlocked,
    @Default(0) double xPos,
    @Default(0) double yPos,
    @Default([]) List<String> precessors,
    @Default([]) List<String> successors,
  }) = _Node;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}

extension NodeListExtension on List<Node> {
  List<Node> withoutId(String id) {
    return [...where((element) => element.id != id)];
  }

  List<Node> withoutIds(List<String> ids) {
    return [...where((element) => !ids.contains(element.id))];
  }

  bool isNodeUnlockable(String nodeId, int currentSkillpoints) {
    Node nodeToCheck = singleWhere((element) => nodeId == element.id);

    bool hasSkillpoints = currentSkillpoints >= nodeToCheck.cost;
    bool isUnlockable = nodeToCheck.isEasyReachable
        ? where((element) => nodeToCheck.precessors.contains(element.id)).any((element) => element.isUnlocked)
        : where((element) => nodeToCheck.precessors.contains(element.id)).every((element) => element.isUnlocked);

    return hasSkillpoints && (nodeToCheck.precessors.isEmpty || isUnlockable);
  }
}
