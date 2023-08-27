import 'package:freezed_annotation/freezed_annotation.dart';

import 'ability.dart';
import 'suggestable.dart';
import 'suggestion_state.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill extends Suggestable with _$Skill {
  factory Skill(
    String id,
    String groupId,
    String creatorId,
    String name,
    String? iconUrl,
    String? description,
    String? abilityId,
    Ability? ability,
    SuggestionState state,
    String? rejectionReason,
    DateTime createdAt,
    DateTime? modifiedAt,
    DateTime? approvedAt,
    DateTime? rejectedAt,
  ) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
