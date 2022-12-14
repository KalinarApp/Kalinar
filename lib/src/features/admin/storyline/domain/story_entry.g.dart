// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoryEntry _$$_StoryEntryFromJson(Map<String, dynamic> json) =>
    _$_StoryEntry(
      id: json['id'] as String,
      title: json['title'] as String,
      order: json['order'] as int,
      type: json['type'] as String,
      iconUrl: json['iconUrl'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      pages: (json['pages'] as List<dynamic>?)
              ?.map((e) => BookPage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isUnlocked: json['isUnlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$_StoryEntryToJson(_$_StoryEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'type': instance.type,
      'iconUrl': instance.iconUrl,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'pages': instance.pages,
      'isUnlocked': instance.isUnlocked,
    };
