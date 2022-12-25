// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupInfo _$GroupInfoFromJson(Map<String, dynamic> json) {
  return _GroupInfo.fromJson(json);
}

/// @nodoc
mixin _$GroupInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupInfoCopyWith<GroupInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupInfoCopyWith<$Res> {
  factory $GroupInfoCopyWith(GroupInfo value, $Res Function(GroupInfo) then) =
      _$GroupInfoCopyWithImpl<$Res, GroupInfo>;
  @useResult
  $Res call({String id, String name, String owner, String? description});
}

/// @nodoc
class _$GroupInfoCopyWithImpl<$Res, $Val extends GroupInfo>
    implements $GroupInfoCopyWith<$Res> {
  _$GroupInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? owner = null,
    Object? description = freezed,
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
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupInfoCopyWith<$Res> implements $GroupInfoCopyWith<$Res> {
  factory _$$_GroupInfoCopyWith(
          _$_GroupInfo value, $Res Function(_$_GroupInfo) then) =
      __$$_GroupInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String owner, String? description});
}

/// @nodoc
class __$$_GroupInfoCopyWithImpl<$Res>
    extends _$GroupInfoCopyWithImpl<$Res, _$_GroupInfo>
    implements _$$_GroupInfoCopyWith<$Res> {
  __$$_GroupInfoCopyWithImpl(
      _$_GroupInfo _value, $Res Function(_$_GroupInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? owner = null,
    Object? description = freezed,
  }) {
    return _then(_$_GroupInfo(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupInfo implements _GroupInfo {
  const _$_GroupInfo(
      {required this.id,
      required this.name,
      required this.owner,
      this.description});

  factory _$_GroupInfo.fromJson(Map<String, dynamic> json) =>
      _$$_GroupInfoFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String owner;
  @override
  final String? description;

  @override
  String toString() {
    return 'GroupInfo(id: $id, name: $name, owner: $owner, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, owner, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupInfoCopyWith<_$_GroupInfo> get copyWith =>
      __$$_GroupInfoCopyWithImpl<_$_GroupInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupInfoToJson(
      this,
    );
  }
}

abstract class _GroupInfo implements GroupInfo {
  const factory _GroupInfo(
      {required final String id,
      required final String name,
      required final String owner,
      final String? description}) = _$_GroupInfo;

  factory _GroupInfo.fromJson(Map<String, dynamic> json) =
      _$_GroupInfo.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get owner;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_GroupInfoCopyWith<_$_GroupInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
