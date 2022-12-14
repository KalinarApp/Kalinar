// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_entry_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoryEntryOverview _$$_StoryEntryOverviewFromJson(
        Map<String, dynamic> json) =>
    _$_StoryEntryOverview(
      id: json['id'] as String,
      title: json['title'] as String,
      order: json['order'] as int,
      type: json['type'] as String,
      iconUrl: json['iconUrl'] as String?,
      description: json['description'] as String?,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$_StoryEntryOverviewToJson(
        _$_StoryEntryOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'type': instance.type,
      'iconUrl': instance.iconUrl,
      'description': instance.description,
      'isUnlocked': instance.isUnlocked,
    };
