import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kalinar/src/features/traits/domain/suggestable.dart';

import '../../group_management/domain/user.dart';
import 'ability.dart';
import 'attribute_value.dart';
import 'suggestion_state.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill implements Suggestable {
  const factory Skill(
    String id, {
    Ability? ability,
    String? iconUrl,
    required String name,
    String? description,
    @Default([]) List<AttributeValue> attributes,
    required User creator,
    required SuggestionState state,
    String? rejectionReason,
    required DateTime createdAt,
    DateTime? lastUpdatedAt,
    DateTime? approvedAt,
    DateTime? rejectedAt,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
