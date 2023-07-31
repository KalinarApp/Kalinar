// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_skill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CharacterSkill _$CharacterSkillFromJson(Map<String, dynamic> json) {
  return _CharacterSkill.fromJson(json);
}

/// @nodoc
mixin _$CharacterSkill {
  String get id => throw _privateConstructorUsedError;
  Ability? get ability => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  List<AttributeValue> get attributes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterSkillCopyWith<CharacterSkill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterSkillCopyWith<$Res> {
  factory $CharacterSkillCopyWith(
          CharacterSkill value, $Res Function(CharacterSkill) then) =
      _$CharacterSkillCopyWithImpl<$Res, CharacterSkill>;
  @useResult
  $Res call(
      {String id,
      Ability? ability,
      String? iconUrl,
      String name,
      String? description,
      bool isFavorite,
      List<AttributeValue> attributes});

  $AbilityCopyWith<$Res>? get ability;
}

/// @nodoc
class _$CharacterSkillCopyWithImpl<$Res, $Val extends CharacterSkill>
    implements $CharacterSkillCopyWith<$Res> {
  _$CharacterSkillCopyWithImpl(this._value, this._then);

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
    Object? isFavorite = null,
    Object? attributes = null,
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
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<AttributeValue>,
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
abstract class _$$_CharacterSkillCopyWith<$Res>
    implements $CharacterSkillCopyWith<$Res> {
  factory _$$_CharacterSkillCopyWith(
          _$_CharacterSkill value, $Res Function(_$_CharacterSkill) then) =
      __$$_CharacterSkillCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Ability? ability,
      String? iconUrl,
      String name,
      String? description,
      bool isFavorite,
      List<AttributeValue> attributes});

  @override
  $AbilityCopyWith<$Res>? get ability;
}

/// @nodoc
class __$$_CharacterSkillCopyWithImpl<$Res>
    extends _$CharacterSkillCopyWithImpl<$Res, _$_CharacterSkill>
    implements _$$_CharacterSkillCopyWith<$Res> {
  __$$_CharacterSkillCopyWithImpl(
      _$_CharacterSkill _value, $Res Function(_$_CharacterSkill) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ability = freezed,
    Object? iconUrl = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? isFavorite = null,
    Object? attributes = null,
  }) {
    return _then(_$_CharacterSkill(
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
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<AttributeValue>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CharacterSkill implements _CharacterSkill {
  const _$_CharacterSkill(this.id,
      {this.ability,
      this.iconUrl,
      required this.name,
      this.description,
      this.isFavorite = false,
      final List<AttributeValue> attributes = const []})
      : _attributes = attributes;

  factory _$_CharacterSkill.fromJson(Map<String, dynamic> json) =>
      _$$_CharacterSkillFromJson(json);

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
  final bool isFavorite;
  final List<AttributeValue> _attributes;
  @override
  @JsonKey()
  List<AttributeValue> get attributes {
    if (_attributes is EqualUnmodifiableListView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attributes);
  }

  @override
  String toString() {
    return 'CharacterSkill(id: $id, ability: $ability, iconUrl: $iconUrl, name: $name, description: $description, isFavorite: $isFavorite, attributes: $attributes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CharacterSkill &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ability, ability) || other.ability == ability) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes));
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
      isFavorite,
      const DeepCollectionEquality().hash(_attributes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CharacterSkillCopyWith<_$_CharacterSkill> get copyWith =>
      __$$_CharacterSkillCopyWithImpl<_$_CharacterSkill>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharacterSkillToJson(
      this,
    );
  }
}

abstract class _CharacterSkill implements CharacterSkill {
  const factory _CharacterSkill(final String id,
      {final Ability? ability,
      final String? iconUrl,
      required final String name,
      final String? description,
      final bool isFavorite,
      final List<AttributeValue> attributes}) = _$_CharacterSkill;

  factory _CharacterSkill.fromJson(Map<String, dynamic> json) =
      _$_CharacterSkill.fromJson;

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
  bool get isFavorite;
  @override
  List<AttributeValue> get attributes;
  @override
  @JsonKey(ignore: true)
  _$$_CharacterSkillCopyWith<_$_CharacterSkill> get copyWith =>
      throw _privateConstructorUsedError;
}
