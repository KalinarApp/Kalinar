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
      date: json['date'] as String?,
      imageUrl: json['imageUrl'] as String?,
      pageCount: json['pageCount'] as int?,
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
      'date': instance.date,
      'imageUrl': instance.imageUrl,
      'pageCount': instance.pageCount,
      'description': instance.description,
      'isUnlocked': instance.isUnlocked,
    };
