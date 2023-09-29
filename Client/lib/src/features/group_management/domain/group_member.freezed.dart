// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupMember _$GroupMemberFromJson(Map<String, dynamic> json) {
  return _GroupMember.fromJson(json);
}

/// @nodoc
mixin _$GroupMember {
  Group get group => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  Role get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupMemberCopyWith<GroupMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupMemberCopyWith<$Res> {
  factory $GroupMemberCopyWith(
          GroupMember value, $Res Function(GroupMember) then) =
      _$GroupMemberCopyWithImpl<$Res, GroupMember>;
  @useResult
  $Res call({Group group, User user, Role role});

  $GroupCopyWith<$Res> get group;
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$GroupMemberCopyWithImpl<$Res, $Val extends GroupMember>
    implements $GroupMemberCopyWith<$Res> {
  _$GroupMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? user = null,
    Object? role = null,
  }) {
    return _then(_value.copyWith(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupCopyWith<$Res> get group {
    return $GroupCopyWith<$Res>(_value.group, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GroupMemberCopyWith<$Res>
    implements $GroupMemberCopyWith<$Res> {
  factory _$$_GroupMemberCopyWith(
          _$_GroupMember value, $Res Function(_$_GroupMember) then) =
      __$$_GroupMemberCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Group group, User user, Role role});

  @override
  $GroupCopyWith<$Res> get group;
  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_GroupMemberCopyWithImpl<$Res>
    extends _$GroupMemberCopyWithImpl<$Res, _$_GroupMember>
    implements _$$_GroupMemberCopyWith<$Res> {
  __$$_GroupMemberCopyWithImpl(
      _$_GroupMember _value, $Res Function(_$_GroupMember) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? user = null,
    Object? role = null,
  }) {
    return _then(_$_GroupMember(
      null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group,
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupMember implements _GroupMember {
  _$_GroupMember(this.group, this.user, this.role);

  factory _$_GroupMember.fromJson(Map<String, dynamic> json) =>
      _$$_GroupMemberFromJson(json);

  @override
  final Group group;
  @override
  final User user;
  @override
  final Role role;

  @override
  String toString() {
    return 'GroupMember(group: $group, user: $user, role: $role)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupMember &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, group, user, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupMemberCopyWith<_$_GroupMember> get copyWith =>
      __$$_GroupMemberCopyWithImpl<_$_GroupMember>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupMemberToJson(
      this,
    );
  }
}

abstract class _GroupMember implements GroupMember {
  factory _GroupMember(final Group group, final User user, final Role role) =
      _$_GroupMember;

  factory _GroupMember.fromJson(Map<String, dynamic> json) =
      _$_GroupMember.fromJson;

  @override
  Group get group;
  @override
  User get user;
  @override
  Role get role;
  @override
  @JsonKey(ignore: true)
  _$$_GroupMemberCopyWith<_$_GroupMember> get copyWith =>
      throw _privateConstructorUsedError;
}
