// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$GroupInfoCopyWithImpl<$Res>;
  $Res call({String id, String name, String owner, String? description});
}

/// @nodoc
class _$GroupInfoCopyWithImpl<$Res> implements $GroupInfoCopyWith<$Res> {
  _$GroupInfoCopyWithImpl(this._value, this._then);

  final GroupInfo _value;
  // ignore: unused_field
  final $Res Function(GroupInfo) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? owner = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_GroupInfoCopyWith<$Res> implements $GroupInfoCopyWith<$Res> {
  factory _$$_GroupInfoCopyWith(
          _$_GroupInfo value, $Res Function(_$_GroupInfo) then) =
      __$$_GroupInfoCopyWithImpl<$Res>;
  @override
  $Res call({String id, String name, String owner, String? description});
}

/// @nodoc
class __$$_GroupInfoCopyWithImpl<$Res> extends _$GroupInfoCopyWithImpl<$Res>
    implements _$$_GroupInfoCopyWith<$Res> {
  __$$_GroupInfoCopyWithImpl(
      _$_GroupInfo _value, $Res Function(_$_GroupInfo) _then)
      : super(_value, (v) => _then(v as _$_GroupInfo));

  @override
  _$_GroupInfo get _value => super._value as _$_GroupInfo;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? owner = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_GroupInfo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
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
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.owner, owner) &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(owner),
      const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
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
