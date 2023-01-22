// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StoryState {
  List<StoryEntryOverview> get images => throw _privateConstructorUsedError;
  List<StoryEntryOverview> get books => throw _privateConstructorUsedError;
  List<StoryEntryOverview> get history => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StoryStateCopyWith<StoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryStateCopyWith<$Res> {
  factory $StoryStateCopyWith(
          StoryState value, $Res Function(StoryState) then) =
      _$StoryStateCopyWithImpl<$Res, StoryState>;
  @useResult
  $Res call(
      {List<StoryEntryOverview> images,
      List<StoryEntryOverview> books,
      List<StoryEntryOverview> history});
}

/// @nodoc
class _$StoryStateCopyWithImpl<$Res, $Val extends StoryState>
    implements $StoryStateCopyWith<$Res> {
  _$StoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = null,
    Object? books = null,
    Object? history = null,
  }) {
    return _then(_value.copyWith(
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<StoryEntryOverview>,
      books: null == books
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<StoryEntryOverview>,
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<StoryEntryOverview>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StoryStateCopyWith<$Res>
    implements $StoryStateCopyWith<$Res> {
  factory _$$_StoryStateCopyWith(
          _$_StoryState value, $Res Function(_$_StoryState) then) =
      __$$_StoryStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<StoryEntryOverview> images,
      List<StoryEntryOverview> books,
      List<StoryEntryOverview> history});
}

/// @nodoc
class __$$_StoryStateCopyWithImpl<$Res>
    extends _$StoryStateCopyWithImpl<$Res, _$_StoryState>
    implements _$$_StoryStateCopyWith<$Res> {
  __$$_StoryStateCopyWithImpl(
      _$_StoryState _value, $Res Function(_$_StoryState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = null,
    Object? books = null,
    Object? history = null,
  }) {
    return _then(_$_StoryState(
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<StoryEntryOverview>,
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<StoryEntryOverview>,
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<StoryEntryOverview>,
    ));
  }
}

/// @nodoc

class _$_StoryState implements _StoryState {
  const _$_StoryState(
      {final List<StoryEntryOverview> images = const [],
      final List<StoryEntryOverview> books = const [],
      final List<StoryEntryOverview> history = const []})
      : _images = images,
        _books = books,
        _history = history;

  final List<StoryEntryOverview> _images;
  @override
  @JsonKey()
  List<StoryEntryOverview> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<StoryEntryOverview> _books;
  @override
  @JsonKey()
  List<StoryEntryOverview> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  final List<StoryEntryOverview> _history;
  @override
  @JsonKey()
  List<StoryEntryOverview> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  String toString() {
    return 'StoryState(images: $images, books: $books, history: $history)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoryState &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            const DeepCollectionEquality().equals(other._history, _history));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_books),
      const DeepCollectionEquality().hash(_history));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoryStateCopyWith<_$_StoryState> get copyWith =>
      __$$_StoryStateCopyWithImpl<_$_StoryState>(this, _$identity);
}

abstract class _StoryState implements StoryState {
  const factory _StoryState(
      {final List<StoryEntryOverview> images,
      final List<StoryEntryOverview> books,
      final List<StoryEntryOverview> history}) = _$_StoryState;

  @override
  List<StoryEntryOverview> get images;
  @override
  List<StoryEntryOverview> get books;
  @override
  List<StoryEntryOverview> get history;
  @override
  @JsonKey(ignore: true)
  _$$_StoryStateCopyWith<_$_StoryState> get copyWith =>
      throw _privateConstructorUsedError;
}
