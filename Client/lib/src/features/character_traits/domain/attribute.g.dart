// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Attribute _$$_AttributeFromJson(Map<String, dynamic> json) => _$_Attribute(
      json['id'] as String,
      json['groupId'] as String,
      json['creatorId'] as String,
      json['name'] as String,
      json['iconData'] as String?,
      json['description'] as String?,
      json['category'] as String?,
      (json['stepSize'] as num).toDouble(),
      (json['minValue'] as num).toDouble(),
      (json['maxValue'] as num).toDouble(),
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

Map<String, dynamic> _$$_AttributeToJson(_$_Attribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'creatorId': instance.creatorId,
      'name': instance.name,
      'iconData': instance.iconData,
      'description': instance.description,
      'category': instance.category,
      'stepSize': instance.stepSize,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
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
