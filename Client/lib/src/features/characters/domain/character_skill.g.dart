// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CharacterSkill _$$_CharacterSkillFromJson(Map<String, dynamic> json) =>
    _$_CharacterSkill(
      json['id'] as String,
      ability: json['ability'] == null
          ? null
          : Ability.fromJson(json['ability'] as Map<String, dynamic>),
      iconUrl: json['iconUrl'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_CharacterSkillToJson(_$_CharacterSkill instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ability': instance.ability,
      'iconUrl': instance.iconUrl,
      'name': instance.name,
      'description': instance.description,
      'isFavorite': instance.isFavorite,
      'attributes': instance.attributes,
    };
