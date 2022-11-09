// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'blueprint_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BlueprintOverview _$BlueprintOverviewFromJson(Map<String, dynamic> json) {
  return _BlueprintOverview.fromJson(json);
}

/// @nodoc
mixin _$BlueprintOverview {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get nodeCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlueprintOverviewCopyWith<BlueprintOverview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlueprintOverviewCopyWith<$Res> {
  factory $BlueprintOverviewCopyWith(
          BlueprintOverview value, $Res Function(BlueprintOverview) then) =
      _$BlueprintOverviewCopyWithImpl<$Res, BlueprintOverview>;
  @useResult
  $Res call({String id, String name, int nodeCount});
}

/// @nodoc
class _$BlueprintOverviewCopyWithImpl<$Res, $Val extends BlueprintOverview>
    implements $BlueprintOverviewCopyWith<$Res> {
  _$BlueprintOverviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nodeCount = null,
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
      nodeCount: null == nodeCount
          ? _value.nodeCount
          : nodeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BlueprintOverviewCopyWith<$Res>
    implements $BlueprintOverviewCopyWith<$Res> {
  factory _$$_BlueprintOverviewCopyWith(_$_BlueprintOverview value,
          $Res Function(_$_BlueprintOverview) then) =
      __$$_BlueprintOverviewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int nodeCount});
}

/// @nodoc
class __$$_BlueprintOverviewCopyWithImpl<$Res>
    extends _$BlueprintOverviewCopyWithImpl<$Res, _$_BlueprintOverview>
    implements _$$_BlueprintOverviewCopyWith<$Res> {
  __$$_BlueprintOverviewCopyWithImpl(
      _$_BlueprintOverview _value, $Res Function(_$_BlueprintOverview) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nodeCount = null,
  }) {
    return _then(_$_BlueprintOverview(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nodeCount: null == nodeCount
          ? _value.nodeCount
          : nodeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BlueprintOverview implements _BlueprintOverview {
  const _$_BlueprintOverview(
      {required this.id, required this.name, required this.nodeCount});

  factory _$_BlueprintOverview.fromJson(Map<String, dynamic> json) =>
      _$$_BlueprintOverviewFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int nodeCount;

  @override
  String toString() {
    return 'BlueprintOverview(id: $id, name: $name, nodeCount: $nodeCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BlueprintOverview &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nodeCount, nodeCount) ||
                other.nodeCount == nodeCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nodeCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BlueprintOverviewCopyWith<_$_BlueprintOverview> get copyWith =>
      __$$_BlueprintOverviewCopyWithImpl<_$_BlueprintOverview>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BlueprintOverviewToJson(
      this,
    );
  }
}

abstract class _BlueprintOverview implements BlueprintOverview {
  const factory _BlueprintOverview(
      {required final String id,
      required final String name,
      required final int nodeCount}) = _$_BlueprintOverview;

  factory _BlueprintOverview.fromJson(Map<String, dynamic> json) =
      _$_BlueprintOverview.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get nodeCount;
  @override
  @JsonKey(ignore: true)
  _$$_BlueprintOverviewCopyWith<_$_BlueprintOverview> get copyWith =>
      throw _privateConstructorUsedError;
}
