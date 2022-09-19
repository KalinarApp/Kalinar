// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
      name: json['name'] as String,
      description: json['description'] as String,
      isPassive: json['isPassive'] as bool,
    );

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'name': instance.name,
      'isPassive': instance.isPassive,
      'description': instance.description,
    };
