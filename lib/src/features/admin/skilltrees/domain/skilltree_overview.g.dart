// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skilltree_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SkilltreeOverview _$$_SkilltreeOverviewFromJson(Map<String, dynamic> json) =>
    _$_SkilltreeOverview(
      id: json['id'] as String,
      name: json['name'] as String,
      character: json['character'] == null
          ? null
          : CharacterOverview.fromJson(
              json['character'] as Map<String, dynamic>),
      points: json['points'] as int,
      isActiveTree: json['isActiveTree'] as bool,
      nodeCount: json['nodeCount'] as int,
    );

Map<String, dynamic> _$$_SkilltreeOverviewToJson(
        _$_SkilltreeOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'character': instance.character,
      'points': instance.points,
      'isActiveTree': instance.isActiveTree,
      'nodeCount': instance.nodeCount,
    };
