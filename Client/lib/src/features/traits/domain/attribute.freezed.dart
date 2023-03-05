// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attribute.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Attribute _$AttributeFromJson(Map<String, dynamic> json) {
  return _Attribute.fromJson(json);
}

/// @nodoc
mixin _$Attribute {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get iconData => throw _privateConstructorUsedError;
  double get stepSize => throw _privateConstructorUsedError;
  double get minValue => throw _privateConstructorUsedError;
  double get maxValue => throw _privateConstructorUsedError;
  bool get isGlobal => throw _privateConstructorUsedError;
  User get creator => throw _privateConstructorUsedError;
  SuggestionState get state => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastUpdatedAt => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  DateTime? get rejectedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttributeCopyWith<Attribute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttributeCopyWith<$Res> {
  factory $AttributeCopyWith(Attribute value, $Res Function(Attribute) then) =
      _$AttributeCopyWithImpl<$Res, Attribute>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? category,
      String? iconData,
      double stepSize,
      double minValue,
      double maxValue,
      bool isGlobal,
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
class _$AttributeCopyWithImpl<$Res, $Val extends Attribute>
    implements $AttributeCopyWith<$Res> {
  _$AttributeCopyWithImpl(this._value, this._then);

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
    Object? category = freezed,
    Object? iconData = freezed,
    Object? stepSize = null,
    Object? minValue = null,
    Object? maxValue = null,
    Object? isGlobal = null,
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      iconData: freezed == iconData
          ? _value.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as String?,
      stepSize: null == stepSize
          ? _value.stepSize
          : stepSize // ignore: cast_nullable_to_non_nullable
              as double,
      minValue: null == minValue
          ? _value.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxValue: null == maxValue
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double,
      isGlobal: null == isGlobal
          ? _value.isGlobal
          : isGlobal // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_AttributeCopyWith<$Res> implements $AttributeCopyWith<$Res> {
  factory _$$_AttributeCopyWith(
          _$_Attribute value, $Res Function(_$_Attribute) then) =
      __$$_AttributeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? category,
      String? iconData,
      double stepSize,
      double minValue,
      double maxValue,
      bool isGlobal,
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
class __$$_AttributeCopyWithImpl<$Res>
    extends _$AttributeCopyWithImpl<$Res, _$_Attribute>
    implements _$$_AttributeCopyWith<$Res> {
  __$$_AttributeCopyWithImpl(
      _$_Attribute _value, $Res Function(_$_Attribute) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = freezed,
    Object? iconData = freezed,
    Object? stepSize = null,
    Object? minValue = null,
    Object? maxValue = null,
    Object? isGlobal = null,
    Object? creator = null,
    Object? state = null,
    Object? rejectionReason = freezed,
    Object? createdAt = null,
    Object? lastUpdatedAt = freezed,
    Object? approvedAt = freezed,
    Object? rejectedAt = freezed,
  }) {
    return _then(_$_Attribute(
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      iconData: freezed == iconData
          ? _value.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as String?,
      stepSize: null == stepSize
          ? _value.stepSize
          : stepSize // ignore: cast_nullable_to_non_nullable
              as double,
      minValue: null == minValue
          ? _value.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxValue: null == maxValue
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double,
      isGlobal: null == isGlobal
          ? _value.isGlobal
          : isGlobal // ignore: cast_nullable_to_non_nullable
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
class _$_Attribute implements _Attribute {
  const _$_Attribute(
      {required this.id,
      required this.name,
      this.description,
      this.category,
      this.iconData,
      this.stepSize = 1,
      this.minValue = 0,
      this.maxValue = 10,
      this.isGlobal = false,
      required this.creator,
      required this.state,
      this.rejectionReason,
      required this.createdAt,
      this.lastUpdatedAt,
      this.approvedAt,
      this.rejectedAt});

  factory _$_Attribute.fromJson(Map<String, dynamic> json) =>
      _$$_AttributeFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? category;
  @override
  final String? iconData;
  @override
  @JsonKey()
  final double stepSize;
  @override
  @JsonKey()
  final double minValue;
  @override
  @JsonKey()
  final double maxValue;
  @override
  @JsonKey()
  final bool isGlobal;
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
    return 'Attribute(id: $id, name: $name, description: $description, category: $category, iconData: $iconData, stepSize: $stepSize, minValue: $minValue, maxValue: $maxValue, isGlobal: $isGlobal, creator: $creator, state: $state, rejectionReason: $rejectionReason, createdAt: $createdAt, lastUpdatedAt: $lastUpdatedAt, approvedAt: $approvedAt, rejectedAt: $rejectedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Attribute &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.iconData, iconData) ||
                other.iconData == iconData) &&
            (identical(other.stepSize, stepSize) ||
                other.stepSize == stepSize) &&
            (identical(other.minValue, minValue) ||
                other.minValue == minValue) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue) &&
            (identical(other.isGlobal, isGlobal) ||
                other.isGlobal == isGlobal) &&
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
      category,
      iconData,
      stepSize,
      minValue,
      maxValue,
      isGlobal,
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
  _$$_AttributeCopyWith<_$_Attribute> get copyWith =>
      __$$_AttributeCopyWithImpl<_$_Attribute>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttributeToJson(
      this,
    );
  }
}

abstract class _Attribute implements Attribute {
  const factory _Attribute(
      {required final String id,
      required final String name,
      final String? description,
      final String? category,
      final String? iconData,
      final double stepSize,
      final double minValue,
      final double maxValue,
      final bool isGlobal,
      required final User creator,
      required final SuggestionState state,
      final String? rejectionReason,
      required final DateTime createdAt,
      final DateTime? lastUpdatedAt,
      final DateTime? approvedAt,
      final DateTime? rejectedAt}) = _$_Attribute;

  factory _Attribute.fromJson(Map<String, dynamic> json) =
      _$_Attribute.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get category;
  @override
  String? get iconData;
  @override
  double get stepSize;
  @override
  double get minValue;
  @override
  double get maxValue;
  @override
  bool get isGlobal;
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
  _$$_AttributeCopyWith<_$_Attribute> get copyWith =>
      throw _privateConstructorUsedError;
}
