// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Node _$$_NodeFromJson(Map<String, dynamic> json) => _$_Node(
      id: json['id'] as String,
      importance: json['importance'] as int,
      skill: Skill.fromJson(json['skill'] as Map<String, dynamic>),
      cost: json['cost'] as int,
      color: json['color'] as String,
      isEasyReachable: json['isEasyReachable'] as bool,
      xpos: (json['xpos'] as num?)?.toDouble() ?? 0,
      ypos: (json['ypos'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_NodeToJson(_$_Node instance) => <String, dynamic>{
      'id': instance.id,
      'importance': instance.importance,
      'skill': instance.skill,
      'cost': instance.cost,
      'color': instance.color,
      'isEasyReachable': instance.isEasyReachable,
      'xpos': instance.xpos,
      'ypos': instance.ypos,
    };
