// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Attribute _$$_AttributeFromJson(Map<String, dynamic> json) => _$_Attribute(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      iconData: json['iconData'] as String?,
      stepSize: (json['stepSize'] as num?)?.toDouble() ?? 1,
      minValue: (json['minValue'] as num?)?.toDouble() ?? 0,
      maxValue: (json['maxValue'] as num?)?.toDouble() ?? 10,
      isGlobal: json['isGlobal'] as bool? ?? false,
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

Map<String, dynamic> _$$_AttributeToJson(_$_Attribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'iconData': instance.iconData,
      'stepSize': instance.stepSize,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'isGlobal': instance.isGlobal,
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
  SuggestionState.rejected: 'Rejected',
};
