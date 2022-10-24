// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Node _$$_NodeFromJson(Map<String, dynamic> json) => _$_Node(
      importance: json['importance'] as int,
      skill: Skill.fromJson(json['skill'] as Map<String, dynamic>),
      cost: json['cost'] as int,
      color: json['color'] as String,
      isEasyReachable: json['isEasyReachable'] as bool,
    );

Map<String, dynamic> _$$_NodeToJson(_$_Node instance) => <String, dynamic>{
      'importance': instance.importance,
      'skill': instance.skill,
      'cost': instance.cost,
      'color': instance.color,
      'isEasyReachable': instance.isEasyReachable,
    };
