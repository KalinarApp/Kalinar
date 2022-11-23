// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'blueprint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Blueprint _$BlueprintFromJson(Map<String, dynamic> json) {
  return _Blueprint.fromJson(json);
}

/// @nodoc
mixin _$Blueprint {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  CharacterOverview? get character => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  bool get isActiveTree => throw _privateConstructorUsedError;
  List<Node> get nodes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlueprintCopyWith<Blueprint> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlueprintCopyWith<$Res> {
  factory $BlueprintCopyWith(Blueprint value, $Res Function(Blueprint) then) = _$BlueprintCopyWithImpl<$Res, Blueprint>;
  @useResult
  $Res call({String id, String name, CharacterOverview? character, int points, bool isActiveTree, List<Node> nodes});

  $CharacterOverviewCopyWith<$Res>? get character;
}

/// @nodoc
class _$BlueprintCopyWithImpl<$Res, $Val extends Blueprint> implements $BlueprintCopyWith<$Res> {
  _$BlueprintCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? character = freezed,
    Object? points = null,
    Object? isActiveTree = null,
    Object? nodes = null,
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
      character: freezed == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as CharacterOverview?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      isActiveTree: null == isActiveTree
          ? _value.isActiveTree
          : isActiveTree // ignore: cast_nullable_to_non_nullable
              as bool,
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<Node>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CharacterOverviewCopyWith<$Res>? get character {
    if (_value.character == null) {
      return null;
    }

    return $CharacterOverviewCopyWith<$Res>(_value.character!, (value) {
      return _then(_value.copyWith(character: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BlueprintCopyWith<$Res> implements $BlueprintCopyWith<$Res> {
  factory _$$_BlueprintCopyWith(_$_Blueprint value, $Res Function(_$_Blueprint) then) = __$$_BlueprintCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, CharacterOverview? character, int points, bool isActiveTree, List<Node> nodes});

  @override
  $CharacterOverviewCopyWith<$Res>? get character;
}

/// @nodoc
class __$$_BlueprintCopyWithImpl<$Res> extends _$BlueprintCopyWithImpl<$Res, _$_Blueprint> implements _$$_BlueprintCopyWith<$Res> {
  __$$_BlueprintCopyWithImpl(_$_Blueprint _value, $Res Function(_$_Blueprint) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? character = freezed,
    Object? points = null,
    Object? isActiveTree = null,
    Object? nodes = null,
  }) {
    return _then(_$_Blueprint(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      character: freezed == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as CharacterOverview?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      isActiveTree: null == isActiveTree
          ? _value.isActiveTree
          : isActiveTree // ignore: cast_nullable_to_non_nullable
              as bool,
      nodes: null == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<Node>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Blueprint implements _Blueprint {
  const _$_Blueprint({this.id = "", this.name = "", this.character, this.points = 0, this.isActiveTree = true, final List<Node> nodes = const []})
      : _nodes = nodes;

  factory _$_Blueprint.fromJson(Map<String, dynamic> json) => _$$_BlueprintFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final CharacterOverview? character;
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey()
  final bool isActiveTree;
  final List<Node> _nodes;
  @override
  @JsonKey()
  List<Node> get nodes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  @override
  String toString() {
    return 'Blueprint(id: $id, name: $name, character: $character, points: $points, isActiveTree: $isActiveTree, nodes: $nodes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Blueprint &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.character, character) || other.character == character) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.isActiveTree, isActiveTree) || other.isActiveTree == isActiveTree) &&
            const DeepCollectionEquality().equals(other._nodes, _nodes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, character, points, isActiveTree, const DeepCollectionEquality().hash(_nodes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BlueprintCopyWith<_$_Blueprint> get copyWith => __$$_BlueprintCopyWithImpl<_$_Blueprint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BlueprintToJson(
      this,
    );
  }
}

abstract class _Blueprint implements Blueprint {
  const factory _Blueprint(
      {final String id,
      final String name,
      final CharacterOverview? character,
      final int points,
      final bool isActiveTree,
      final List<Node> nodes}) = _$_Blueprint;

  factory _Blueprint.fromJson(Map<String, dynamic> json) = _$_Blueprint.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  CharacterOverview? get character;
  @override
  int get points;
  @override
  bool get isActiveTree;
  @override
  List<Node> get nodes;
  @override
  @JsonKey(ignore: true)
  _$$_BlueprintCopyWith<_$_Blueprint> get copyWith => throw _privateConstructorUsedError;
}
