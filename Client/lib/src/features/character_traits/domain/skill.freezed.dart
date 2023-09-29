// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return _Skill.fromJson(json);
}

/// @nodoc
mixin _$Skill {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get creatorId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get abilityId => throw _privateConstructorUsedError;
  Ability? get ability => throw _privateConstructorUsedError;
  SuggestionState get state => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get modifiedAt => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  DateTime? get rejectedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkillCopyWith<Skill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) then) =
      _$SkillCopyWithImpl<$Res, Skill>;
  @useResult
  $Res call(
      {String id,
      String groupId,
      String creatorId,
      String name,
      String? iconUrl,
      String? description,
      String? abilityId,
      Ability? ability,
      SuggestionState state,
      String? rejectionReason,
      DateTime createdAt,
      DateTime? modifiedAt,
      DateTime? approvedAt,
      DateTime? rejectedAt});

  $AbilityCopyWith<$Res>? get ability;
}

/// @nodoc
class _$SkillCopyWithImpl<$Res, $Val extends Skill>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? creatorId = null,
    Object? name = null,
    Object? iconUrl = freezed,
    Object? description = freezed,
    Object? abilityId = freezed,
    Object? ability = freezed,
    Object? state = null,
    Object? rejectionReason = freezed,
    Object? createdAt = null,
    Object? modifiedAt = freezed,
    Object? approvedAt = freezed,
    Object? rejectedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      abilityId: freezed == abilityId
          ? _value.abilityId
          : abilityId // ignore: cast_nullable_to_non_nullable
              as String?,
      ability: freezed == ability
          ? _value.ability
          : ability // ignore: cast_nullable_to_non_nullable
              as Ability?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as SuggestionState,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedAt: freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AbilityCopyWith<$Res>? get ability {
    if (_value.ability == null) {
      return null;
    }

    return $AbilityCopyWith<$Res>(_value.ability!, (value) {
      return _then(_value.copyWith(ability: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SkillCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$$_SkillCopyWith(_$_Skill value, $Res Function(_$_Skill) then) =
      __$$_SkillCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String groupId,
      String creatorId,
      String name,
      String? iconUrl,
      String? description,
      String? abilityId,
      Ability? ability,
      SuggestionState state,
      String? rejectionReason,
      DateTime createdAt,
      DateTime? modifiedAt,
      DateTime? approvedAt,
      DateTime? rejectedAt});

  @override
  $AbilityCopyWith<$Res>? get ability;
}

/// @nodoc
class __$$_SkillCopyWithImpl<$Res> extends _$SkillCopyWithImpl<$Res, _$_Skill>
    implements _$$_SkillCopyWith<$Res> {
  __$$_SkillCopyWithImpl(_$_Skill _value, $Res Function(_$_Skill) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? creatorId = null,
    Object? name = null,
    Object? iconUrl = freezed,
    Object? description = freezed,
    Object? abilityId = freezed,
    Object? ability = freezed,
    Object? state = null,
    Object? rejectionReason = freezed,
    Object? createdAt = null,
    Object? modifiedAt = freezed,
    Object? approvedAt = freezed,
    Object? rejectedAt = freezed,
  }) {
    return _then(_$_Skill(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == abilityId
          ? _value.abilityId
          : abilityId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == ability
          ? _value.ability
          : ability // ignore: cast_nullable_to_non_nullable
              as Ability?,
      null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as SuggestionState,
      freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Skill implements _Skill {
  _$_Skill(
      this.id,
      this.groupId,
      this.creatorId,
      this.name,
      this.iconUrl,
      this.description,
      this.abilityId,
      this.ability,
      this.state,
      this.rejectionReason,
      this.createdAt,
      this.modifiedAt,
      this.approvedAt,
      this.rejectedAt);

  factory _$_Skill.fromJson(Map<String, dynamic> json) =>
      _$$_SkillFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String creatorId;
  @override
  final String name;
  @override
  final String? iconUrl;
  @override
  final String? description;
  @override
  final String? abilityId;
  @override
  final Ability? ability;
  @override
  final SuggestionState state;
  @override
  final String? rejectionReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime? modifiedAt;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? rejectedAt;

  @override
  String toString() {
    return 'Skill(id: $id, groupId: $groupId, creatorId: $creatorId, name: $name, iconUrl: $iconUrl, description: $description, abilityId: $abilityId, ability: $ability, state: $state, rejectionReason: $rejectionReason, createdAt: $createdAt, modifiedAt: $modifiedAt, approvedAt: $approvedAt, rejectedAt: $rejectedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Skill &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.abilityId, abilityId) ||
                other.abilityId == abilityId) &&
            (identical(other.ability, ability) || other.ability == ability) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.rejectedAt, rejectedAt) ||
                other.rejectedAt == rejectedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      groupId,
      creatorId,
      name,
      iconUrl,
      description,
      abilityId,
      ability,
      state,
      rejectionReason,
      createdAt,
      modifiedAt,
      approvedAt,
      rejectedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SkillCopyWith<_$_Skill> get copyWith =>
      __$$_SkillCopyWithImpl<_$_Skill>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SkillToJson(
      this,
    );
  }
}

abstract class _Skill implements Skill {
  factory _Skill(
      final String id,
      final String groupId,
      final String creatorId,
      final String name,
      final String? iconUrl,
      final String? description,
      final String? abilityId,
      final Ability? ability,
      final SuggestionState state,
      final String? rejectionReason,
      final DateTime createdAt,
      final DateTime? modifiedAt,
      final DateTime? approvedAt,
      final DateTime? rejectedAt) = _$_Skill;

  factory _Skill.fromJson(Map<String, dynamic> json) = _$_Skill.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get creatorId;
  @override
  String get name;
  @override
  String? get iconUrl;
  @override
  String? get description;
  @override
  String? get abilityId;
  @override
  Ability? get ability;
  @override
  SuggestionState get state;
  @override
  String? get rejectionReason;
  @override
  DateTime get createdAt;
  @override
  DateTime? get modifiedAt;
  @override
  DateTime? get approvedAt;
  @override
  DateTime? get rejectedAt;
  @override
  @JsonKey(ignore: true)
  _$$_SkillCopyWith<_$_Skill> get copyWith =>
      throw _privateConstructorUsedError;
}
