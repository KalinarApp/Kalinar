import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hero/src/features/admin/skilltrees/domain/skilltree.dart';

import '../../domain/node.dart';

part 'skilltree_state.freezed.dart';
part 'skilltree_state.g.dart';

@freezed
class SkilltreeState with _$SkilltreeState {
  const factory SkilltreeState({
    @Default(Skilltree()) Skilltree skilltree,
    Node? selectedNode,
    @Default(false) bool isSaving,
  }) = _SkilltreeState;

  factory SkilltreeState.fromJson(Map<String, dynamic> json) => _$SkilltreeStateFromJson(json);
}
