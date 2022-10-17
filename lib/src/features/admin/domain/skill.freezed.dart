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
  String get description => throw _privateConstructorUsedError;
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
      _$SkillCopyWithImpl<$Res>;
  $Res call(
      {String id,
      Ability? ability,
      String? iconUrl,
      String name,
      String description,
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
class _$SkillCopyWithImpl<$Res> implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  final Skill _value;
  // ignore: unused_field
  final $Res Function(Skill) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? ability = freezed,
    Object? iconUrl = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? healthPointsBoost = freezed,
    Object? lightPointsBoost = freezed,
    Object? movementSpeedBoost = freezed,
    Object? resistenceBoost = freezed,
    Object? opticalRangeBoost = freezed,
    Object? meleeDamageBoost = freezed,
    Object? rangeDamageBoost = freezed,
    Object? lightDamageBoost = freezed,
    Object? damageBoost = freezed,
    Object? parryBoost = freezed,
    Object? dodgeBoost = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ability: ability == freezed
          ? _value.ability
          : ability // ignore: cast_nullable_to_non_nullable
              as Ability?,
      iconUrl: iconUrl == freezed
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      healthPointsBoost: healthPointsBoost == freezed
          ? _value.healthPointsBoost
          : healthPointsBoost // ignore: cast_nullable_to_non_nullable
              as int,
      lightPointsBoost: lightPointsBoost == freezed
          ? _value.lightPointsBoost
          : lightPointsBoost // ignore: cast_nullable_to_non_nullable
              as int,
      movementSpeedBoost: movementSpeedBoost == freezed
          ? _value.movementSpeedBoost
          : movementSpeedBoost // ignore: cast_nullable_to_non_nullable
              as double,
      resistenceBoost: resistenceBoost == freezed
          ? _value.resistenceBoost
          : resistenceBoost // ignore: cast_nullable_to_non_nullable
              as double,
      opticalRangeBoost: opticalRangeBoost == freezed
          ? _value.opticalRangeBoost
          : opticalRangeBoost // ignore: cast_nullable_to_non_nullable
              as double,
      meleeDamageBoost: meleeDamageBoost == freezed
          ? _value.meleeDamageBoost
          : meleeDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      rangeDamageBoost: rangeDamageBoost == freezed
          ? _value.rangeDamageBoost
          : rangeDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      lightDamageBoost: lightDamageBoost == freezed
          ? _value.lightDamageBoost
          : lightDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      damageBoost: damageBoost == freezed
          ? _value.damageBoost
          : damageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      parryBoost: parryBoost == freezed
          ? _value.parryBoost
          : parryBoost // ignore: cast_nullable_to_non_nullable
              as double,
      dodgeBoost: dodgeBoost == freezed
          ? _value.dodgeBoost
          : dodgeBoost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  @override
  $AbilityCopyWith<$Res>? get ability {
    if (_value.ability == null) {
      return null;
    }

    return $AbilityCopyWith<$Res>(_value.ability!, (value) {
      return _then(_value.copyWith(ability: value));
    });
  }
}

/// @nodoc
abstract class _$$_SkillCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$$_SkillCopyWith(_$_Skill value, $Res Function(_$_Skill) then) =
      __$$_SkillCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      Ability? ability,
      String? iconUrl,
      String name,
      String description,
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
class __$$_SkillCopyWithImpl<$Res> extends _$SkillCopyWithImpl<$Res>
    implements _$$_SkillCopyWith<$Res> {
  __$$_SkillCopyWithImpl(_$_Skill _value, $Res Function(_$_Skill) _then)
      : super(_value, (v) => _then(v as _$_Skill));

  @override
  _$_Skill get _value => super._value as _$_Skill;

  @override
  $Res call({
    Object? id = freezed,
    Object? ability = freezed,
    Object? iconUrl = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? healthPointsBoost = freezed,
    Object? lightPointsBoost = freezed,
    Object? movementSpeedBoost = freezed,
    Object? resistenceBoost = freezed,
    Object? opticalRangeBoost = freezed,
    Object? meleeDamageBoost = freezed,
    Object? rangeDamageBoost = freezed,
    Object? lightDamageBoost = freezed,
    Object? damageBoost = freezed,
    Object? parryBoost = freezed,
    Object? dodgeBoost = freezed,
  }) {
    return _then(_$_Skill(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ability: ability == freezed
          ? _value.ability
          : ability // ignore: cast_nullable_to_non_nullable
              as Ability?,
      iconUrl: iconUrl == freezed
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      healthPointsBoost: healthPointsBoost == freezed
          ? _value.healthPointsBoost
          : healthPointsBoost // ignore: cast_nullable_to_non_nullable
              as int,
      lightPointsBoost: lightPointsBoost == freezed
          ? _value.lightPointsBoost
          : lightPointsBoost // ignore: cast_nullable_to_non_nullable
              as int,
      movementSpeedBoost: movementSpeedBoost == freezed
          ? _value.movementSpeedBoost
          : movementSpeedBoost // ignore: cast_nullable_to_non_nullable
              as double,
      resistenceBoost: resistenceBoost == freezed
          ? _value.resistenceBoost
          : resistenceBoost // ignore: cast_nullable_to_non_nullable
              as double,
      opticalRangeBoost: opticalRangeBoost == freezed
          ? _value.opticalRangeBoost
          : opticalRangeBoost // ignore: cast_nullable_to_non_nullable
              as double,
      meleeDamageBoost: meleeDamageBoost == freezed
          ? _value.meleeDamageBoost
          : meleeDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      rangeDamageBoost: rangeDamageBoost == freezed
          ? _value.rangeDamageBoost
          : rangeDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      lightDamageBoost: lightDamageBoost == freezed
          ? _value.lightDamageBoost
          : lightDamageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      damageBoost: damageBoost == freezed
          ? _value.damageBoost
          : damageBoost // ignore: cast_nullable_to_non_nullable
              as double,
      parryBoost: parryBoost == freezed
          ? _value.parryBoost
          : parryBoost // ignore: cast_nullable_to_non_nullable
              as double,
      dodgeBoost: dodgeBoost == freezed
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
      required this.description,
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
  final String description;
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
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.ability, ability) &&
            const DeepCollectionEquality().equals(other.iconUrl, iconUrl) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.healthPointsBoost, healthPointsBoost) &&
            const DeepCollectionEquality()
                .equals(other.lightPointsBoost, lightPointsBoost) &&
            const DeepCollectionEquality()
                .equals(other.movementSpeedBoost, movementSpeedBoost) &&
            const DeepCollectionEquality()
                .equals(other.resistenceBoost, resistenceBoost) &&
            const DeepCollectionEquality()
                .equals(other.opticalRangeBoost, opticalRangeBoost) &&
            const DeepCollectionEquality()
                .equals(other.meleeDamageBoost, meleeDamageBoost) &&
            const DeepCollectionEquality()
                .equals(other.rangeDamageBoost, rangeDamageBoost) &&
            const DeepCollectionEquality()
                .equals(other.lightDamageBoost, lightDamageBoost) &&
            const DeepCollectionEquality()
                .equals(other.damageBoost, damageBoost) &&
            const DeepCollectionEquality()
                .equals(other.parryBoost, parryBoost) &&
            const DeepCollectionEquality()
                .equals(other.dodgeBoost, dodgeBoost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(ability),
      const DeepCollectionEquality().hash(iconUrl),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(healthPointsBoost),
      const DeepCollectionEquality().hash(lightPointsBoost),
      const DeepCollectionEquality().hash(movementSpeedBoost),
      const DeepCollectionEquality().hash(resistenceBoost),
      const DeepCollectionEquality().hash(opticalRangeBoost),
      const DeepCollectionEquality().hash(meleeDamageBoost),
      const DeepCollectionEquality().hash(rangeDamageBoost),
      const DeepCollectionEquality().hash(lightDamageBoost),
      const DeepCollectionEquality().hash(damageBoost),
      const DeepCollectionEquality().hash(parryBoost),
      const DeepCollectionEquality().hash(dodgeBoost));

  @JsonKey(ignore: true)
  @override
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
      required final String description,
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
  String get description;
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
