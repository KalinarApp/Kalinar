// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Skill _$$_SkillFromJson(Map<String, dynamic> json) => _$_Skill(
      json['id'] as String,
      ability: json['ability'] == null
          ? null
          : Ability.fromJson(json['ability'] as Map<String, dynamic>),
      iconUrl: json['iconUrl'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      healthPointsBoost: json['healthPointsBoost'] as int? ?? 0,
      lightPointsBoost: json['lightPointsBoost'] as int? ?? 0,
      movementSpeedBoost: (json['movementSpeedBoost'] as num?)?.toDouble() ?? 0,
      resistenceBoost: (json['resistenceBoost'] as num?)?.toDouble() ?? 0,
      opticalRangeBoost: (json['opticalRangeBoost'] as num?)?.toDouble() ?? 0,
      meleeDamageBoost: (json['meleeDamageBoost'] as num?)?.toDouble() ?? 0,
      rangeDamageBoost: (json['rangeDamageBoost'] as num?)?.toDouble() ?? 0,
      lightDamageBoost: (json['lightDamageBoost'] as num?)?.toDouble() ?? 0,
      damageBoost: (json['damageBoost'] as num?)?.toDouble() ?? 0,
      parryBoost: (json['parryBoost'] as num?)?.toDouble() ?? 0,
      dodgeBoost: (json['dodgeBoost'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_SkillToJson(_$_Skill instance) => <String, dynamic>{
      'id': instance.id,
      'ability': instance.ability,
      'iconUrl': instance.iconUrl,
      'name': instance.name,
      'description': instance.description,
      'healthPointsBoost': instance.healthPointsBoost,
      'lightPointsBoost': instance.lightPointsBoost,
      'movementSpeedBoost': instance.movementSpeedBoost,
      'resistenceBoost': instance.resistenceBoost,
      'opticalRangeBoost': instance.opticalRangeBoost,
      'meleeDamageBoost': instance.meleeDamageBoost,
      'rangeDamageBoost': instance.rangeDamageBoost,
      'lightDamageBoost': instance.lightDamageBoost,
      'damageBoost': instance.damageBoost,
      'parryBoost': instance.parryBoost,
      'dodgeBoost': instance.dodgeBoost,
    };
