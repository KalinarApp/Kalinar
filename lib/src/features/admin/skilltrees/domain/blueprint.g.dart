// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blueprint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Blueprint _$$_BlueprintFromJson(Map<String, dynamic> json) => _$_Blueprint(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      character: json['character'] == null
          ? null
          : CharacterOverview.fromJson(
              json['character'] as Map<String, dynamic>),
      points: json['points'] as int? ?? 0,
      isActiveTree: json['isActiveTree'] as bool? ?? true,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_BlueprintToJson(_$_Blueprint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'character': instance.character,
      'points': instance.points,
      'isActiveTree': instance.isActiveTree,
      'nodes': instance.nodes,
    };
