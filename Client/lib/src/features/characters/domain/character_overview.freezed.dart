// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CharacterOverview _$CharacterOverviewFromJson(Map<String, dynamic> json) {
  return _CharacterOverview.fromJson(json);
}

/// @nodoc
mixin _$CharacterOverview {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  List<SkilltreeOverview> get skilltrees => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterOverviewCopyWith<CharacterOverview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterOverviewCopyWith<$Res> {
  factory $CharacterOverviewCopyWith(
          CharacterOverview value, $Res Function(CharacterOverview) then) =
      _$CharacterOverviewCopyWithImpl<$Res, CharacterOverview>;
  @useResult
  $Res call(
      {String id,
      String name,
      String userId,
      String? iconUrl,
      List<SkilltreeOverview> skilltrees});
}

/// @nodoc
class _$CharacterOverviewCopyWithImpl<$Res, $Val extends CharacterOverview>
    implements $CharacterOverviewCopyWith<$Res> {
  _$CharacterOverviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? userId = null,
    Object? iconUrl = freezed,
    Object? skilltrees = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      skilltrees: null == skilltrees
          ? _value.skilltrees
          : skilltrees // ignore: cast_nullable_to_non_nullable
              as List<SkilltreeOverview>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CharacterOverviewCopyWith<$Res>
    implements $CharacterOverviewCopyWith<$Res> {
  factory _$$_CharacterOverviewCopyWith(_$_CharacterOverview value,
          $Res Function(_$_CharacterOverview) then) =
      __$$_CharacterOverviewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String userId,
      String? iconUrl,
      List<SkilltreeOverview> skilltrees});
}

/// @nodoc
class __$$_CharacterOverviewCopyWithImpl<$Res>
    extends _$CharacterOverviewCopyWithImpl<$Res, _$_CharacterOverview>
    implements _$$_CharacterOverviewCopyWith<$Res> {
  __$$_CharacterOverviewCopyWithImpl(
      _$_CharacterOverview _value, $Res Function(_$_CharacterOverview) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? userId = null,
    Object? iconUrl = freezed,
    Object? skilltrees = null,
  }) {
    return _then(_$_CharacterOverview(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      skilltrees: null == skilltrees
          ? _value._skilltrees
          : skilltrees // ignore: cast_nullable_to_non_nullable
              as List<SkilltreeOverview>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CharacterOverview implements _CharacterOverview {
  const _$_CharacterOverview(
      {required this.id,
      required this.name,
      required this.userId,
      this.iconUrl,
      final List<SkilltreeOverview> skilltrees = const []})
      : _skilltrees = skilltrees;

  factory _$_CharacterOverview.fromJson(Map<String, dynamic> json) =>
      _$$_CharacterOverviewFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String userId;
  @override
  final String? iconUrl;
  final List<SkilltreeOverview> _skilltrees;
  @override
  @JsonKey()
  List<SkilltreeOverview> get skilltrees {
    if (_skilltrees is EqualUnmodifiableListView) return _skilltrees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skilltrees);
  }

  @override
  String toString() {
    return 'CharacterOverview(id: $id, name: $name, userId: $userId, iconUrl: $iconUrl, skilltrees: $skilltrees)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CharacterOverview &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            const DeepCollectionEquality()
                .equals(other._skilltrees, _skilltrees));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, userId, iconUrl,
      const DeepCollectionEquality().hash(_skilltrees));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CharacterOverviewCopyWith<_$_CharacterOverview> get copyWith =>
      __$$_CharacterOverviewCopyWithImpl<_$_CharacterOverview>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharacterOverviewToJson(
      this,
    );
  }
}

abstract class _CharacterOverview implements CharacterOverview {
  const factory _CharacterOverview(
      {required final String id,
      required final String name,
      required final String userId,
      final String? iconUrl,
      final List<SkilltreeOverview> skilltrees}) = _$_CharacterOverview;

  factory _CharacterOverview.fromJson(Map<String, dynamic> json) =
      _$_CharacterOverview.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get userId;
  @override
  String? get iconUrl;
  @override
  List<SkilltreeOverview> get skilltrees;
  @override
  @JsonKey(ignore: true)
  _$$_CharacterOverviewCopyWith<_$_CharacterOverview> get copyWith =>
      throw _privateConstructorUsedError;
}
