import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ability.dart';

// part 'skill.g.dart';

// @JsonSerializable()
// class Skill {

//   String id;
//   Ability? ability;

//   String? iconUrl;
//   String name;
//   String description;
//   int healthPointsBoost;
//   int lightPointsBoost;

//   double movementSpeedBoost;
//   double resistenceBoost;
//   double opticalRageBoost;
//   double meleeDamageBoost;
//   double rangeDamageBoost;
//   double lightDamageBoost;
//   double damageBoost;
//   double parryBoost;
//   double dodgeBoost;

//   Skill(
//     this.id, {
//     this.ability,
//     this.iconUrl,
//     required this.name,
//     required this.description,
//     this.healthPointsBoost = 0,
//     this.lightPointsBoost = 0,
//     this.movementSpeedBoost = 0,
//     this.resistenceBoost = 0,
//     this.opticalRageBoost = 0,
//     this.meleeDamageBoost = 0,
//     this.rangeDamageBoost = 0,
//     this.lightDamageBoost = 0,
//     this.damageBoost = 0,
//     this.parryBoost = 0,
//     this.dodgeBoost = 0,
//   });

//   factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

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
