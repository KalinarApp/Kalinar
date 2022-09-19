import 'package:json_annotation/json_annotation.dart';

import 'ability.dart';

part 'skill.g.dart';

@JsonSerializable()
class Skill {
  String id;
  Ability? ability;

  String? iconUrl;
  String name;
  String description;
  int healthPointsBoost;
  int lightPointsBoost;

  double movementSpeedBoost;
  double resistenceBoost;
  double opticalRageBoost;
  double meleeDamageBoost;
  double rangeDamageBoost;
  double lightDamageBoost;
  double damageBoost;
  double parryBoost;
  double dodgeBoost;

  Skill(
    this.id, {
    this.ability,
    this.iconUrl,
    required this.name,
    required this.description,
    this.healthPointsBoost = 0,
    this.lightPointsBoost = 0,
    this.movementSpeedBoost = 0,
    this.resistenceBoost = 0,
    this.opticalRageBoost = 0,
    this.meleeDamageBoost = 0,
    this.rangeDamageBoost = 0,
    this.lightDamageBoost = 0,
    this.damageBoost = 0,
    this.parryBoost = 0,
    this.dodgeBoost = 0,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  Map<String, dynamic> toJson() => _$SkillToJson(this);
}
