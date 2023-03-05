// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ability _$$_AbilityFromJson(Map<String, dynamic> json) => _$_Ability(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      isPassive: json['isPassive'] as bool,
      creator: User.fromJson(json['creator'] as Map<String, dynamic>),
      state: $enumDecode(_$SuggestionStateEnumMap, json['state']),
      rejectionReason: json['rejectionReason'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdatedAt: json['lastUpdatedAt'] == null
          ? null
          : DateTime.parse(json['lastUpdatedAt'] as String),
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      rejectedAt: json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
    );

Map<String, dynamic> _$$_AbilityToJson(_$_Ability instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isPassive': instance.isPassive,
      'creator': instance.creator,
      'state': _$SuggestionStateEnumMap[instance.state]!,
      'rejectionReason': instance.rejectionReason,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastUpdatedAt': instance.lastUpdatedAt?.toIso8601String(),
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'rejectedAt': instance.rejectedAt?.toIso8601String(),
    };

const _$SuggestionStateEnumMap = {
  SuggestionState.pending: 'Pending',
  SuggestionState.approved: 'Approved',
  SuggestionState.rejected: 'rejected',
};
