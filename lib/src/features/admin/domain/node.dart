import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hero/src/features/admin/domain/skill.dart';

part 'node.freezed.dart';
part 'node.g.dart';

@freezed
class Node with _$Node {
  const factory Node({
    required int importance,
    required Skill skill,
    required int cost,
    required String color,
    required bool isEasyReachable,
    @Default(0) double xpos,
    @Default(0) double ypos,
  }) = _Node;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}
