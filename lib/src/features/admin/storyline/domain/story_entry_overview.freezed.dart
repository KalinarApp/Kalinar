// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'story_entry_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoryEntryOverview _$StoryEntryOverviewFromJson(Map<String, dynamic> json) {
  return _StoryEntryOverview.fromJson(json);
}

/// @nodoc
mixin _$StoryEntryOverview {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isUnlocked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryEntryOverviewCopyWith<StoryEntryOverview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryEntryOverviewCopyWith<$Res> {
  factory $StoryEntryOverviewCopyWith(
          StoryEntryOverview value, $Res Function(StoryEntryOverview) then) =
      _$StoryEntryOverviewCopyWithImpl<$Res, StoryEntryOverview>;
  @useResult
  $Res call(
      {String id,
      String title,
      int order,
      String type,
      String? iconUrl,
      String? description,
      bool isUnlocked});
}

/// @nodoc
class _$StoryEntryOverviewCopyWithImpl<$Res, $Val extends StoryEntryOverview>
    implements $StoryEntryOverviewCopyWith<$Res> {
  _$StoryEntryOverviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? order = null,
    Object? type = null,
    Object? iconUrl = freezed,
    Object? description = freezed,
    Object? isUnlocked = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StoryEntryOverviewCopyWith<$Res>
    implements $StoryEntryOverviewCopyWith<$Res> {
  factory _$$_StoryEntryOverviewCopyWith(_$_StoryEntryOverview value,
          $Res Function(_$_StoryEntryOverview) then) =
      __$$_StoryEntryOverviewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      int order,
      String type,
      String? iconUrl,
      String? description,
      bool isUnlocked});
}

/// @nodoc
class __$$_StoryEntryOverviewCopyWithImpl<$Res>
    extends _$StoryEntryOverviewCopyWithImpl<$Res, _$_StoryEntryOverview>
    implements _$$_StoryEntryOverviewCopyWith<$Res> {
  __$$_StoryEntryOverviewCopyWithImpl(
      _$_StoryEntryOverview _value, $Res Function(_$_StoryEntryOverview) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? order = null,
    Object? type = null,
    Object? iconUrl = freezed,
    Object? description = freezed,
    Object? isUnlocked = null,
  }) {
    return _then(_$_StoryEntryOverview(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoryEntryOverview implements _StoryEntryOverview {
  const _$_StoryEntryOverview(
      {required this.id,
      required this.title,
      required this.order,
      required this.type,
      this.iconUrl,
      this.description,
      this.isUnlocked = false});

  factory _$_StoryEntryOverview.fromJson(Map<String, dynamic> json) =>
      _$$_StoryEntryOverviewFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final int order;
  @override
  final String type;
  @override
  final String? iconUrl;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isUnlocked;

  @override
  String toString() {
    return 'StoryEntryOverview(id: $id, title: $title, order: $order, type: $type, iconUrl: $iconUrl, description: $description, isUnlocked: $isUnlocked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoryEntryOverview &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, order, type, iconUrl, description, isUnlocked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoryEntryOverviewCopyWith<_$_StoryEntryOverview> get copyWith =>
      __$$_StoryEntryOverviewCopyWithImpl<_$_StoryEntryOverview>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoryEntryOverviewToJson(
      this,
    );
  }
}

abstract class _StoryEntryOverview implements StoryEntryOverview {
  const factory _StoryEntryOverview(
      {required final String id,
      required final String title,
      required final int order,
      required final String type,
      final String? iconUrl,
      final String? description,
      final bool isUnlocked}) = _$_StoryEntryOverview;

  factory _StoryEntryOverview.fromJson(Map<String, dynamic> json) =
      _$_StoryEntryOverview.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  int get order;
  @override
  String get type;
  @override
  String? get iconUrl;
  @override
  String? get description;
  @override
  bool get isUnlocked;
  @override
  @JsonKey(ignore: true)
  _$$_StoryEntryOverviewCopyWith<_$_StoryEntryOverview> get copyWith =>
      throw _privateConstructorUsedError;
}
