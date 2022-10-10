import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ability.dart';

//   Map<String, dynamic> toJson() => _$SkillToJson(this);
// }

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill(
    String id, {
    Ability? ability,
    String? iconUrl,
    required String name,
    required String description,
    @Default(0) int healthPointsBoost,
    @Default(0) int lightPointsBoost,
    @Default(0) double movementSpeedBoost,
    @Default(0) double resistenceBoost,
    @Default(0) double opticalRageBoost,
    @Default(0) double meleeDamageBoost,
    @Default(0) double rangeDamageBoost,
    @Default(0) double lightDamageBoost,
    @Default(0) double damageBoost,
    @Default(0) double parryBoost,
    @Default(0) double dodgeBoost,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
