// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skillpoints.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Skillpoints _$$_SkillpointsFromJson(Map<String, dynamic> json) => _$_Skillpoints(
      currentSkillpoints: json['currentSkillpoints'] as int? ?? 0,
      maxSkillpoints: json['maxSkillpoints'] as int? ?? 0,
      iconUrl: json['iconUrl'] as String?,
    );

Map<String, dynamic> _$$_SkillpointsToJson(_$_Skillpoints instance) => <String, dynamic>{
      'currentSkillpoints': instance.currentSkillpoints,
      'maxSkillpoints': instance.maxSkillpoints,
      'iconUrl': instance.iconUrl,
    };
