// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ability.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ability _$AbilityFromJson(Map<String, dynamic> json) {
  return _Ability.fromJson(json);
}

/// @nodoc
mixin _$Ability {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isPassive => throw _privateConstructorUsedError;
  User get creator => throw _privateConstructorUsedError;
  SuggestionState get state => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastUpdatedAt => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  DateTime? get rejectedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AbilityCopyWith<Ability> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AbilityCopyWith<$Res> {
  factory $AbilityCopyWith(Ability value, $Res Function(Ability) then) =
      _$AbilityCopyWithImpl<$Res, Ability>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      bool isPassive,
      User creator,
      SuggestionState state,
      String? rejectionReason,
      DateTime createdAt,
      DateTime? lastUpdatedAt,
      DateTime? approvedAt,
      DateTime? rejectedAt});

  $UserCopyWith<$Res> get creator;
}

/// @nodoc
class _$AbilityCopyWithImpl<$Res, $Val extends Ability>
    implements $AbilityCopyWith<$Res> {
  _$AbilityCopyWithImpl(this._value, this._then);

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
    Object? isPassive = null,
    Object? creator = null,
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
      isPassive: null == isPassive
          ? _value.isPassive
          : isPassive // ignore: cast_nullable_to_non_nullable
              as bool,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User,
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
  $UserCopyWith<$Res> get creator {
    return $UserCopyWith<$Res>(_value.creator, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AbilityCopyWith<$Res> implements $AbilityCopyWith<$Res> {
  factory _$$_AbilityCopyWith(
          _$_Ability value, $Res Function(_$_Ability) then) =
      __$$_AbilityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      bool isPassive,
      User creator,
      SuggestionState state,
      String? rejectionReason,
      DateTime createdAt,
      DateTime? lastUpdatedAt,
      DateTime? approvedAt,
      DateTime? rejectedAt});

  @override
  $UserCopyWith<$Res> get creator;
}

/// @nodoc
class __$$_AbilityCopyWithImpl<$Res>
    extends _$AbilityCopyWithImpl<$Res, _$_Ability>
    implements _$$_AbilityCopyWith<$Res> {
  __$$_AbilityCopyWithImpl(_$_Ability _value, $Res Function(_$_Ability) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? isPassive = null,
    Object? creator = null,
    Object? state = null,
    Object? rejectionReason = freezed,
    Object? createdAt = null,
    Object? lastUpdatedAt = freezed,
    Object? approvedAt = freezed,
    Object? rejectedAt = freezed,
  }) {
    return _then(_$_Ability(
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
      isPassive: null == isPassive
          ? _value.isPassive
          : isPassive // ignore: cast_nullable_to_non_nullable
              as bool,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User,
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
class _$_Ability implements _Ability {
  const _$_Ability(
      {required this.id,
      required this.name,
      this.description,
      required this.isPassive,
      required this.creator,
      required this.state,
      this.rejectionReason,
      required this.createdAt,
      this.lastUpdatedAt,
      this.approvedAt,
      this.rejectedAt});

  factory _$_Ability.fromJson(Map<String, dynamic> json) =>
      _$$_AbilityFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final bool isPassive;
  @override
  final User creator;
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
    return 'Ability(id: $id, name: $name, description: $description, isPassive: $isPassive, creator: $creator, state: $state, rejectionReason: $rejectionReason, createdAt: $createdAt, lastUpdatedAt: $lastUpdatedAt, approvedAt: $approvedAt, rejectedAt: $rejectedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ability &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isPassive, isPassive) ||
                other.isPassive == isPassive) &&
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
      isPassive,
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
  _$$_AbilityCopyWith<_$_Ability> get copyWith =>
      __$$_AbilityCopyWithImpl<_$_Ability>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AbilityToJson(
      this,
    );
  }
}

abstract class _Ability implements Ability {
  const factory _Ability(
      {required final String id,
      required final String name,
      final String? description,
      required final bool isPassive,
      required final User creator,
      required final SuggestionState state,
      final String? rejectionReason,
      required final DateTime createdAt,
      final DateTime? lastUpdatedAt,
      final DateTime? approvedAt,
      final DateTime? rejectedAt}) = _$_Ability;

  factory _Ability.fromJson(Map<String, dynamic> json) = _$_Ability.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  bool get isPassive;
  @override
  User get creator;
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
  _$$_AbilityCopyWith<_$_Ability> get copyWith =>
      throw _privateConstructorUsedError;
}
