// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'character.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return _Character.fromJson(json);
}

/// @nodoc
mixin _$Character {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get profession => throw _privateConstructorUsedError;
  String? get religion => throw _privateConstructorUsedError;
  String? get relationship => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get inventory => throw _privateConstructorUsedError;
  String get raceId => throw _privateConstructorUsedError;
  Race get race => throw _privateConstructorUsedError;
  List<SkilltreeOverview> get skilltrees => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterCopyWith<Character> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterCopyWith<$Res> {
  factory $CharacterCopyWith(Character value, $Res Function(Character) then) = _$CharacterCopyWithImpl<$Res, Character>;
  @useResult
  $Res call(
      {String id,
      String name,
      int? age,
      String? iconUrl,
      String? description,
      String? profession,
      String? religion,
      String? relationship,
      String? notes,
      String? inventory,
      String raceId,
      Race race,
      List<SkilltreeOverview> skilltrees});

  $RaceCopyWith<$Res> get race;
}

/// @nodoc
class _$CharacterCopyWithImpl<$Res, $Val extends Character> implements $CharacterCopyWith<$Res> {
  _$CharacterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = freezed,
    Object? iconUrl = freezed,
    Object? description = freezed,
    Object? profession = freezed,
    Object? religion = freezed,
    Object? relationship = freezed,
    Object? notes = freezed,
    Object? inventory = freezed,
    Object? raceId = null,
    Object? race = null,
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
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      profession: freezed == profession
          ? _value.profession
          : profession // ignore: cast_nullable_to_non_nullable
              as String?,
      religion: freezed == religion
          ? _value.religion
          : religion // ignore: cast_nullable_to_non_nullable
              as String?,
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      inventory: freezed == inventory
          ? _value.inventory
          : inventory // ignore: cast_nullable_to_non_nullable
              as String?,
      raceId: null == raceId
          ? _value.raceId
          : raceId // ignore: cast_nullable_to_non_nullable
              as String,
      race: null == race
          ? _value.race
          : race // ignore: cast_nullable_to_non_nullable
              as Race,
      skilltrees: null == skilltrees
          ? _value.skilltrees
          : skilltrees // ignore: cast_nullable_to_non_nullable
              as List<SkilltreeOverview>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RaceCopyWith<$Res> get race {
    return $RaceCopyWith<$Res>(_value.race, (value) {
      return _then(_value.copyWith(race: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CharacterCopyWith<$Res> implements $CharacterCopyWith<$Res> {
  factory _$$_CharacterCopyWith(_$_Character value, $Res Function(_$_Character) then) = __$$_CharacterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int? age,
      String? iconUrl,
      String? description,
      String? profession,
      String? religion,
      String? relationship,
      String? notes,
      String? inventory,
      String raceId,
      Race race,
      List<SkilltreeOverview> skilltrees});

  @override
  $RaceCopyWith<$Res> get race;
}

/// @nodoc
class __$$_CharacterCopyWithImpl<$Res> extends _$CharacterCopyWithImpl<$Res, _$_Character> implements _$$_CharacterCopyWith<$Res> {
  __$$_CharacterCopyWithImpl(_$_Character _value, $Res Function(_$_Character) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = freezed,
    Object? iconUrl = freezed,
    Object? description = freezed,
    Object? profession = freezed,
    Object? religion = freezed,
    Object? relationship = freezed,
    Object? notes = freezed,
    Object? inventory = freezed,
    Object? raceId = null,
    Object? race = null,
    Object? skilltrees = null,
  }) {
    return _then(_$_Character(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      profession: freezed == profession
          ? _value.profession
          : profession // ignore: cast_nullable_to_non_nullable
              as String?,
      religion: freezed == religion
          ? _value.religion
          : religion // ignore: cast_nullable_to_non_nullable
              as String?,
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      inventory: freezed == inventory
          ? _value.inventory
          : inventory // ignore: cast_nullable_to_non_nullable
              as String?,
      raceId: null == raceId
          ? _value.raceId
          : raceId // ignore: cast_nullable_to_non_nullable
              as String,
      race: null == race
          ? _value.race
          : race // ignore: cast_nullable_to_non_nullable
              as Race,
      skilltrees: null == skilltrees
          ? _value._skilltrees
          : skilltrees // ignore: cast_nullable_to_non_nullable
              as List<SkilltreeOverview>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Character implements _Character {
  const _$_Character(
      {required this.id,
      required this.name,
      this.age,
      this.iconUrl,
      this.description,
      this.profession,
      this.religion,
      this.relationship,
      this.notes,
      this.inventory,
      required this.raceId,
      required this.race,
      final List<SkilltreeOverview> skilltrees = const []})
      : _skilltrees = skilltrees;

  factory _$_Character.fromJson(Map<String, dynamic> json) => _$$_CharacterFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int? age;
  @override
  final String? iconUrl;
  @override
  final String? description;
  @override
  final String? profession;
  @override
  final String? religion;
  @override
  final String? relationship;
  @override
  final String? notes;
  @override
  final String? inventory;
  @override
  final String raceId;
  @override
  final Race race;
  final List<SkilltreeOverview> _skilltrees;
  @override
  @JsonKey()
  List<SkilltreeOverview> get skilltrees {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skilltrees);
  }

  @override
  String toString() {
    return 'Character(id: $id, name: $name, age: $age, iconUrl: $iconUrl, description: $description, profession: $profession, religion: $religion, relationship: $relationship, notes: $notes, inventory: $inventory, raceId: $raceId, race: $race, skilltrees: $skilltrees)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Character &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.description, description) || other.description == description) &&
            (identical(other.profession, profession) || other.profession == profession) &&
            (identical(other.religion, religion) || other.religion == religion) &&
            (identical(other.relationship, relationship) || other.relationship == relationship) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.inventory, inventory) || other.inventory == inventory) &&
            (identical(other.raceId, raceId) || other.raceId == raceId) &&
            (identical(other.race, race) || other.race == race) &&
            const DeepCollectionEquality().equals(other._skilltrees, _skilltrees));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, age, iconUrl, description, profession, religion, relationship, notes, inventory, raceId,
      race, const DeepCollectionEquality().hash(_skilltrees));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CharacterCopyWith<_$_Character> get copyWith => __$$_CharacterCopyWithImpl<_$_Character>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharacterToJson(
      this,
    );
  }
}

abstract class _Character implements Character {
  const factory _Character(
      {required final String id,
      required final String name,
      final int? age,
      final String? iconUrl,
      final String? description,
      final String? profession,
      final String? religion,
      final String? relationship,
      final String? notes,
      final String? inventory,
      required final String raceId,
      required final Race race,
      final List<SkilltreeOverview> skilltrees}) = _$_Character;

  factory _Character.fromJson(Map<String, dynamic> json) = _$_Character.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int? get age;
  @override
  String? get iconUrl;
  @override
  String? get description;
  @override
  String? get profession;
  @override
  String? get religion;
  @override
  String? get relationship;
  @override
  String? get notes;
  @override
  String? get inventory;
  @override
  String get raceId;
  @override
  Race get race;
  @override
  List<SkilltreeOverview> get skilltrees;
  @override
  @JsonKey(ignore: true)
  _$$_CharacterCopyWith<_$_Character> get copyWith => throw _privateConstructorUsedError;
}
