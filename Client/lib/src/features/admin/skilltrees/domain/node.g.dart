// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Node _$$_NodeFromJson(Map<String, dynamic> json) => _$_Node(
      id: json['id'] as String,
      importance: json['importance'] as int,
      skill: Skill.fromJson(json['skill'] as Map<String, dynamic>),
      skillId: json['skillId'] as String,
      cost: json['cost'] as int,
      color: json['color'] as String,
      isEasyReachable: json['isEasyReachable'] as bool,
      unlockedAt: json['unlockedAt'] == null
          ? null
          : DateTime.parse(json['unlockedAt'] as String),
      isUnlocked: json['isUnlocked'] ?? false,
      xPos: (json['xPos'] as num?)?.toDouble() ?? 0,
      yPos: (json['yPos'] as num?)?.toDouble() ?? 0,
      precessors: (json['precessors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      successors: (json['successors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_NodeToJson(_$_Node instance) => <String, dynamic>{
      'id': instance.id,
      'importance': instance.importance,
      'skill': instance.skill,
      'skillId': instance.skillId,
      'cost': instance.cost,
      'color': instance.color,
      'isEasyReachable': instance.isEasyReachable,
      'unlockedAt': instance.unlockedAt?.toIso8601String(),
      'isUnlocked': instance.isUnlocked,
      'xPos': instance.xPos,
      'yPos': instance.yPos,
      'precessors': instance.precessors,
      'successors': instance.successors,
    };
