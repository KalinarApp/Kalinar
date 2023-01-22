// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookPage _$$_BookPageFromJson(Map<String, dynamic> json) => _$_BookPage(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      title: json['title'] as String,
      pageNumber: json['pageNumber'] as int,
      content: json['content'] as String,
      isWritten: json['isWritten'] as bool? ?? false,
    );

Map<String, dynamic> _$$_BookPageToJson(_$_BookPage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookId': instance.bookId,
      'title': instance.title,
      'pageNumber': instance.pageNumber,
      'content': instance.content,
      'isWritten': instance.isWritten,
    };
