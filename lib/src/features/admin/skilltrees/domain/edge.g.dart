// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Edge _$$_EdgeFromJson(Map<String, dynamic> json) => _$_Edge(
      start: Node.fromJson(json['start'] as Map<String, dynamic>),
      end: Node.fromJson(json['end'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EdgeToJson(_$_Edge instance) => <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };
