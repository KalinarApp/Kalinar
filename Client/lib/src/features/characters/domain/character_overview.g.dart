// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CharacterOverview _$$_CharacterOverviewFromJson(Map<String, dynamic> json) =>
    _$_CharacterOverview(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
      description: json['description'] as String?,
      iconUrl: json['iconUrl'] as String?,
    );

Map<String, dynamic> _$$_CharacterOverviewToJson(
        _$_CharacterOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
    };
