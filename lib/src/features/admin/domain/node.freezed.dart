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
  int get importance => throw _privateConstructorUsedError;
  Skill get skill => throw _privateConstructorUsedError;
  int get cost => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  bool get isEasyReachable => throw _privateConstructorUsedError;
  double get xpos => throw _privateConstructorUsedError;
  double get ypos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodeCopyWith<Node> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeCopyWith<$Res> {
  factory $NodeCopyWith(Node value, $Res Function(Node) then) =
      _$NodeCopyWithImpl<$Res>;
  $Res call(
      {int importance,
      Skill skill,
      int cost,
      String color,
      bool isEasyReachable,
      double xpos,
      double ypos});

  $SkillCopyWith<$Res> get skill;
}

/// @nodoc
class _$NodeCopyWithImpl<$Res> implements $NodeCopyWith<$Res> {
  _$NodeCopyWithImpl(this._value, this._then);

  final Node _value;
  // ignore: unused_field
  final $Res Function(Node) _then;

  @override
  $Res call({
    Object? importance = freezed,
    Object? skill = freezed,
    Object? cost = freezed,
    Object? color = freezed,
    Object? isEasyReachable = freezed,
    Object? xpos = freezed,
    Object? ypos = freezed,
  }) {
    return _then(_value.copyWith(
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as int,
      skill: skill == freezed
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as Skill,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      isEasyReachable: isEasyReachable == freezed
          ? _value.isEasyReachable
          : isEasyReachable // ignore: cast_nullable_to_non_nullable
              as bool,
      xpos: xpos == freezed
          ? _value.xpos
          : xpos // ignore: cast_nullable_to_non_nullable
              as double,
      ypos: ypos == freezed
          ? _value.ypos
          : ypos // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  @override
  $SkillCopyWith<$Res> get skill {
    return $SkillCopyWith<$Res>(_value.skill, (value) {
      return _then(_value.copyWith(skill: value));
    });
  }
}

/// @nodoc
abstract class _$$_NodeCopyWith<$Res> implements $NodeCopyWith<$Res> {
  factory _$$_NodeCopyWith(_$_Node value, $Res Function(_$_Node) then) =
      __$$_NodeCopyWithImpl<$Res>;
  @override
  $Res call(
      {int importance,
      Skill skill,
      int cost,
      String color,
      bool isEasyReachable,
      double xpos,
      double ypos});

  @override
  $SkillCopyWith<$Res> get skill;
}

/// @nodoc
class __$$_NodeCopyWithImpl<$Res> extends _$NodeCopyWithImpl<$Res>
    implements _$$_NodeCopyWith<$Res> {
  __$$_NodeCopyWithImpl(_$_Node _value, $Res Function(_$_Node) _then)
      : super(_value, (v) => _then(v as _$_Node));

  @override
  _$_Node get _value => super._value as _$_Node;

  @override
  $Res call({
    Object? importance = freezed,
    Object? skill = freezed,
    Object? cost = freezed,
    Object? color = freezed,
    Object? isEasyReachable = freezed,
    Object? xpos = freezed,
    Object? ypos = freezed,
  }) {
    return _then(_$_Node(
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as int,
      skill: skill == freezed
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as Skill,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      isEasyReachable: isEasyReachable == freezed
          ? _value.isEasyReachable
          : isEasyReachable // ignore: cast_nullable_to_non_nullable
              as bool,
      xpos: xpos == freezed
          ? _value.xpos
          : xpos // ignore: cast_nullable_to_non_nullable
              as double,
      ypos: ypos == freezed
          ? _value.ypos
          : ypos // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Node implements _Node {
  const _$_Node(
      {required this.importance,
      required this.skill,
      required this.cost,
      required this.color,
      required this.isEasyReachable,
      this.xpos = 0,
      this.ypos = 0});

  factory _$_Node.fromJson(Map<String, dynamic> json) => _$$_NodeFromJson(json);

  @override
  final int importance;
  @override
  final Skill skill;
  @override
  final int cost;
  @override
  final String color;
  @override
  final bool isEasyReachable;
  @override
  @JsonKey()
  final double xpos;
  @override
  @JsonKey()
  final double ypos;

  @override
  String toString() {
    return 'Node(importance: $importance, skill: $skill, cost: $cost, color: $color, isEasyReachable: $isEasyReachable, xpos: $xpos, ypos: $ypos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Node &&
            const DeepCollectionEquality()
                .equals(other.importance, importance) &&
            const DeepCollectionEquality().equals(other.skill, skill) &&
            const DeepCollectionEquality().equals(other.cost, cost) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality()
                .equals(other.isEasyReachable, isEasyReachable) &&
            const DeepCollectionEquality().equals(other.xpos, xpos) &&
            const DeepCollectionEquality().equals(other.ypos, ypos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(importance),
      const DeepCollectionEquality().hash(skill),
      const DeepCollectionEquality().hash(cost),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(isEasyReachable),
      const DeepCollectionEquality().hash(xpos),
      const DeepCollectionEquality().hash(ypos));

  @JsonKey(ignore: true)
  @override
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
      {required final int importance,
      required final Skill skill,
      required final int cost,
      required final String color,
      required final bool isEasyReachable,
      final double xpos,
      final double ypos}) = _$_Node;

  factory _Node.fromJson(Map<String, dynamic> json) = _$_Node.fromJson;

  @override
  int get importance;
  @override
  Skill get skill;
  @override
  int get cost;
  @override
  String get color;
  @override
  bool get isEasyReachable;
  @override
  double get xpos;
  @override
  double get ypos;
  @override
  @JsonKey(ignore: true)
  _$$_NodeCopyWith<_$_Node> get copyWith => throw _privateConstructorUsedError;
}
