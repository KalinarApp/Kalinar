import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hero/src/features/admin/domain/ability.dart';

part 'create_skill_state.freezed.dart';

@freezed
class CreateSkillState with _$CreateSkillState {
  const factory CreateSkillState({
    Ability? selectedAbility,
  }) = _CreateSkillState;
}
