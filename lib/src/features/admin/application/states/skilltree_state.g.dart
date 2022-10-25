// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skilltree_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SkilltreeState _$$_SkilltreeStateFromJson(Map<String, dynamic> json) =>
    _$_SkilltreeState(
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      edges: (json['edges'] as List<dynamic>?)
              ?.map((e) => Edge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_SkilltreeStateToJson(_$_SkilltreeState instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
      'edges': instance.edges,
    };
