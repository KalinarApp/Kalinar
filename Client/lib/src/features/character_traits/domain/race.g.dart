// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Race _$$_RaceFromJson(Map<String, dynamic> json) => _$_Race(
      json['id'] as String,
      json['groupId'] as String,
      json['creatorId'] as String,
      json['name'] as String,
      json['description'] as String?,
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

Map<String, dynamic> _$$_RaceToJson(_$_Race instance) => <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'creatorId': instance.creatorId,
      'name': instance.name,
      'description': instance.description,
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
