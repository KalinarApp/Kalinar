// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Race _$$_RaceFromJson(Map<String, dynamic> json) => _$_Race(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_RaceToJson(_$_Race instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'attributes': instance.attributes,
    };
