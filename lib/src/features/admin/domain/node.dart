import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hero/src/features/admin/domain/skill.dart';

part 'node.freezed.dart';
part 'node.g.dart';

@freezed
class Node with _$Node {
  const factory Node({
    required String id,
    required int importance,
    required Skill skill,
    required int cost,
    required String color,
    required bool isEasyReachable,
    @Default(0) double xpos,
    @Default(0) double ypos,
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
}
