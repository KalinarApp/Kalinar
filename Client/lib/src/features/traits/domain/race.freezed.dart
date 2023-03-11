// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'race.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Race _$RaceFromJson(Map<String, dynamic> json) {
  return _Race.fromJson(json);
}

/// @nodoc
mixin _$Race {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<AttributeValue> get attributes => throw _privateConstructorUsedError;
  User? get creator => throw _privateConstructorUsedError;
  SuggestionState get state => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastUpdatedAt => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  DateTime? get rejectedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RaceCopyWith<Race> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RaceCopyWith<$Res> {
  factory $RaceCopyWith(Race value, $Res Function(Race) then) =
      _$RaceCopyWithImpl<$Res, Race>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      List<AttributeValue> attributes,
      User? creator,
      SuggestionState state,
      String? rejectionReason,
      DateTime createdAt,
      DateTime? lastUpdatedAt,
      DateTime? approvedAt,
      DateTime? rejectedAt});

  $UserCopyWith<$Res>? get creator;
}

/// @nodoc
class _$RaceCopyWithImpl<$Res, $Val extends Race>
    implements $RaceCopyWith<$Res> {
  _$RaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? attributes = null,
    Object? creator = freezed,
    Object? state = null,
    Object? rejectionReason = freezed,
    Object? createdAt = null,
    Object? lastUpdatedAt = freezed,
    Object? approvedAt = freezed,
    Object? rejectedAt = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<AttributeValue>,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User?,
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
      lastUpdatedAt: freezed == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
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
  $UserCopyWith<$Res>? get creator {
    if (_value.creator == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.creator!, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RaceCopyWith<$Res> implements $RaceCopyWith<$Res> {
  factory _$$_RaceCopyWith(_$_Race value, $Res Function(_$_Race) then) =
      __$$_RaceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      List<AttributeValue> attributes,
      User? creator,
      SuggestionState state,
      String? rejectionReason,
      DateTime createdAt,
      DateTime? lastUpdatedAt,
      DateTime? approvedAt,
      DateTime? rejectedAt});

  @override
  $UserCopyWith<$Res>? get creator;
}

/// @nodoc
class __$$_RaceCopyWithImpl<$Res> extends _$RaceCopyWithImpl<$Res, _$_Race>
    implements _$$_RaceCopyWith<$Res> {
  __$$_RaceCopyWithImpl(_$_Race _value, $Res Function(_$_Race) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? attributes = null,
    Object? creator = freezed,
    Object? state = null,
    Object? rejectionReason = freezed,
    Object? createdAt = null,
    Object? lastUpdatedAt = freezed,
    Object? approvedAt = freezed,
    Object? rejectedAt = freezed,
  }) {
    return _then(_$_Race(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<AttributeValue>,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User?,
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
      lastUpdatedAt: freezed == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedAt: freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Race implements _Race {
  const _$_Race(
      {required this.id,
      required this.name,
      this.description,
      final List<AttributeValue> attributes = const [],
      required this.creator,
      required this.state,
      this.rejectionReason,
      required this.createdAt,
      this.lastUpdatedAt,
      this.approvedAt,
      this.rejectedAt})
      : _attributes = attributes;

  factory _$_Race.fromJson(Map<String, dynamic> json) => _$$_RaceFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  final List<AttributeValue> _attributes;
  @override
  @JsonKey()
  List<AttributeValue> get attributes {
    if (_attributes is EqualUnmodifiableListView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attributes);
  }

  @override
  final User? creator;
  @override
  final SuggestionState state;
  @override
  final String? rejectionReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastUpdatedAt;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? rejectedAt;

  @override
  String toString() {
    return 'Race(id: $id, name: $name, description: $description, attributes: $attributes, creator: $creator, state: $state, rejectionReason: $rejectionReason, createdAt: $createdAt, lastUpdatedAt: $lastUpdatedAt, approvedAt: $approvedAt, rejectedAt: $rejectedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Race &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
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
      name,
      description,
      const DeepCollectionEquality().hash(_attributes),
      creator,
      state,
      rejectionReason,
      createdAt,
      lastUpdatedAt,
      approvedAt,
      rejectedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RaceCopyWith<_$_Race> get copyWith =>
      __$$_RaceCopyWithImpl<_$_Race>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RaceToJson(
      this,
    );
  }
}

abstract class _Race implements Race {
  const factory _Race(
      {required final String id,
      required final String name,
      final String? description,
      final List<AttributeValue> attributes,
      required final User? creator,
      required final SuggestionState state,
      final String? rejectionReason,
      required final DateTime createdAt,
      final DateTime? lastUpdatedAt,
      final DateTime? approvedAt,
      final DateTime? rejectedAt}) = _$_Race;

  factory _Race.fromJson(Map<String, dynamic> json) = _$_Race.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  List<AttributeValue> get attributes;
  @override
  User? get creator;
  @override
  SuggestionState get state;
  @override
  String? get rejectionReason;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastUpdatedAt;
  @override
  DateTime? get approvedAt;
  @override
  DateTime? get rejectedAt;
  @override
  @JsonKey(ignore: true)
  _$$_RaceCopyWith<_$_Race> get copyWith => throw _privateConstructorUsedError;
}
