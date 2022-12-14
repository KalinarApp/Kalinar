// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'book_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BookPage _$BookPageFromJson(Map<String, dynamic> json) {
  return _BookPage.fromJson(json);
}

/// @nodoc
mixin _$BookPage {
  String get id => throw _privateConstructorUsedError;
  String get bookId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get isWritten => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookPageCopyWith<BookPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookPageCopyWith<$Res> {
  factory $BookPageCopyWith(BookPage value, $Res Function(BookPage) then) =
      _$BookPageCopyWithImpl<$Res, BookPage>;
  @useResult
  $Res call(
      {String id,
      String bookId,
      String title,
      int pageNumber,
      String content,
      bool isWritten});
}

/// @nodoc
class _$BookPageCopyWithImpl<$Res, $Val extends BookPage>
    implements $BookPageCopyWith<$Res> {
  _$BookPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? title = null,
    Object? pageNumber = null,
    Object? content = null,
    Object? isWritten = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isWritten: null == isWritten
          ? _value.isWritten
          : isWritten // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookPageCopyWith<$Res> implements $BookPageCopyWith<$Res> {
  factory _$$_BookPageCopyWith(
          _$_BookPage value, $Res Function(_$_BookPage) then) =
      __$$_BookPageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String bookId,
      String title,
      int pageNumber,
      String content,
      bool isWritten});
}

/// @nodoc
class __$$_BookPageCopyWithImpl<$Res>
    extends _$BookPageCopyWithImpl<$Res, _$_BookPage>
    implements _$$_BookPageCopyWith<$Res> {
  __$$_BookPageCopyWithImpl(
      _$_BookPage _value, $Res Function(_$_BookPage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? title = null,
    Object? pageNumber = null,
    Object? content = null,
    Object? isWritten = null,
  }) {
    return _then(_$_BookPage(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isWritten: null == isWritten
          ? _value.isWritten
          : isWritten // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BookPage implements _BookPage {
  const _$_BookPage(
      {required this.id,
      required this.bookId,
      required this.title,
      required this.pageNumber,
      required this.content,
      this.isWritten = false});

  factory _$_BookPage.fromJson(Map<String, dynamic> json) =>
      _$$_BookPageFromJson(json);

  @override
  final String id;
  @override
  final String bookId;
  @override
  final String title;
  @override
  final int pageNumber;
  @override
  final String content;
  @override
  @JsonKey()
  final bool isWritten;

  @override
  String toString() {
    return 'BookPage(id: $id, bookId: $bookId, title: $title, pageNumber: $pageNumber, content: $content, isWritten: $isWritten)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookPage &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isWritten, isWritten) ||
                other.isWritten == isWritten));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, bookId, title, pageNumber, content, isWritten);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookPageCopyWith<_$_BookPage> get copyWith =>
      __$$_BookPageCopyWithImpl<_$_BookPage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookPageToJson(
      this,
    );
  }
}

abstract class _BookPage implements BookPage {
  const factory _BookPage(
      {required final String id,
      required final String bookId,
      required final String title,
      required final int pageNumber,
      required final String content,
      final bool isWritten}) = _$_BookPage;

  factory _BookPage.fromJson(Map<String, dynamic> json) = _$_BookPage.fromJson;

  @override
  String get id;
  @override
  String get bookId;
  @override
  String get title;
  @override
  int get pageNumber;
  @override
  String get content;
  @override
  bool get isWritten;
  @override
  @JsonKey(ignore: true)
  _$$_BookPageCopyWith<_$_BookPage> get copyWith =>
      throw _privateConstructorUsedError;
}
