// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skilltree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Skilltree _$$_SkilltreeFromJson(Map<String, dynamic> json) => _$_Skilltree(
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

Map<String, dynamic> _$$_SkilltreeToJson(_$_Skilltree instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'character': instance.character,
      'points': instance.points,
      'isActiveTree': instance.isActiveTree,
      'nodes': instance.nodes,
    };
