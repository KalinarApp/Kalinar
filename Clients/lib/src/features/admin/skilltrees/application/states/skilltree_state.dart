import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/node.dart';
import '../../domain/skilltree.dart';

part 'skilltree_state.freezed.dart';
part 'skilltree_state.g.dart';

@freezed
class SkilltreeState with _$SkilltreeState {
  const factory SkilltreeState({
    String? id,
    @Default(Skilltree()) Skilltree skilltree,
    @Default(false) bool isBlueprint,
    Node? selectedNode,
    @Default(false) bool isSaving,
  }) = _SkilltreeState;

  factory SkilltreeState.fromJson(Map<String, dynamic> json) => _$SkilltreeStateFromJson(json);
}
