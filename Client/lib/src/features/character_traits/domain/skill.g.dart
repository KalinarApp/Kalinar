// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Skill _$$_SkillFromJson(Map<String, dynamic> json) => _$_Skill(
      json['id'] as String,
      json['groupId'] as String,
      json['creatorId'] as String,
      json['name'] as String,
      json['iconUrl'] as String?,
      json['description'] as String?,
      json['abilityId'] as String?,
      json['ability'] == null
          ? null
          : Ability.fromJson(json['ability'] as Map<String, dynamic>),
      $enumDecode(_$SuggestionStateEnumMap, json['state']),
      json['rejectionReason'] as String?,
      DateTime.parse(json['createdAt'] as String),
      json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
      json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
    );

Map<String, dynamic> _$$_SkillToJson(_$_Skill instance) => <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'creatorId': instance.creatorId,
      'name': instance.name,
      'iconUrl': instance.iconUrl,
      'description': instance.description,
      'abilityId': instance.abilityId,
      'ability': instance.ability,
      'state': _$SuggestionStateEnumMap[instance.state]!,
      'rejectionReason': instance.rejectionReason,
      'createdAt': instance.createdAt.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'rejectedAt': instance.rejectedAt?.toIso8601String(),
    };

const _$SuggestionStateEnumMap = {
  SuggestionState.pending: 'Pending',
  SuggestionState.approved: 'Approved',
  SuggestionState.rejected: 'Rejected',
};
