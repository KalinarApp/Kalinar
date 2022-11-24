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
      description: json['description'] as String?,
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_SkillToJson(_$_Skill instance) => <String, dynamic>{
      'id': instance.id,
      'ability': instance.ability,
      'iconUrl': instance.iconUrl,
      'name': instance.name,
      'description': instance.description,
      'attributes': instance.attributes,
    };
