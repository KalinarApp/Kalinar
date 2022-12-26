// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Edge _$EdgeFromJson(Map<String, dynamic> json) {
  return _Edge.fromJson(json);
}

/// @nodoc
mixin _$Edge {
  Node get start => throw _privateConstructorUsedError;
  Node get end => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EdgeCopyWith<Edge> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EdgeCopyWith<$Res> {
  factory $EdgeCopyWith(Edge value, $Res Function(Edge) then) =
      _$EdgeCopyWithImpl<$Res, Edge>;
  @useResult
  $Res call({Node start, Node end});

  $NodeCopyWith<$Res> get start;
  $NodeCopyWith<$Res> get end;
}

/// @nodoc
class _$EdgeCopyWithImpl<$Res, $Val extends Edge>
    implements $EdgeCopyWith<$Res> {
  _$EdgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Node,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Node,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NodeCopyWith<$Res> get start {
    return $NodeCopyWith<$Res>(_value.start, (value) {
      return _then(_value.copyWith(start: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NodeCopyWith<$Res> get end {
    return $NodeCopyWith<$Res>(_value.end, (value) {
      return _then(_value.copyWith(end: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EdgeCopyWith<$Res> implements $EdgeCopyWith<$Res> {
  factory _$$_EdgeCopyWith(_$_Edge value, $Res Function(_$_Edge) then) =
      __$$_EdgeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Node start, Node end});

  @override
  $NodeCopyWith<$Res> get start;
  @override
  $NodeCopyWith<$Res> get end;
}

/// @nodoc
class __$$_EdgeCopyWithImpl<$Res> extends _$EdgeCopyWithImpl<$Res, _$_Edge>
    implements _$$_EdgeCopyWith<$Res> {
  __$$_EdgeCopyWithImpl(_$_Edge _value, $Res Function(_$_Edge) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$_Edge(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Node,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Node,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Edge implements _Edge {
  const _$_Edge({required this.start, required this.end});

  factory _$_Edge.fromJson(Map<String, dynamic> json) => _$$_EdgeFromJson(json);

  @override
  final Node start;
  @override
  final Node end;

  @override
  String toString() {
    return 'Edge(start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Edge &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EdgeCopyWith<_$_Edge> get copyWith =>
      __$$_EdgeCopyWithImpl<_$_Edge>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EdgeToJson(
      this,
    );
  }
}

abstract class _Edge implements Edge {
  const factory _Edge({required final Node start, required final Node end}) =
      _$_Edge;

  factory _Edge.fromJson(Map<String, dynamic> json) = _$_Edge.fromJson;

  @override
  Node get start;
  @override
  Node get end;
  @override
  @JsonKey(ignore: true)
  _$$_EdgeCopyWith<_$_Edge> get copyWith => throw _privateConstructorUsedError;
}
