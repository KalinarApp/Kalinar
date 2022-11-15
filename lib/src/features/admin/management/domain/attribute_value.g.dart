// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AttributeValue _$$_AttributeValueFromJson(Map<String, dynamic> json) =>
    _$_AttributeValue(
      attributeId: json['attributeId'] as String,
      attribute: Attribute.fromJson(json['attribute'] as Map<String, dynamic>),
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$$_AttributeValueToJson(_$_AttributeValue instance) =>
    <String, dynamic>{
      'attributeId': instance.attributeId,
      'attribute': instance.attribute,
      'value': instance.value,
    };
