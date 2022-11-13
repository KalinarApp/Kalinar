// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Attribute _$$_AttributeFromJson(Map<String, dynamic> json) => _$_Attribute(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      iconData: json['iconData'] as String?,
      stepSize: (json['stepSize'] as num?)?.toDouble() ?? 1,
      minValue: (json['minValue'] as num?)?.toDouble() ?? 0,
      maxValue: (json['maxValue'] as num?)?.toDouble() ?? 10,
      isGlobal: json['isGlobal'] as bool? ?? false,
    );

Map<String, dynamic> _$$_AttributeToJson(_$_Attribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconData': instance.iconData,
      'stepSize': instance.stepSize,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'isGlobal': instance.isGlobal,
    };
