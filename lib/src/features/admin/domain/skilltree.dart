import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hero/src/features/character_management/domain/character.dart';

import 'node.dart';

part 'skilltree.freezed.dart';
part 'skilltree.g.dart';

@freezed
class Skilltree with _$Skilltree {
  const factory Skilltree({
    required String id,
    required String name,
    Character? character,
    @Default(0) int points,
    @Default(true) bool isActiveTree,
    @Default([]) List<Node> nodes,
  }) = _Skilltree;

  factory Skilltree.fromJson(Map<String, dynamic> json) => _$SkilltreeFromJson(json);
}
