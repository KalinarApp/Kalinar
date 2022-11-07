// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  Ability? get ability => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get healthPointsBoost => throw _privateConstructorUsedError;
  int get lightPointsBoost => throw _privateConstructorUsedError;
  double get movementSpeedBoost => throw _privateConstructorUsedError;
  double get resistenceBoost => throw _privateConstructorUsedError;
  double get opticalRangeBoost => throw _privateConstructorUsedError;
  double get meleeDamageBoost => throw _privateConstructorUsedError;
  double get rangeDamageBoost => throw _privateConstructorUsedError;
  double get lightDamageBoost => throw _privateConstructorUsedError;
  double get damageBoost => throw _privateConstructorUsedError;
  double get parryBoost => throw _privateConstructorUsedError;
  double get dodgeBoost => throw _privateConstructorUsedError;

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
      Ability? ability,
      String? iconUrl,
      String name,
      String? description,
      int healthPointsBoost,
      int lightPointsBoost,
      double movementSpeedBoost,
      double resistenceBoost,
      double opticalRangeBoost,
      double meleeDamageBoost,
      double rangeDamageBoost,
      double lightDamageBoost,
      double damageBoost,
      double parryBoost,
      double dodgeBoost});

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
    Object? ability = freezed,
    Object? iconUrl = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? healthPointsBoost = null,
    Object? lightPointsBoost = null,
    Object? movementSpeedBoost = null,
    Object? resistenceBoost = null,
    Object? opticalRangeBoost = null,
    Object? meleeDamageBoost = null,
    Object? rangeDamageBoost = null,
    Object? lightDamageBoost = null,
    Object? damageBoost = null,
    Object? parryBoost = null,
    Object? dodgeBoost = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ability: freezed == ability
          ? _value.ability
          : ability // ignore: cast_nullable_to_non_nullable
              as Ability?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      healthPointsBoost: null == healthPointsBoost
          ? _value.healthPointsBoost
          : healthPointsBoost // ignore: cast_nullable_to_non_nullable
              as int,
      lightPointsBoost: null == lightPointsBoost
          ? _value.lightPointsBoost
          : lightPointsBoost // ignore: cast_nullable_to_non_nullable
              as int,
      movementSpeedBoost: null == movementSpeedBoost
          ? _value.movementSpeedBoost
          : movementSpeedBoost // ignore: cast_nullable_to_non_nullable
              as double,
      resistenceBoost: null == resistenceBoost
          ? _value.resistenceBoost
          : resistenceBoost // ignore: cast_nullable_to_non_nullable
              as double,
      opticalRangeBoost: null == opticalRangeBoost
          ? _value.opticalRangeBoost
          : opticalRangeBoost // ignore: cast_nullable_to_non_nullable
              as double,
      meleeDamageBoost: null == meleeDamageBoost
          ? _value.meleeDamageBoost
          : meleeDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      rangeDamageBoost: null == rangeDamageBoost
          ? _value.rangeDamageBoost
          : rangeDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      lightDamageBoost: null == lightDamageBoost
          ? _value.lightDamageBoost
          : lightDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      damageBoost: null == damageBoost
          ? _value.damageBoost
          : damageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      parryBoost: null == parryBoost
          ? _value.parryBoost
          : parryBoost // ignore: cast_nullable_to_non_nullable
              as double,
      dodgeBoost: null == dodgeBoost
          ? _value.dodgeBoost
          : dodgeBoost // ignore: cast_nullable_to_non_nullable
              as double,
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
      Ability? ability,
      String? iconUrl,
      String name,
      String? description,
      int healthPointsBoost,
      int lightPointsBoost,
      double movementSpeedBoost,
      double resistenceBoost,
      double opticalRangeBoost,
      double meleeDamageBoost,
      double rangeDamageBoost,
      double lightDamageBoost,
      double damageBoost,
      double parryBoost,
      double dodgeBoost});

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
    Object? ability = freezed,
    Object? iconUrl = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? healthPointsBoost = null,
    Object? lightPointsBoost = null,
    Object? movementSpeedBoost = null,
    Object? resistenceBoost = null,
    Object? opticalRangeBoost = null,
    Object? meleeDamageBoost = null,
    Object? rangeDamageBoost = null,
    Object? lightDamageBoost = null,
    Object? damageBoost = null,
    Object? parryBoost = null,
    Object? dodgeBoost = null,
  }) {
    return _then(_$_Skill(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ability: freezed == ability
          ? _value.ability
          : ability // ignore: cast_nullable_to_non_nullable
              as Ability?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      healthPointsBoost: null == healthPointsBoost
          ? _value.healthPointsBoost
          : healthPointsBoost // ignore: cast_nullable_to_non_nullable
              as int,
      lightPointsBoost: null == lightPointsBoost
          ? _value.lightPointsBoost
          : lightPointsBoost // ignore: cast_nullable_to_non_nullable
              as int,
      movementSpeedBoost: null == movementSpeedBoost
          ? _value.movementSpeedBoost
          : movementSpeedBoost // ignore: cast_nullable_to_non_nullable
              as double,
      resistenceBoost: null == resistenceBoost
          ? _value.resistenceBoost
          : resistenceBoost // ignore: cast_nullable_to_non_nullable
              as double,
      opticalRangeBoost: null == opticalRangeBoost
          ? _value.opticalRangeBoost
          : opticalRangeBoost // ignore: cast_nullable_to_non_nullable
              as double,
      meleeDamageBoost: null == meleeDamageBoost
          ? _value.meleeDamageBoost
          : meleeDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      rangeDamageBoost: null == rangeDamageBoost
          ? _value.rangeDamageBoost
          : rangeDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      lightDamageBoost: null == lightDamageBoost
          ? _value.lightDamageBoost
          : lightDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      damageBoost: null == damageBoost
          ? _value.damageBoost
          : damageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      parryBoost: null == parryBoost
          ? _value.parryBoost
          : parryBoost // ignore: cast_nullable_to_non_nullable
              as double,
      dodgeBoost: null == dodgeBoost
          ? _value.dodgeBoost
          : dodgeBoost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Skill implements _Skill {
  const _$_Skill(this.id,
      {this.ability,
      this.iconUrl,
      required this.name,
      this.description,
      this.healthPointsBoost = 0,
      this.lightPointsBoost = 0,
      this.movementSpeedBoost = 0,
      this.resistenceBoost = 0,
      this.opticalRangeBoost = 0,
      this.meleeDamageBoost = 0,
      this.rangeDamageBoost = 0,
      this.lightDamageBoost = 0,
      this.damageBoost = 0,
      this.parryBoost = 0,
      this.dodgeBoost = 0});

  factory _$_Skill.fromJson(Map<String, dynamic> json) =>
      _$$_SkillFromJson(json);

  @override
  final String id;
  @override
  final Ability? ability;
  @override
  final String? iconUrl;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final int healthPointsBoost;
  @override
  @JsonKey()
  final int lightPointsBoost;
  @override
  @JsonKey()
  final double movementSpeedBoost;
  @override
  @JsonKey()
  final double resistenceBoost;
  @override
  @JsonKey()
  final double opticalRangeBoost;
  @override
  @JsonKey()
  final double meleeDamageBoost;
  @override
  @JsonKey()
  final double rangeDamageBoost;
  @override
  @JsonKey()
  final double lightDamageBoost;
  @override
  @JsonKey()
  final double damageBoost;
  @override
  @JsonKey()
  final double parryBoost;
  @override
  @JsonKey()
  final double dodgeBoost;

  @override
  String toString() {
    return 'Skill(id: $id, ability: $ability, iconUrl: $iconUrl, name: $name, description: $description, healthPointsBoost: $healthPointsBoost, lightPointsBoost: $lightPointsBoost, movementSpeedBoost: $movementSpeedBoost, resistenceBoost: $resistenceBoost, opticalRangeBoost: $opticalRangeBoost, meleeDamageBoost: $meleeDamageBoost, rangeDamageBoost: $rangeDamageBoost, lightDamageBoost: $lightDamageBoost, damageBoost: $damageBoost, parryBoost: $parryBoost, dodgeBoost: $dodgeBoost)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Skill &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ability, ability) || other.ability == ability) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.healthPointsBoost, healthPointsBoost) ||
                other.healthPointsBoost == healthPointsBoost) &&
            (identical(other.lightPointsBoost, lightPointsBoost) ||
                other.lightPointsBoost == lightPointsBoost) &&
            (identical(other.movementSpeedBoost, movementSpeedBoost) ||
                other.movementSpeedBoost == movementSpeedBoost) &&
            (identical(other.resistenceBoost, resistenceBoost) ||
                other.resistenceBoost == resistenceBoost) &&
            (identical(other.opticalRangeBoost, opticalRangeBoost) ||
                other.opticalRangeBoost == opticalRangeBoost) &&
            (identical(other.meleeDamageBoost, meleeDamageBoost) ||
                other.meleeDamageBoost == meleeDamageBoost) &&
            (identical(other.rangeDamageBoost, rangeDamageBoost) ||
                other.rangeDamageBoost == rangeDamageBoost) &&
            (identical(other.lightDamageBoost, lightDamageBoost) ||
                other.lightDamageBoost == lightDamageBoost) &&
            (identical(other.damageBoost, damageBoost) ||
                other.damageBoost == damageBoost) &&
            (identical(other.parryBoost, parryBoost) ||
                other.parryBoost == parryBoost) &&
            (identical(other.dodgeBoost, dodgeBoost) ||
                other.dodgeBoost == dodgeBoost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      ability,
      iconUrl,
      name,
      description,
      healthPointsBoost,
      lightPointsBoost,
      movementSpeedBoost,
      resistenceBoost,
      opticalRangeBoost,
      meleeDamageBoost,
      rangeDamageBoost,
      lightDamageBoost,
      damageBoost,
      parryBoost,
      dodgeBoost);

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
  const factory _Skill(final String id,
      {final Ability? ability,
      final String? iconUrl,
      required final String name,
      final String? description,
      final int healthPointsBoost,
      final int lightPointsBoost,
      final double movementSpeedBoost,
      final double resistenceBoost,
      final double opticalRangeBoost,
      final double meleeDamageBoost,
      final double rangeDamageBoost,
      final double lightDamageBoost,
      final double damageBoost,
      final double parryBoost,
      final double dodgeBoost}) = _$_Skill;

  factory _Skill.fromJson(Map<String, dynamic> json) = _$_Skill.fromJson;

  @override
  String get id;
  @override
  Ability? get ability;
  @override
  String? get iconUrl;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get healthPointsBoost;
  @override
  int get lightPointsBoost;
  @override
  double get movementSpeedBoost;
  @override
  double get resistenceBoost;
  @override
  double get opticalRangeBoost;
  @override
  double get meleeDamageBoost;
  @override
  double get rangeDamageBoost;
  @override
  double get lightDamageBoost;
  @override
  double get damageBoost;
  @override
  double get parryBoost;
  @override
  double get dodgeBoost;
  @override
  @JsonKey(ignore: true)
  _$$_SkillCopyWith<_$_Skill> get copyWith =>
      throw _privateConstructorUsedError;
}
