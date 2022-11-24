// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Node _$NodeFromJson(Map<String, dynamic> json) {
  return _Node.fromJson(json);
}

/// @nodoc
mixin _$Node {
  String get id => throw _privateConstructorUsedError;
  int get importance => throw _privateConstructorUsedError;
  Skill get skill => throw _privateConstructorUsedError;
  String get skillId => throw _privateConstructorUsedError;
  int get cost => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  bool get isEasyReachable => throw _privateConstructorUsedError;
  dynamic get isUnlocked => throw _privateConstructorUsedError;
  double get xPos => throw _privateConstructorUsedError;
  double get yPos => throw _privateConstructorUsedError;
  List<String> get precessors => throw _privateConstructorUsedError;
  List<String> get successors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodeCopyWith<Node> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeCopyWith<$Res> {
  factory $NodeCopyWith(Node value, $Res Function(Node) then) =
      _$NodeCopyWithImpl<$Res, Node>;
  @useResult
  $Res call(
      {String id,
      int importance,
      Skill skill,
      String skillId,
      int cost,
      String color,
      bool isEasyReachable,
      dynamic isUnlocked,
      double xPos,
      double yPos,
      List<String> precessors,
      List<String> successors});

  $SkillCopyWith<$Res> get skill;
}

/// @nodoc
class _$NodeCopyWithImpl<$Res, $Val extends Node>
    implements $NodeCopyWith<$Res> {
  _$NodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? importance = null,
    Object? skill = null,
    Object? skillId = null,
    Object? cost = null,
    Object? color = null,
    Object? isEasyReachable = null,
    Object? isUnlocked = null,
    Object? xPos = null,
    Object? yPos = null,
    Object? precessors = null,
    Object? successors = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as int,
      skill: null == skill
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as Skill,
      skillId: null == skillId
          ? _value.skillId
          : skillId // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      isEasyReachable: null == isEasyReachable
          ? _value.isEasyReachable
          : isEasyReachable // ignore: cast_nullable_to_non_nullable
              as bool,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as dynamic,
      xPos: null == xPos
          ? _value.xPos
          : xPos // ignore: cast_nullable_to_non_nullable
              as double,
      yPos: null == yPos
          ? _value.yPos
          : yPos // ignore: cast_nullable_to_non_nullable
              as double,
      precessors: null == precessors
          ? _value.precessors
          : precessors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      successors: null == successors
          ? _value.successors
          : successors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get skill {
    return $SkillCopyWith<$Res>(_value.skill, (value) {
      return _then(_value.copyWith(skill: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_NodeCopyWith<$Res> implements $NodeCopyWith<$Res> {
  factory _$$_NodeCopyWith(_$_Node value, $Res Function(_$_Node) then) =
      __$$_NodeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int importance,
      Skill skill,
      String skillId,
      int cost,
      String color,
      bool isEasyReachable,
      dynamic isUnlocked,
      double xPos,
      double yPos,
      List<String> precessors,
      List<String> successors});

  @override
  $SkillCopyWith<$Res> get skill;
}

/// @nodoc
class __$$_NodeCopyWithImpl<$Res> extends _$NodeCopyWithImpl<$Res, _$_Node>
    implements _$$_NodeCopyWith<$Res> {
  __$$_NodeCopyWithImpl(_$_Node _value, $Res Function(_$_Node) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? importance = null,
    Object? skill = null,
    Object? skillId = null,
    Object? cost = null,
    Object? color = null,
    Object? isEasyReachable = null,
    Object? isUnlocked = null,
    Object? xPos = null,
    Object? yPos = null,
    Object? precessors = null,
    Object? successors = null,
  }) {
    return _then(_$_Node(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as int,
      skill: null == skill
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as Skill,
      skillId: null == skillId
          ? _value.skillId
          : skillId // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      isEasyReachable: null == isEasyReachable
          ? _value.isEasyReachable
          : isEasyReachable // ignore: cast_nullable_to_non_nullable
              as bool,
      isUnlocked: null == isUnlocked ? _value.isUnlocked : isUnlocked,
      xPos: null == xPos
          ? _value.xPos
          : xPos // ignore: cast_nullable_to_non_nullable
              as double,
      yPos: null == yPos
          ? _value.yPos
          : yPos // ignore: cast_nullable_to_non_nullable
              as double,
      precessors: null == precessors
          ? _value._precessors
          : precessors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      successors: null == successors
          ? _value._successors
          : successors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Node implements _Node {
  const _$_Node(
      {required this.id,
      required this.importance,
      required this.skill,
      required this.skillId,
      required this.cost,
      required this.color,
      required this.isEasyReachable,
      this.isUnlocked = false,
      this.xPos = 0,
      this.yPos = 0,
      final List<String> precessors = const [],
      final List<String> successors = const []})
      : _precessors = precessors,
        _successors = successors;

  factory _$_Node.fromJson(Map<String, dynamic> json) => _$$_NodeFromJson(json);

  @override
  final String id;
  @override
  final int importance;
  @override
  final Skill skill;
  @override
  final String skillId;
  @override
  final int cost;
  @override
  final String color;
  @override
  final bool isEasyReachable;
  @override
  @JsonKey()
  final dynamic isUnlocked;
  @override
  @JsonKey()
  final double xPos;
  @override
  @JsonKey()
  final double yPos;
  final List<String> _precessors;
  @override
  @JsonKey()
  List<String> get precessors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_precessors);
  }

  final List<String> _successors;
  @override
  @JsonKey()
  List<String> get successors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_successors);
  }

  @override
  String toString() {
    return 'Node(id: $id, importance: $importance, skill: $skill, skillId: $skillId, cost: $cost, color: $color, isEasyReachable: $isEasyReachable, isUnlocked: $isUnlocked, xPos: $xPos, yPos: $yPos, precessors: $precessors, successors: $successors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Node &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.skill, skill) || other.skill == skill) &&
            (identical(other.skillId, skillId) || other.skillId == skillId) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isEasyReachable, isEasyReachable) ||
                other.isEasyReachable == isEasyReachable) &&
            const DeepCollectionEquality()
                .equals(other.isUnlocked, isUnlocked) &&
            (identical(other.xPos, xPos) || other.xPos == xPos) &&
            (identical(other.yPos, yPos) || other.yPos == yPos) &&
            const DeepCollectionEquality()
                .equals(other._precessors, _precessors) &&
            const DeepCollectionEquality()
                .equals(other._successors, _successors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      importance,
      skill,
      skillId,
      cost,
      color,
      isEasyReachable,
      const DeepCollectionEquality().hash(isUnlocked),
      xPos,
      yPos,
      const DeepCollectionEquality().hash(_precessors),
      const DeepCollectionEquality().hash(_successors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NodeCopyWith<_$_Node> get copyWith =>
      __$$_NodeCopyWithImpl<_$_Node>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NodeToJson(
      this,
    );
  }
}

abstract class _Node implements Node {
  const factory _Node(
      {required final String id,
      required final int importance,
      required final Skill skill,
      required final String skillId,
      required final int cost,
      required final String color,
      required final bool isEasyReachable,
      final dynamic isUnlocked,
      final double xPos,
      final double yPos,
      final List<String> precessors,
      final List<String> successors}) = _$_Node;

  factory _Node.fromJson(Map<String, dynamic> json) = _$_Node.fromJson;

  @override
  String get id;
  @override
  int get importance;
  @override
  Skill get skill;
  @override
  String get skillId;
  @override
  int get cost;
  @override
  String get color;
  @override
  bool get isEasyReachable;
  @override
  dynamic get isUnlocked;
  @override
  double get xPos;
  @override
  double get yPos;
  @override
  List<String> get precessors;
  @override
  List<String> get successors;
  @override
  @JsonKey(ignore: true)
  _$$_NodeCopyWith<_$_Node> get copyWith => throw _privateConstructorUsedError;
}
